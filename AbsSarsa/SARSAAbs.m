function [Qabs,W,WrealAbs,piAbs,nPassos] = SARSAAbs(environment,locations,DTG,goal,mi,gamma,lambda,initialEpsilon,vu2,initialStates,fatorEval,maxSteps,ACTION,ABSACTIONS)
    
    episodes = max(size(initialStates));
        
    epsilon = initialEpsilon; % parametro epsilon-greedy
       
    [nS,nSabs,nAabs,Tabs,R,sigma] = montarMDP(environment,locations,DTG,goal);
        
    W = zeros(episodes,1);
    nEval = floor(episodes/fatorEval);
    evalPoint = 1;
    WrealAbs = zeros(nEval,1);
    nPassos = zeros(episodes,1);
            
    % Inicializa Q
    Qabs = zeros(nSabs,nAabs);
    Qabs = rand(nSabs,nAabs)*0.05+1;
    
    nVisAbs = zeros(nSabs,nAabs);

    for e=1:episodes
        % Estado inicial
        s = initialStates(e);
        sabs = concreto2Abstrato(s,0,environment,locations,sigma,goal,ACTION,ABSACTIONS);
        aabs = epsilonGreedy(sabs,Qabs,epsilon);
        
        traceAbs = zeros(nSabs,nAabs);
        passos = 0;
        
        % Estado final é sempre o último
        while s ~= nS && passos < maxSteps
            % Take action a, observe r,s'
            [aux sNext] = max(rand < cumsum(Tabs{aabs}(s,:)));
            sabsNext = concreto2Abstrato(sNext,0,environment,locations,sigma,goal,ACTION,ABSACTIONS);
                                    
            % Como é SARSA, já prevê próxima ação
            % epsilon-greedy em s' e a'
            aabsNext = epsilonGreedy(sabsNext,Qabs,epsilon);
                                    
            nVisAbs(sabs,aabs) = nVisAbs(sabs,aabs) + 1;            
            
            % Atualiza traços            
            traceAbs = gamma*lambda*traceAbs;
            traceAbs(sabs,aabs) = 1;
            
            W(e) = W(e) + (gamma^passos)*R(s);
            Qabs = Qabs + mi*traceAbs*(R(s)+gamma*Qabs(sabsNext,aabsNext)-Qabs(sabs,aabs));
                        
            s = sNext;
            sabs = sabsNext;
            aabs = aabsNext;
            passos = passos + 1;                
        end
        
        nPassos(e) = passos;
        epsilon = epsilon*vu2;
        
        if mod(e,fatorEval) == 0
            % Policy Evaluation
            % piAbs deterministica
            [aux piAbs] = max(Qabs,[],2);
            Tpi = zeros(nS);
            for si=1:nS
                siabs = concreto2Abstrato(si,0,environment,locations,sigma,goal,ACTION,ABSACTIONS);                
                Tpi(si,:) = Tabs{piAbs(siabs)}(si,:);
            end        
            V = (eye(nS)-gamma*Tpi)\R';
            WrealAbs(evalPoint,1) = mean(V);
            
            % piAbs epsilon-greedy
%             piAbsProb = zeros(nSabs,nAabs) + epsilon/nAabs;            
%             idx = sub2ind(size(piAbsProb),1:nSabs,piAbs'); %Linear indexing
%             piAbsProb(idx) = piAbsProb(idx) + (1-epsilon);
%                                                 
%             Tpi = zeros(nS);
%             for ai=1:nAabs
%                 piA = piAbsProb(:,ai)'*sigma;
%                 piA = repmat(piA',1,nS);
%                 Tpi = Tpi + Tabs{ai}.*piA;
%             end
%             piV = (eye(nS)-gamma*Tpi)\R';            
%             WrealAbs(evalPoint,2) = mean(piV);            
            evalPoint = evalPoint + 1;
        end
    end    
end
