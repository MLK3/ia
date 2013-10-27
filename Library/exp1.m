% Config
nomeArquivo = 'mapa_fernandez2006.txt';
dir = '~/Documents/Mestrado/Exp1/';
%dir='results/';
gamma = 0.95;
DTG = 5;
episodes = 2000;

% Carrega mapa
[environment,locations] = carregarMapa2(nomeArquivo);

%%
% Escolhe um conjunto de n source tasks
%sourceTasks=[1,23,8,47];
sourceTasks=[1,23,8,47,11,51,35,19,79,108,126,115,76,105,149,166,170,171,173,175,146,162,250,268,234,276,260,261,247,284];
nSource = max(size(sourceTasks));

for o=1:2
    % Ordena aleatoriamente esse conjunto e salva essa ordenação
    sourceTasks=sourceTasks(randperm(nSource));    
    save ([dir 'Ordem' int2str(o)], 'sourceTasks');

    % Inicializa Library
    L0 = zeros(nSource,nSource);
    L25 = zeros(nSource,nSource);
    L50 = zeros(nSource,nSource);
    L75 = zeros(nSource,nSource);
    L1 = zeros(nSource,nSource);
    L = struct;
    LDescription = zeros(1,nSource);

    PiAg = cell(nSource,1);

    for i=1:nSource
        disp(['Source Task ' int2str(i)]);
        % IPMU
        [nState,nAbstract,nAction,T,R,sigma,bInit] = montarMDP(environment,locations,DTG,sourceTasks(1:i));
        [PiAg{i}{1}, currentValue] = AbsProbPI(nState,nAbstract,nAction,T,R,sigma,bInit,gamma);

        % Libraries
        [nState,nAbstract,nAction,T,R,sigma,bInit] = montarMDP(environment,locations,DTG,sourceTasks(i));
        [piCurrent, currentValue] = AbsProbPI(nState,nAbstract,nAction,T,R,sigma,bInit,gamma);

        if (i == 1)
            L(1).Names = cell(5,1);
            L0(i,1) = 1;  L(1).Names{1} = ['L0_o' int2str(o) '_s1'];
            L25(i,1) = 1; L(1).Names{2} = ['L25_o' int2str(o) '_s1'];
            L50(i,1) = 1; L(1).Names{3} = ['L50_o' int2str(o) '_s1'];
            L75(i,1) = 1; L(1).Names{4} = ['L75_o' int2str(o) '_s1'];
            L1(i,1) = 1;  L(1).Names{5} = ['L1_o' int2str(o) '_s1'];
            L(1).Policies{1} = piCurrent;        
            LDescription(1,i) = 1;
        else        
            L0(i,:) = PRPL(L, LDescription, L0(i-1,:),currentValue,i,T,R,gamma,sigma,bInit,0);
            [L,LDescription] = atualizarL(L,LDescription, o, i, piCurrent, L0(i,:), 'L0');
            L25(i,:) = PRPL(L, LDescription, L25(i-1,:),currentValue,i,T,R,gamma,sigma,bInit,0.25);
            [L,LDescription] = atualizarL(L,LDescription, o, i, piCurrent, L25(i,:), 'L25');
            L50(i,:) = PRPL(L, LDescription, L50(i-1,:),currentValue,i,T,R,gamma,sigma,bInit,0.50);
            [L,LDescription] = atualizarL(L,LDescription, o, i, piCurrent, L50(i,:), 'L50');
            L75(i,:) = PRPL(L, LDescription, L75(i-1,:),currentValue,i,T,R,gamma,sigma,bInit,0.75);
            [L,LDescription] = atualizarL(L,LDescription, o, i, piCurrent, L75(i,:), 'L75');
            L1(i,:) = PRPL(L, LDescription, L1(i-1,:),currentValue,i,T,R,gamma,sigma,bInit,1);
            [L,LDescription] = atualizarL(L,LDescription, o, i, piCurrent, L1(i,:), 'L1');
        end    
    end

    save ([dir 'politicas_' 'Ordem' int2str(o)], 'PiAg', 'L0', 'L25', 'L50', 'L75', 'L1', 'L', 'LDescription');
    %%

    targetTasks = [22,7,31,56,78,96,130,138,154,174,181,251,236,278,264];
    %targetTasks = [22,7];
    nTarget = max(size(targetTasks));
    nLib = max(size(L));
    runs = 10;

    disp(['Runs: ' int2str(runs)]);
    disp(['Targets: ' int2str(nTarget)]);
    disp(['Sources: ' int2str(nSource)]);
    disp(['Libraries: ' int2str(nLib)]);

    tempo = 3;
    tempoEstimado = runs * nTarget * ((nSource + nLib)*tempo + 8);
    disp(['Tempo estimado: ' num2str(tempoEstimado/60) ' min']);

    for r=1:runs    
        for t=1:nTarget

            % Q-Learning
            [S,A,T,R] = montarMDPConcreto(environment,locations, targetTasks(t));
            initialStates = zeros(episodes,1);
            nS = max(size(S));
            for e=1:episodes
                initialStates(e,1) = ceil(rand*(nS-1));
            end
            [W,Wreal] = QLearning(S,A,T,R,gamma,initialStates);
            nome = [dir 'QL_t' int2str(targetTasks(t)) '_r' int2str(r)];
            disp(nome);
            save(nome, 'W', 'Wreal');

            % IPMU (Aggregated Policy)
            for i=1:nSource        
                nome = [dir 'Ag_o' int2str(o) '_s' int2str(i) '_t' int2str(targetTasks(t)) '_r' int2str(r)];
                disp(nome);            
                [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),PiAg{i});
                [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
                save(nome, 'W', 'Wgain', 'PiUse');            
            end

            % Libraries
            for i=1:nLib
                abstractLibrary = L(i);                
                [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
                [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
                for j=1:max(size(abstractLibrary.Names))
                    nome = [dir abstractLibrary.Names{j} '_t' int2str(targetTasks(t)) '_r' int2str(r)];
                    disp(nome);
                    save(nome, 'W', 'Wgain', 'PiUse');
                end
            end
        end
    end
end
