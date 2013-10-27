%% ==== Config =====

% Esse script roda só para um número específico s de source tasks.
s = 10;

nomeArquivo = 'mapa_fernandez2006.txt';
dirS = '~/Documents/Mestrado/Exp3/';
dir = '~/Documents/Mestrado/Exp3/';
%dir='results/';
gamma = 0.95;
DTG = 5;
episodes = 2000;

orders = 1:4;
runs = 10:14;
targetTasks = [22,7,31,56,78,96,130,138,154,174,181,251,236,278,264];
%targetTasks = [22];

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
    disp(['Libraries: ' int2str(nLib)]);
    
    tempo = 3;
    tempoEstimado = nRuns * nTarget * (3*tempo + 8);
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
                [W,Wreal] = QLearning(S,A,T,R,gamma,initialStates);
                nome = [dir 'QL_t' int2str(targetTasks(t)) '_r' int2str(r)];
                disp([strOrdem ' ' strRuns ' ' strTarget ' Q-Learning']);
                save(nome, 'W', 'Wreal');
            end

            % IPMU (Generalized Policy)            
            nome = [dir 'Ag_o' int2str(o) '_s' int2str(s) '_t' int2str(targetTasks(t)) '_r' int2str(r)];
            disp([strOrdem ' ' strRuns ' ' strTarget ' Generalized Policy ' int2str(s) '/' int2str(nSource)]);
            [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),PiAg{s});
            [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
            save(nome, 'W', 'Wgain', 'PiUse');
            
            % Libraries
            for i=1:nLib
                disp([strOrdem ' ' strRuns ' ' strTarget ' Library ' int2str(i) '/' int2str(nLib)]);
                abstractLibrary = L(i);
                % Se essa library representa alguma do tamanho de sources
                % correto
                if sum(cell2mat(regexp(L(i).Names, ['L[251].*s' int2str(s)])))                
                    [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
                    [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
                    for j=1:max(size(abstractLibrary.Names))
                        libName = abstractLibrary.Names{j};
                        if regexp(libName, ['L[251].*s' int2str(s)])
                            nome = [dir libName '_t' int2str(targetTasks(t)) '_r' int2str(r)];
                            save(nome, 'W', 'Wgain', 'PiUse');
                        end
                    end
                end
            end
        end
    end
end
