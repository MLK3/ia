function [Qabs,Q,W,Wreal,WrealAbs,piAbs,Wgain,PiUse,nReuse] = PRSARSA3(environment,locations,DTG,goal,mi,gamma,lambda,initialPsi,vu1,initialEpsilon,vu2,initialStates,fatorEval,initialPiabs,ACTION,ABSACTIONS)

    % mi = Taxa de aprendizado         
    episodes = max(size(initialStates));
    maxSteps = 1000;
        
    epsilon2 = 0.10; % parametro epsilon-greedy
    delta = 0.05; % Incremento para politica abstrata
        
    [aux,nSabs,nAabs,Tabs,Rabs,sigma,bInit] = montarMDP(environment,locations,DTG,goal);
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
            
    % Inicializa Q
    Q = rand(nS,nA)*0.05+1;
    Q(nS,:) = 0;    
    Qabs = zeros(nSabs,nAabs);
    if numel(initialPiabs) <= 1        
        piAbs = zeros(nSabs,nAabs) + 1.0/nAabs;
    else        
        piAbs = initialPiabs;
    end
    
    nReuse = zeros(episodes,3);
    nVis = zeros(nS,nA);    
    nVisAbs = zeros(nSabs,nAabs);
    psi = initialPsi;
    epsilon = initialEpsilon;
        
    for e=1:episodes
        % Estado inicial
        s = initialStates(e);                                
        % Escolhe uma ação inicial
        a = epsilonGreedy(s,Q,epsilon);
        
        trace = zeros(nS,nA);
        traceAbs = zeros(nSabs,nAabs);
        passos = 0;
                
        % Estado final é sempre o último
        while s ~= nS && passos < maxSteps
            % Take action a, observe r,s'
            % Aqui é a interação com o ambiente.
            [aux sNext] = max(rand < cumsum(T(s,:,a)));
            [sabs aabs] = concreto2Abstrato(s,a,environment,locations,sigma,goal,ACTION,ABSACTIONS);
                        
            % Como é SARSA, já prevê próxima ação
            % epsilon-greedy em s' e a'
            if rand < psi % Usa Abstrato
               choice = 2;
               sabsNext = concreto2Abstrato(sNext,0,environment,locations,sigma,goal,ACTION,ABSACTIONS);
               [aux aabsNext] = max(rand < cumsum(piAbs(sabsNext,:)));
               aNext = abstrato2Concreto(sNext,aabsNext,environment,locations,ACTION,ABSACTIONS);
            elseif rand > epsilon % Greedy concreto
                 choice = 1;
                [aux aNext] = max(Q(sNext,:));                                
                [sabsNext aabsNext] = concreto2Abstrato(sNext,aNext,environment,locations,sigma,goal,ACTION,ABSACTIONS);
            else % Aleatório
                choice = 3;
                aNext = ceil(rand*nA);
            end
            
            nReuse(e,choice) = nReuse(e,choice) +1;
                        
            nVis(s,a) = nVis(s,a) + 1;
            nVisAbs(sabs,aabs) = nVisAbs(sabs,aabs) + 1;            
            
            % Atualiza traços
            trace = gamma*lambda*trace;                
            traceAbs = gamma*lambda*traceAbs;            
            trace(s,a) = 1;
            traceAbs(sabs,aabs) = 1;
            
            W(e) = W(e) + (gamma^passos)*R(s);
            Q = Q + mi*trace*(R(s)+gamma*(Q(sNext,aNext))-Q(s,a));
            Qabs = Qabs + mi*traceAbs*(R(s)+gamma*Qabs(sabsNext,aabsNext)-Qabs(sabs,aabs));
            
            % Atualiza política
            piBest = zeros(nSabs,nAabs) + epsilon2/nAabs;
            [aux aBest] = max(Qabs,[],2);            
            idx = sub2ind(size(piBest),1:nSabs,aBest'); %Linear indexing
            piBest(idx) = piBest(idx) + (1-epsilon2);
                       
            %for i=1:nSabs
            %    [a aStar] = max(Qabs(i,:));
            %    piBest(i,aStar) = piBest(i,aStar) + (1-epsilon);
            %end

            delta = 1/(1+passos); %Decreasing delta
            path = find(sum(traceAbs,2) > 0);
            %piAbs = (1-delta*traceAbs).*piAbs + (traceAbs*delta).*piBest;
            piAbs(path,:) = (1-delta)*piAbs(path,:) + delta*piBest(path,:);
                        
            s = sNext;
            a = aNext;
            passos = passos + 1;            
        end
        
        psi = psi*vu1;
        epsilon = epsilon*vu2;
                       
        if mod(e,fatorEval) == 0
            % Policy Evaluation
            [aux pi] = max(Q,[],2);
            Tpi = zeros(nS);
            for s=1:nS
                Tpi(s,:) = T(s,:,pi(s));
            end        
            V = (eye(nS)-gamma*Tpi)\R';
            Wreal(evalPoint,1) = mean(V);

            Tpi = zeros(nS);
            for ai=1:nAabs
                piA = piAbs(:,ai)'*sigma;
                piA = repmat(piA',1,nS);
                Tpi = Tpi + Tabs{ai}(:,:).*piA;
            end

            piV = (eye(nS)-gamma*Tpi)\Rabs';
            WrealAbs(evalPoint,1) = mean(piV);
            
            evalPoint = evalPoint + 1;
        end

    end 
    
end
