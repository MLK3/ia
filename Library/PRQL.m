function [W,Wgain,Wreal,PiUse] = PRQL(S,A,T,R,gamma,library,initialStates)

    episodes = max(size(initialStates));
    maxSteps = 100; % Fernandez2006
        
    epsilon = 0.05;
    vu = 0.95; % Fernandez2006

    nS = max(size(S));
    nA = max(size(A));
    nPi = max(size(library));

    W = zeros(episodes,1);    
    Wgain = zeros(episodes,nPi);
    Wreal = zeros(episodes,1);
    PiUse = zeros(episodes,1);
    
    tau = 0;
    %deltaTau = 0.05; % Fernandez2006
    deltaTau = 0.005;

    % inicializa Q e gainW
    Q = rand(nS,nA)*0.05+1;
    gainW = zeros(nPi,1);
    nVis = zeros(nS,nA);    
    nReuse = zeros(nPi,1);
    
    for i=1:episodes
    %     if mod(i,episodes*0.01) == 0
    %         disp(i/episodes)
    %     end
        psi = 1;
        
        % Escolhe politica
        probW = exp(tau*gainW)/sum(exp(tau*gainW));
        [aux indexPi] = max(rand < cumsum(probW));
        chosenPi = library{indexPi};
        PiUse(i) = indexPi;
        nReuse(indexPi) = nReuse(indexPi) + 1;

        % Estado inicial aleatório
        % s = 1;
        s = initialStates(i);
        passos = 0;
        while s ~= nS && passos < maxSteps
            if indexPi == 1
                %[aux a] = max(Q(s,:));
                 if rand > epsilon
                     [aux a] = max(Q(s,:));
                 else
                     a = ceil(rand*nA);
                 end
            else
                if rand > psi % epsilon-greedy
                    %epsilon = 1 - psi; % Fernandez usou assim.
                    if rand > epsilon % Explotation 
                        [aux a] = max(Q(s,:));
                    else % Exploration (random)
                        a = ceil(rand*nA);
                    end
                else % Reuso
                    [aux a] = max(rand < cumsum(chosenPi(s,:)));
                end
            end

            [aux sNext] = max(rand < cumsum(T(s,:,a)));

            nVis(s,a) = nVis(s,a) + 1;
            alpha = max(1/nVis(s,a),0.05);

            W(i) = W(i) + (gamma^passos)*R(s);

            Q(s,a) = Q(s,a) + alpha*(R(s)+gamma*max(Q(sNext,:))-Q(s,a));
            s = sNext;
            passos = passos + 1;
            psi = psi*vu;
        end
        tau = tau + deltaTau;
        %alpha2 = 1/nReuse(indexPi);
        %gainW(indexPi) = gainW(indexPi) + alpha2*(W(i)-gainW(indexPi));
        gainW(indexPi) = (gainW(indexPi)*nReuse(indexPi) + W(i)) / (nReuse(indexPi) + 1);
        for k=1:nPi
            Wgain(i,k) = gainW(k);
        end

%         % Essa avaliação do valor (Wreal) é lenta.
%         [aux pi] = max(Q,[],2);
%         Tpi = zeros(nS,nS);
%         for state = 1:nS
%             Tpi(state,:) = T(state,:,pi(state));
%         end
%         piV = (eye(nS)-gamma*Tpi)\R';
%         Wreal(i) = mean(piV);
        
    end    
    %plot([mean(W,2) cumsum(mean(W,2))./([1:episodes]') mean(Wreal(:,:,1),2) mean(Wgain(:,:,1),2) mean(Wgain(:,:,2),2)])
    % plot([mean(Wreal(:,:,1),2) mean(Wreal(:,:,2),2)  mean(Wreal(:,:,3),2)  mean(Wreal(:,:,4),2)  mean(Wreal(:,:,5),2)  mean(Wreal(:,:,6),2)  mean(Wreal(:,:,7),2)  mean(Wreal(:,:,8),2) mean(Wreal(:,:,9),2) ])
end
