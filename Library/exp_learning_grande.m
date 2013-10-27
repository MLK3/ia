% ==== Config =====
nomeArquivo = 'mapa_grande.txt';
dirS = '~/Documents/Mestrado/Exp3/';
dir = '~/Documents/Mestrado/Exp3/Grande/';
%dir='results/';
gamma = 0.95;
DTG = 5;
episodes = 2000;

o = 1;
runs = 12:70;
targetTasks = [40,86,64,246,228,378,524,533,686,725];

 % ==== Fim Config ====

% Loads
[environment,locations] = carregarMapa2(nomeArquivo);

nRuns = max(size(runs));
nTarget = max(size(targetTasks));

disp(['Runs: ' int2str(nRuns)]);
disp(['Targets: ' int2str(nTarget)]);

load([dirS 'Ordem' int2str(o)]);
load([dirS 'politicas_' 'Ordem' int2str(o)]);

[nLibs, nSource] = size(LDescription);

tempo = 19; %min
tempoEstimado = nRuns * tempo;
disp(['Tempo estimado: ' num2str(tempoEstimado/60) ' h']);

for r=runs

    strRuns = ['Run ' int2str(r) '/' int2str(runs(nRuns))];
    disp([strRuns]);
    for t=1:nTarget

        strTarget = ['Target ' int2str(t) '/' int2str(nTarget)];
        disp([strRuns ' ' strTarget]);

        [S,A,T,R] = montarMDPConcreto(environment,locations, targetTasks(t));
        initialStates = zeros(episodes,1);
        nS = max(size(S));
        for e=1:episodes
            initialStates(e,1) = ceil(rand*(nS-1));
        end
        
        % Q-Learning
        [W,Wreal] = QLearning(S,A,T,R,gamma,initialStates);
        nome = [dir 'QL_t' int2str(targetTasks(t)) '_r' int2str(r)];
        disp([strRuns ' ' strTarget ' Q-Learning']);
        save(nome, 'W', 'Wreal');        

        % IPMU (Generalized Policy)        
        nome = [dir 'Ag_o' int2str(o) '_s' int2str(nSource) '_t' int2str(targetTasks(t)) '_r' int2str(r)];
        disp([strRuns ' ' strTarget ' Generalized Policy']);                
        [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),PiAg{nSource});
        [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
        save(nome, 'W', 'Wgain', 'PiUse');            
        
        % Libraries         
        disp([strRuns ' ' strTarget ' Library 0']);
        indexLib = find(sum(LDescription == repmat(L0(nSource,:),nLibs,1),2) == nSource); % Procura library
        abstractLibrary = L(indexLib);                
        [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
        [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
        nome = [dir 'L0_' 'o' int2str(o) '_s' int2str(nSource) '_t' int2str(targetTasks(t)) '_r' int2str(r)];                    
        save(nome, 'W', 'Wgain', 'PiUse');
        
        disp([strRuns ' ' strTarget ' Library 0.25']);
        indexLib = find(sum(LDescription == repmat(L25(nSource,:),nLibs,1),2) == nSource); % Procura library
        abstractLibrary = L(indexLib);                
        [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
        [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
        nome = [dir 'L25_' 'o' int2str(o) '_s' int2str(nSource) '_t' int2str(targetTasks(t)) '_r' int2str(r)];                    
        save(nome, 'W', 'Wgain', 'PiUse');
        
        disp([strRuns ' ' strTarget ' Library 0.50']);
        indexLib = find(sum(LDescription == repmat(L50(nSource,:),nLibs,1),2) == nSource); % Procura library
        abstractLibrary = L(indexLib);                
        [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
        [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
        nome = [dir 'L50_' 'o' int2str(o) '_s' int2str(nSource) '_t' int2str(targetTasks(t)) '_r' int2str(r)];                    
        save(nome, 'W', 'Wgain', 'PiUse');
        
        disp([strRuns ' ' strTarget ' Library 0.75']);
        indexLib = find(sum(LDescription == repmat(L75(nSource,:),nLibs,1),2) == nSource); % Procura library
        abstractLibrary = L(indexLib);                
        [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
        [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
        nome = [dir 'L75_' 'o' int2str(o) '_s' int2str(nSource) '_t' int2str(targetTasks(t)) '_r' int2str(r)];                    
        save(nome, 'W', 'Wgain', 'PiUse');
        
        disp([strRuns ' ' strTarget ' Library 1']);
        indexLib = find(sum(LDescription == repmat(L1(nSource,:),nLibs,1),2) == nSource); % Procura library
        abstractLibrary = L(indexLib);                
        [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,targetTasks(t),abstractLibrary.Policies);
        [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates);
        nome = [dir 'L1_' 'o' int2str(o) '_s' int2str(nSource) '_t' int2str(targetTasks(t)) '_r' int2str(r)];                    
        save(nome, 'W', 'Wgain', 'PiUse');
    end
end

