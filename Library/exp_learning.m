%% ==== Config =====
nomeArquivo = 'mapa_fernandez2006.txt';
dirS = '~/Documents/Mestrado/Exp3/';
dir = '~/Documents/Mestrado/Exp3/';
%dir='results/';
gamma = 0.95;
DTG = 5;
episodes = 2000;

orders = 1:4;
runs = 15:20;
%targetTasks = [22,7,31,56,78,96,130,138,154,174,181,251,236,278,264];
targetTasks = [138];
%targetTasks = [40,86,64,246,228,378,524,533,686,725];

%% ==== Fim Config ====

% Loads
[environment,locations] = carregarMapa2(nomeArquivo);

nOrders = max(size(orders));
nRuns = max(size(runs));
nTarget = max(size(targetTasks));

disp(['Orders: ' int2str(nOrders)]);
disp(['Runs: ' int2str(nRuns)]);
disp(['Targets: ' int2str(nTarget)]);

for o=orders
    
    strOrdem = ['Ordem ' int2str(o) '/' int2str(orders(nOrders))];
    disp(['--- ' strOrdem ' ---']);
    load([dirS 'Ordem' int2str(o)]);
    load([dirS 'politicas_' 'Ordem' int2str(o)]);
    
    nSource = max(size(sourceTasks));
    nLib = max(size(L));    
    disp(['Sources: ' int2str(nSource)]);
    disp(['Libraries: ' int2str(nLib)]);
    
    tempo = 3;
    tempoEstimado = nRuns * nTarget * ((nSource + nLib)*tempo + 8);
    disp(['Tempo estimado: ' num2str(tempoEstimado/60) ' min']);
    
    for r=runs
        
        strRuns = ['Run ' int2str(r) '/' int2str(runs(nRuns))];
        disp([strOrdem ' ' strRuns]);
        for t=1:nTarget
            
            strTarget = ['Target ' int2str(t) '/' int2str(nTarget)];
            disp([strOrdem ' ' strRuns ' ' strTarget]);

            [S,A,T,R] = montarMDPConcreto(environment,locations, targetTasks(t));
            initialStates = zeros(episodes,1);
            nS = max(size(S));
            for e=1:episodes
                initialStates(e,1) = ceil(rand*(nS-1));
            end
            if (o == 1)
                % Q-Learning                
                nome = [dir 'QL_t' int2str(targetTasks(t)) '_r' int2str(r)];                
                if ~exist([nome '.mat'],'file')
                    disp([strOrdem ' ' strRuns ' ' strTarget ' Q-Learning']);
                    [W,Wreal] = QLearning(S,A,T,R,gamma,initialStates);
                    save(nome, 'W', 'Wreal');
                end
            end

            % IPMU (Generalized Policy)
            for i=1:nSource        
                nome = [dir 'Ag_o' int2str(o) '_s' int2str(i) '_t' int2str(targetTasks(t)) '_r' int2str(r)];                
                if ~exist([nome '.mat'],'file')
                    disp([strOrdem ' ' strRuns ' ' strTarget ' Generalized Policy ' int2str(i) '/' int2str(nSource)]);
                    [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),PiAg{i});
                    [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
                    save(nome, 'W', 'Wgain', 'PiUse');
                end
            end

            % Libraries
            for i=1:nLib
                % Verifica se já existe arquivos com esses nomes
                % Se sim, não tem necessidade rodar
                disp([strOrdem ' ' strRuns ' ' strTarget ' Library ' int2str(i) '/' int2str(nLib)]);
                abstractLibrary = L(i);
                precisaRodar = false;
                for j=1:max(size(abstractLibrary.Names))
                    nome = [dir abstractLibrary.Names{j} '_t' int2str(targetTasks(t)) '_r' int2str(r)];
                    if ~exist([nome '.mat'],'file')
                        precisaRodar = true;
                        break;
                    end
                end
                if precisaRodar
                    [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
                    [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
                    for j=1:max(size(abstractLibrary.Names))
                        nome = [dir abstractLibrary.Names{j} '_t' int2str(targetTasks(t)) '_r' int2str(r)];
                        save(nome, 'W', 'Wgain', 'PiUse');
                    end
                end
            end
        end
    end
end
