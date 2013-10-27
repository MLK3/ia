function [S,A,T,R] = montarMDPConcreto(environment,locations, goals)
	error = 0.05;	
	definitions; % P e ACTION

	%Abstract States
	%Oposite to Goal
	%Empty 1
	%Far Door 2
	%See Room 4
	%See Corridor 8

	%Head to Goal
	%Empty 16
	%Far Door 32
	%See Room 64
	%See Corridor 128

	%In Room 256

	%Near to Goal 512

	% Concrete Actions	
	concreteActions = [ACTION.N; ACTION.S; ACTION.E; ACTION.W];

	nAction = size(concreteActions,1);
	nState = size(locations,1);

	for goal=goals
		T = zeros(nState,nState,nAction);
		for a=1:nAction
		    for s=1:nState
		        i = locations(s,1);
		        j = locations(s,2);
		        actual = environment{i,j};
		        count = 0;
		        
		        %South        
		        if actual.S ~= P.W && a == ACTION.S
		            next = environment{i+1,j};
		            if next.In == P.D
						next = environment{i+2,j};
					end
		            T(s,:,a) = T(s,:,a)*count/(count+1);
		            T(s,next.L,a) = 1/(count+1);
		            count = count+1;
		        end

		        %North        
		        if actual.N ~= P.W && a == ACTION.N
		            next = environment{i-1,j};
		            if next.In == P.D
						next = environment{i-2,j};
					end
		            T(s,:,a) = T(s,:,a)*count/(count+1);
		            T(s,next.L,a) = 1/(count+1);
		            count = count+1;
		        end
		        
		        %East        
		        if actual.E ~= P.W && a == ACTION.E
		            next = environment{i,j+1};
		            if next.In == P.D
						next = environment{i,j+2};
					end
		            T(s,:,a) = T(s,:,a)*count/(count+1);
		            T(s,next.L,a) = 1/(count+1);
		            count = count+1;
		        end

		        %West        
		        if actual.W ~= P.W && a == ACTION.W
		            next = environment{i,j-1};
		            if next.In == P.D
						next = environment{i,j-2};
					end
		            T(s,:,a) = T(s,:,a)*count/(count+1);
		            T(s,next.L,a) = 1/(count+1);
		            count = count+1;
		        end
		        
		        T(s,:,a) = T(s,:,a)*(1-error);
		        T(s,s,a) = 0;
		        T(s,s,a) = 1 - sum(T(s,:,a));
		    end
		end
		%T(goal,:,:) = 1/nState;

		totalT = zeros(0,0,nAction);
		[i j] = size(totalT(:,:,1));
		auxT = zeros(i+nState,j+nState,nAction);
		for k=1:nAction
		    auxT(:,:,k) = [totalT(:,:,k) zeros(i,nState); zeros(nState,j) T(:,:,k)];
		end
		totalT = auxT;
	end

	%chega na meta e para
	[i j] = size(totalT(:,:,1));
	auxT = zeros(i+1,j+1,nAction);
	for k=1:nAction
		auxT(:,:,k) = [totalT(:,:,k) zeros(i,1); zeros(1,j) 1];
	end
	totalT = auxT;
	count = 0;
	R = zeros(1,i+1);
	for goal=goals
		totalT(goal + count,:,:) = 0;
		totalT(goal + count,i+1,:) = 1;
		R(goal + count) = 1;
		count = count + nState;
	end

	nState = i+1;

	bInit = ones(nState,1)/(nState-1);
	bInit(nState) = 0;

	S = [1:1:nState]';
	A = concreteActions;
	T = totalT;
	
end

	
