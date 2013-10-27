% ==== Config ====
nomeArquivo = 'mapa_fernandez2006.txt';
dir = '~/Documents/Mestrado/Exp3/';
%dir='results/';
gamma = 0.95;
DTG = 5;
orders = 4;

% Escolhe um conjunto de n source tasks
%sourceTasks=[1,23,8,47];
sourceTasks=[1,23,47,11,51,35,19,108,126,115,105,149,171,175,162,250,234,276,261,247];

% ATENCAO COM OS PARAMETROS, PARA NAO SOBRESCREVER ARQUIVOS

% ==== Fim Config ====

% Carrega mapa
[environment,locations] = carregarMapa2(nomeArquivo);
nSource = max(size(sourceTasks));
clockId = tic;
for o=orders
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
        clock2 = tic;
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
        disp(['Elapsed time: ' num2str(toc(clock2)) 's']);
    end
    
    save ([dir 'politicas_' 'Ordem' int2str(o)], 'PiAg', 'L0', 'L25', 'L50', 'L75', 'L1', 'L', 'LDescription');    
    disp(['Total elapsed time: ' num2str(toc(clockId)) 's']);
end
