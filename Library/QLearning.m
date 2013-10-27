function [W,Wreal] = QLearning(S,A,T,R,gamma,initialStates)

    episodes = max(size(initialStates));
    maxSteps = 100;
    
    epsilon = 0.05;

    nS = max(size(S));
    nA = max(size(A));
    
    W = zeros(episodes,1);
    Wreal = zeros(episodes,1);
            
    % inicializa Q
    Q = rand(nS,nA)*0.05+1;
    nVis = zeros(nS,nA);    
        
    for i=1:episodes
        % Estado inicial aleatório
        % s = 1;
        s = initialStates(i);
        passos = 0;
        % Estado final é sempre o último
        while s ~= nS && passos < maxSteps
            if rand > epsilon
                [aux a] = max(Q(s,:));
                optActions = find(Q(s,:)==aux);   %RAFA
                aux = length(optActions);
                a = optActions(ceil(rand*aux));
            else
                a = ceil(rand*nA);
            end

            [aux sNext] = max(rand < cumsum(T(s,:,a)));

            nVis(s,a) = nVis(s,a) + 1;
            alpha = max(1/nVis(s,a),0.05);
            %alpha = .05;  %RAFA

            W(i) = W(i) + (gamma^passos)*R(s);

            Q(s,a) = Q(s,a) + alpha*(R(s)+gamma*max(Q(sNext,:))-Q(s,a));
            s = sNext;
            passos = passos + 1;
        end
       
        [aux pi] = max(Q,[],2);
        Tpi = zeros(nS,nS);
        for state = 1:nS
            Tpi(state,:) = T(state,:,pi(state));
        end
        piV = (eye(nS)-gamma*Tpi)\R';
        Wreal(i) = mean(piV);
        
    end    
    %plot([mean(W,2) cumsum(mean(W,2))./([1:episodes]') mean(Wreal(:,:,1),2) mean(Wgain(:,:,1),2) mean(Wgain(:,:,2),2)])
    %plot([mean(Wreal(:,:,1),2) mean(Wreal(:,:,2),2)  mean(Wreal(:,:,3),2)  mean(Wreal(:,:,4),2)  mean(Wreal(:,:,5),2)  mean(Wreal(:,:,6),2)  mean(Wreal(:,:,7),2)  mean(Wreal(:,:,8),2) mean(Wreal(:,:,9),2) ])
end
