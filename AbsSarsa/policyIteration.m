function [policy,Vpolicy] = policyIteration(S,A,T,R,gamma)

	nS = max(size(S));
	nA = max(size(A));
	
	% Inicialization
	piCurrent = ceil(rand(nS,1)*nA);
    
    Vant = 0;
	
	for iteration=1:100        
        
		% Policy Evaluation
		Tpi = zeros(nS);
        for s=1:nS
            Tpi(s,:) = T(s,:,piCurrent(s));
        end						
        V = (eye(nS)-gamma*Tpi)\R';
        Vpi = mean(V);
        disp([iteration Vpi]);
        
        dif = Vpi - Vant;
        if dif < 0.0001
            break;
        end
	
		% Policy Improvement
		Q = zeros(nS,nA);
		for a=1:nA
			Q(:,a) = (R' + gamma*T(:,:,a)*V)';
		end
        [aux piCurrent] = max(Q,[],2); % Pega os indices(acoes) do maximo de cada linha
        
        Vant = Vpi;
	end
	
	policy = piCurrent;
	Tpi = zeros(nS);
    for s=1:nS
        Tpi(s,:) = T(s,:,policy(s));
    end    						
	Vpolicy = (eye(nS)-gamma*Tpi)\R';
end
