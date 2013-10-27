function [Q,W,Wreal,nVis] = SARSA(S,A,T,R,mi,gamma,lambda,initialEpsilon,vu2,initialStates,fatorEval,maxSteps)

    % FatorEval = 1 a cada quantos episódios vai calcular o valor real.

    episodes = max(size(initialStates));
      
    epsilon = initialEpsilon;

    nS = max(size(S));
    nA = max(size(A));
    
    W = zeros(episodes,1);
    
    nEval = floor(episodes/fatorEval);
    evalPoint = 1;
    Wreal = zeros(nEval,1);
            
    % inicializa Q
    Q = zeros(nS,nA);
    Q = rand(nS,nA)*0.05+1;
    Q(nS,:) = 0;
    nVis = zeros(nS,nA);
    
    RT = R';
        
    for i=1:episodes
        % Estado inicial
        s = initialStates(i);
        a = epsilonGreedy(s,Q,epsilon);
        trace = zeros(nS,nA);
        passos = 0;
        
        % Estado final é sempre o último
        while s ~= nS && passos < maxSteps

            % Take action a, observe r,s'
            [aux sNext] = max(rand < cumsum(T(s,:,a)));
            
            % epsilon-greedy em s' e a'
            aNext = epsilonGreedy(sNext,Q,epsilon);

            nVis(s,a) = nVis(s,a) + 1;           
             
            W(i) = W(i) + (gamma^passos)*R(s);

            trace = gamma*lambda*trace;
            trace(s,a) = 1;            
            Q = Q + mi*trace*(R(s)+gamma*(Q(sNext,aNext))-Q(s,a));
            
            s = sNext;
            a = aNext;
            passos = passos + 1;
        end
        
        if mod(i,fatorEval) == 0
            % Policy Evaluation
            [aux pi] = max(Q,[],2);
            Tpi = zeros(nS);
            for si=1:nS
                Tpi(si,:) = T(si,:,pi(si));
            end        
            V = (eye(nS)-gamma*Tpi)\RT;
            Wreal(evalPoint) = mean(V);
            evalPoint = evalPoint + 1;            
        end
        
        epsilon = epsilon*vu2;
    end    
end
