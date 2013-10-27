%% ==== Config =====
dir = '~/Documents/Mestrado/AAMAS/';
%dir='results/';
mi = 0.05;            % taxa de aprendizado
gamma = 0.95;         % fator de disconto
lambda = 0.9;         % Sarsa(lambda)
initialPsi = 1;       % Psi, taxa abstrato-aleatório
vu1 = 0.95;           % Decaimento de psi
initialEpsilon = 0.20;   % Epsilon, taxa explotação-exploração
vu2 = 1;              % Decaimento de epsilon
tau = 0;
deltaTau = 0.05;
DTG = 5;              % Max. distance to goal para ser considerado perto

episodes = 500;
maxSteps = 500;
fatorEval = 10;

reuse = 0;

runs = 1:1;
%targetTasks = [4,12,81,95,181]; % 4 = (5,2); 12 = (17,2); 95 = (2,17); 81 = (8,14); 181 = (14,29)
targetTasks=[4];

%% ==== Fim Config ====
definitions;
% Loads
env5;

nRuns = max(size(runs));
nTarget = max(size(targetTasks));
nEval = floor(episodes/fatorEval);

disp(['Runs: ' int2str(nRuns)]);
disp(['Targets: ' int2str(nTarget)]);

WSm = zeros(episodes,1);
WSrealm = zeros(nEval,1);
WAm = zeros(episodes,1);
WArealAbsm = zeros(nEval,1);
W2m = zeros(episodes,1);
W2realm = zeros(nEval,1);
W2realAbsm = zeros(nEval,1);
WLm = zeros(episodes,1);
WLrealm = zeros(nEval,1);
WLrealAbsm = zeros(nEval,1);
WRm = zeros(episodes,1);
WRrealm = zeros(nEval,1);
WRrealAbsm = zeros(nEval,1);
WTm = zeros(episodes,1);

for r=runs
        
    strRuns = ['Run ' int2str(r) '/' int2str(runs(nRuns))];
    
    if reuse == 0
        piAbs = 0;
        for t=1:nTarget
            strTarget = ['Target ' int2str(t) '/' int2str(nTarget)];
            disp([strRuns ' ' strTarget]);

            k = (r-min(runs))*nTarget + t;
            [S,A,T,R] = montarMDPConcreto(environment,locations, targetTasks(t));
            initialStates = zeros(episodes,1);
            nS = max(size(S));
            for e=1:episodes
                initialStates(e,1) = ceil(rand*(nS-1));        
            end

            % SARSA
            nome = [dir 'SARSA_t' int2str(targetTasks(t)) '_r' int2str(r)];        
            %load(nome, 'initialStates', 'WS', 'WSreal', 'W2', 'W2real', 'W2realAbs', 'WL', 'WLreal', 'WLrealAbs');
            [QS,WS,WSreal,nVis] = SARSA(S,A,T,R,mi,gamma,lambda,initialEpsilon,vu2,initialStates,fatorEval,maxSteps);
    %         save(nome, 'QS', 'WS', 'WSreal', 'nVis');

            WSm = WSm + (WS - WSm)/k;
            WSrealm = WSrealm + (WSreal - WSrealm)/k;

            % Sarsa Abs        
            %[QAabs,WA,WArealAbs,piAbsA,nPassosA] = SARSAAbs(environment,locations,DTG,targetTasks(t),mi,gamma,lambda,initialEpsilon,vu2,initialStates,fatorEval,maxSteps,ACTION,ABSACTIONS);
            %WAm = WAm + (WA - WAm)/k;
            %WArealAbsm = WArealAbsm + (WArealAbs - WArealAbsm)/k;
                    
            % Sarsa concreto + aprende Qabs
    %         [Q2,Q2abs,W2,W2real,W2realAbs,piAbs2,nPassos2] = SARSA2(environment,locations,DTG,targetTasks(t),mi,gamma,lambda,initialEpsilon,vu2,initialStates,fatorEval,maxSteps,ACTION,ABSACTIONS);
            %W2m = W2m + (W2 - W2m)/k;
            %W2realm = W2realm + (W2real - W2realm)/k;
            %W2realAbsm = W2realAbsm + (W2realAbs - W2realAbsm)/k;
            
            % Sarsa-2Level
            [QL,QLabs,WL,WLreal,WLrealAbs,piAbsL,nPassosL,WLgain,PiUseL,nReuseL] = SARSA2L(environment,locations,DTG,targetTasks(t),mi,gamma,lambda,initialEpsilon,vu2,tau,deltaTau,initialStates,fatorEval,maxSteps,ACTION,ABSACTIONS);
            WLm = WLm + (WL - WLm)/k;
            WLrealm = WLrealm + (WLreal - WLrealm)/k;
            WLrealAbsm = WLrealAbsm + (WLrealAbs - WLrealAbsm)/k;
            
            [QT,QTabs,WT,WTreal,WTrealAbs,piAbsL,nPassosT,WTgain,PiUseT,nReuseT] = SARSA2L_teste(environment,locations,DTG,targetTasks(t),mi,gamma,lambda,initialEpsilon,vu2,tau,deltaTau,initialStates,fatorEval,maxSteps,ACTION,ABSACTIONS);
            WTm = WTm + (WT - WTm)/k;

            nome2 = [dir 'SARSAQ_t' int2str(targetTasks(t)) '_r' int2str(r)];        
%            save(nome2);
        end
    else
        disp('Reuso');
        for t=1:nTarget
            strTarget = ['Target ' int2str(t) '/' int2str(nTarget)];
            disp([strRuns ' ' strTarget]);
            load([dir 'SARSA_t' int2str(targetTasks(t)) '_r' int2str(r)],'initialStates', 'WL');
            WLm = WLm + (WL - WLm)/((r-min(runs))*nTarget + t);
%             WSm = WSm + (WS - WSm)/((r-min(runs))*nTarget + t);
            
            sourceTasks = [targetTasks(1:t-1) targetTasks(t+1:end)];
            library = cell(nTarget-1,1);
            for s=1:(nTarget-1)
                % Sarsa-Reuse
                nomeSource = [dir 'SARSA_t' int2str(sourceTasks(s)) '_r' int2str(r)];                
                load(nomeSource, 'piAbsL');
                library{s} = piAbsL;
            end
            nome = [dir 'SARSAReuse_t' int2str(targetTasks(t)) '_r' int2str(r)];
            %disp(nome);  
            [QR,QRabs,WR,WRreal,WRrealAbs,piAbsR,nPassosR,WRgain,PiUseR,nReuseR,WRprob] = SARSAReuse(environment,locations,DTG,targetTasks(t),mi,gamma,lambda,initialEpsilon,vu2,tau,deltaTau,initialStates,fatorEval,maxSteps,library,ACTION,ABSACTIONS);
            k = (r-min(runs))*nTarget + t;
            WRm = WRm + (WR - WRm)/k;
            WRrealm = WRrealm + (WRreal - WRrealm)/k;
            WRrealAbsm = WRrealAbsm + (WRrealAbs - WRrealAbsm)/k;
            save(nome);            
        end
    end
    
%     plot(cumsum(WSm)./(1:episodes)', 'r');
%     hold on;
%     plot(cumsum(WAm)./(1:episodes)', 'g');
%     plot(cumsum(W2m)./(1:episodes)', 'm');
%     plot(cumsum(WLm)./(1:episodes)', 'k');
%     plot(cumsum(WRm)./(1:episodes)', 'b');
%     hold off;    
end

% save('Sarsa_all', 'WSrealm','WSm','WSrealm','WAm','WArealAbsm','W2m','W2realm','W2realAbsm','WLm','WLrealm','WLrealAbsm','WRm','WRrealm','WRrealAbsm');

%%
plot(WSrealm, 'r');
hold on;
plot(WArealAbsm, 'g');
%plot(W2realAbsm, 'm');
%plot(WLrealm, 'k');
plot(WLrealAbsm, 'b');
%plot(WRrealm, 'b');
hold off;
%%

%%
plot(cumsum(WSm)./(1:episodes)', 'r');
hold on;
%plot(cumsum(WAm)./(1:episodes)', 'g');
%plot(cumsum(W2m)./(1:episodes)', 'm');
plot(cumsum(WLm)./(1:episodes)', 'b');
%hold on;
plot(cumsum(WTm)./(1:episodes)', 'g');
hold off;
%%

%plot([nReuse(:,1)./sum(nReuse,2) nReuse(:,2)./sum(nReuse,2) nReuse(:,3)./sum(nReuse,2)]);

%[nS,nSabs,nAabs,Tabs,R,sigma,bInit] = montarMDP(environment,locations,DTG,4);
%[piCurrent,currentValue] = AbsProbPI(nS,nSabs,nAabs,Tabs,R,sigma,bInit,gamma);
