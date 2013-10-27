function [Q,Qabs,W,Wreal,WrealAbs,piAbs,nPassos,Wgain,PiUse,nReuse] = SARSA2L_teste(environment,locations,DTG,goal,mi,gamma,lambda,initialEpsilon,vu2,tau,deltaTau,initialStates,fatorEval,maxSteps,ACTION,ABSACTIONS)

    % Só psi e epsilon. Primeiro escolhe epsilon, depois psi.
    % mi = Taxa de aprendizado         
    episodes = max(size(initialStates));
            
    [aux,nSabs,nAabs,Tabs,Rabs,sigma] = montarMDP(environment,locations,DTG,goal);
    [S,A,T,R] = montarMDPConcreto(environment,locations, goal);
        
    nS = max(size(S));
    nA = max(size(A));
    nPi = 2; % 2 politicas: abstrata e concreta
        
    W = zeros(episodes,1);
    Wgain = zeros(episodes,nPi);
    PiUse = zeros(episodes,1);
    
    nEval = floor(episodes/fatorEval);
    evalPoint = 1;
    Wreal = zeros(nEval,1);
    WrealAbs = zeros(nEval,1);
    nPassos = zeros(episodes,nPi);        
    
    % Inicializa Q
    Q = zeros(nS,nA);
    %Q = rand(nS,nA)*0.05+1;
    Q(nS,:) = 0;    
    Qabs = zeros(nSabs,nAabs);
    %Qabs = rand(nSabs,nAabs)*0.05+1;
    
    gainW = zeros(nPi,1);
    nReuse = zeros(nPi,1);
    
    nVis = zeros(nS,nA);    
    nVisAbs = zeros(nSabs,nAabs);
    
    epsilon = initialEpsilon;
        
    for e=1:episodes
        % Estado inicial
        s = initialStates(e);               
        
        % Escolhe politica
        probW = exp(tau*gainW)/sum(exp(tau*gainW));
        [aux indexPi] = max(rand < cumsum(probW));
        PiUse(e) = indexPi;
        nReuse(indexPi) = nReuse(indexPi) + 1;
        
        % Escolhe uma ação inicial
        if (indexPi == 1)
            a = epsilonGreedy(s,Q,epsilon);    
        else
            sabs = concreto2Abstrato(s,0,environment,locations,sigma,goal,ACTION,ABSACTIONS);
            aabs = epsilonGreedy(sabs,Qabs,epsilon);            
            a = abstrato2Concreto(s,aabs,environment,locations,ACTION,ABSACTIONS);
        end        
        
        trace = zeros(nS,nA);
        traceAbs = zeros(nSabs,nAabs);
        passos = 0;
                
        % Estado final é sempre o último
        while s ~= nS && passos < maxSteps
                        
            [sabs aabs] = concreto2Abstrato(s,a,environment,locations,sigma,goal,ACTION,ABSACTIONS);
            
            % Take action a, observe r,s'            
            [aux sNext] = max(rand < cumsum(T(s,:,a)));
            sabsNext = concreto2Abstrato(sNext,0,environment,locations,sigma,goal,ACTION,ABSACTIONS);
            
            % Como é SARSA, já prevê próxima ação
            % epsilon-greedy em s' e a'
            if indexPi == 1
                aNext = epsilonGreedy(sNext,Q,epsilon);
                [aux aabsNext] = concreto2Abstrato(sNext,aNext,environment,locations,sigma,goal,ACTION,ABSACTIONS);
            else                 
                aabsNext = epsilonGreedy(sabsNext,Qabs,1);
                aNext = abstrato2Concreto(sNext,aabsNext,environment,locations,ACTION,ABSACTIONS);            
            end
                                                
            nVis(s,a) = nVis(s,a) + 1;
            nVisAbs(sabs,aabs) = nVisAbs(sabs,aabs) + 1;
            
            % Atualiza traços
            trace = gamma*lambda*trace;                
            traceAbs = gamma*lambda*traceAbs;            
            trace(s,a) = 1;
            traceAbs(sabs,aabs) = 1;
            
            W(e) = W(e) + (gamma^passos)*R(s);
            Q = Q + mi*trace*(R(s)+gamma*Q(sNext,aNext)-Q(s,a));
            if indexPi == 1 % Só atualiza abstrato com experiência do concreto.
                Qabs = Qabs + mi*traceAbs*(R(s)+gamma*Qabs(sabsNext,aabsNext)-Qabs(sabs,aabs));
            end
            
            s = sNext;
            a = aNext;
            passos = passos + 1;            
        end
                
        epsilon = epsilon*vu2;
        nPassos(e,indexPi) = passos;
        
        tau = tau + deltaTau;
        gainW(indexPi) = (gainW(indexPi)*nReuse(indexPi) + W(e)) / (nReuse(indexPi) + 1);
        for k=1:nPi
            Wgain(e,k) = gainW(k);
        end
                               
        if mod(e,fatorEval) == 0
            % Policy Evaluation
            [aux pi] = max(Q,[],2);
            Tpi = zeros(nS);
            for si=1:nS
                Tpi(si,:) = T(si,:,pi(si));
            end        
            V = (eye(nS)-gamma*Tpi)\R';
            Wreal(evalPoint,1) = mean(V);

            % piAbs deterministica
            [aux piAbs] = max(Qabs,[],2);
            Tpi = zeros(nS);
            for si=1:nS
                siabs = concreto2Abstrato(si,0,environment,locations,sigma,goal,ACTION,ABSACTIONS);                
                Tpi(si,:) = Tabs{piAbs(siabs)}(si,:);
            end        
            V = (eye(nS)-gamma*Tpi)\R';
            WrealAbs(evalPoint,1) = mean(V);
            
            evalPoint = evalPoint + 1;
        end
    end    
    [aux piAbs] = max(Qabs,[],2);    
end
