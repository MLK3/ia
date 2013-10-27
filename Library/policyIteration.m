function [policy,Vpolicy] = policyIteration(S,A,T,R,gamma)

	nState = size(S,1);
	nAction = size(A,1);
	
	delta = 0.5;
	epsilon = 0.1;
	
	% Inicialization
	piCurrent = rand(nState,nAction);
	for s=1:nState
   		piCurrent(s,:) = piCurrent(s,:)/sum(piCurrent(s,:));
    end
	
	for iteration=1:10

		% Policy Evaluation
		Tpi = zeros(nState);
		for a=1:nAction
		    piA = repmat(piCurrent(:,a),1,nState);
		    Tpi = Tpi + T(:,:,a) .* piA;
		end
						
		V = (eye(nState)-gamma*Tpi)\R';
		Vpi = mean(V);
		
		disp([iteration Vpi]);
	
		% Policy Improvement
		Q = zeros(nState,nAction);
		for a=1:nAction
			Q(:,a) = ((R(:,a) + gamma*T(:,:,a)*V)');
		end
        [bla aStar] = max(Q,[],2); % Pega os indices(acoes) do maximo de cada linha
        
        piBest = zeros(nState,nAction);
        for s=1:nState
            piBest(s,:) = epsilon/nAction;
            piBest(s,aStar(s)) = piBest(s,aStar(s)) + (1-epsilon);
        end
        piNext = (1-delta)*piCurrent + delta*piBest;
        piCurrent = piNext;
								
		%for s=1:nState
    	%	piCurrent(s,aStar(s)) = piCurrent(s,aStar(s)) + delta;
		%    piCurrent(s,:) = piCurrent(s,:)/sum(piCurrent(s,:));
		%end
	end
	
	policy = piCurrent;
	% Policy Evaluation
	Tpi = zeros(nState);
	for a=1:nAction
	    piA = repmat(policy(:,a),1,nState);
	    Tpi = Tpi + T(:,:,a) .* piA;
	end
						
	Vpolicy = (eye(nState)-gamma*Tpi)\R';
end
