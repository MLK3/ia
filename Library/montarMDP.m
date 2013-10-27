function [nState,nAbstract,nAction,T,R,sigma,bInit] = montarMDP(environment,locations,DTG,goals)

	% Monta um MDP a partir de um "environment". 
	% Quando existe porta, o espaço delas é ignorado e as transições são feitas diretamente entre
	% os estados adjacentes a porta.
		
    error = 0.05;
    nAbstract = 1024;

    definitions;

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

    %Abstract Actions
    %Oposite to Goal
    auxActions = [P.E 0; %Empty 1
    P.Df 0; %Far Door 2
    P.Sr 0; %See Room 4
    P.Sc 0; %See Corridor 8

    %Head to Goal
    P.E 1; %Empty 1
    P.Df 1; %Far Door 2
    P.Sr 1; %See Room 3
    P.Sc 1]; %See Corridor 4
        
    [nAction x] = size(auxActions);
    [nState x] = size(locations);

    totalSigma = zeros(nAbstract,0);
    totalT = cell(nAction,1);
    for goal=goals
        T = cell(nAction,1);
        for act=1:nAction
			T{act} = sparse(nState,nState);
        end
        for a=1:nAction
            for s=1:nState
                i = locations(s,1);
                j = locations(s,2);
                x_goal = locations(goal,1);
                y_goal = locations(goal,2);
                actual = environment{i,j};            
                distance = abs(i-x_goal) + abs(j-locations(goal,2));
                count = 0;
                
                %South        
                if actual.S == auxActions(a,1)
                    next = environment{i+1,j};
                    % Tratando portas (devem ser "puladas")
                    if next.In == P.D
                    	next = environment{i+2,j};
                   	end
                    dist_next = abs(i+1-x_goal) + abs(j-y_goal);
                    if (distance > dist_next && auxActions(a,2) == 1) || (distance < dist_next && auxActions(a,2) == 0)
                        T{a}(s,:) = T{a}(s,:)*count/(count+1);
                        T{a}(s,next.L) = 1/(count+1);
                        count = count+1;
                    end
                end

                %North        
                if actual.N == auxActions(a,1)
                    next = environment{i-1,j};
                    if next.In == P.D
                    	next = environment{i-2,j};
                   	end
                    dist_next = abs(i-1-x_goal) + abs(j-y_goal);
                    if (distance > dist_next && auxActions(a,2) == 1) || (distance < dist_next && auxActions(a,2) == 0)
                        T{a}(s,:) = T{a}(s,:)*count/(count+1);
                        T{a}(s,next.L) = 1/(count+1);
                        count = count+1;
                    end
                end

                %East        
                if actual.E == auxActions(a,1)
                    next = environment{i,j+1};
                    if next.In == P.D
                    	next = environment{i,j+2};
                   	end
                    dist_next = abs(i-x_goal) + abs(j+1-y_goal);
                    if (distance > dist_next && auxActions(a,2) == 1) || (distance < dist_next && auxActions(a,2) == 0)
                        T{a}(s,:) = T{a}(s,:)*count/(count+1);
                        T{a}(s,next.L) = 1/(count+1);
                        count = count+1;
                    end
                end

                %West        
                if actual.W == auxActions(a,1)
                    next = environment{i,j-1};
                    if next.In == P.D
                    	next = environment{i,j-2};
                   	end
                    dist_next = abs(i-x_goal) + abs(j-1-y_goal);
                    if (distance > dist_next && auxActions(a,2) == 1) || (distance < dist_next && auxActions(a,2) == 0)
                        T{a}(s,:) = T{a}(s,:)*count/(count+1);
                        T{a}(s,next.L) = 1/(count+1);
                        count = count+1;
                    end
                end
                
                T{a}(s,:) = T{a}(s,:)*(1-error);
                T{a}(s,s) = 0;
                T{a}(s,s) = 1 - sum(T{a}(s,:));
            end
        end
        for act=1:nAction
			T{act}(goal,:) = 1/nState;
		end
		
        sigma = zeros(nAbstract,nState);
        for s=1:nState
            auxSum = zeros(1,10);
            i = locations(s,1);
            j = locations(s,2);
            actual = environment{i,j};
            distance = abs(i-locations(goal,1)) + abs(j-locations(goal,2));
            
            if actual.In == P.R
                auxSum(9) = 1;
            end
            
            if distance <= DTG
                auxSum(10) = 1;
            end
                
            %South
            if distance < abs(i+1-locations(goal,1)) + abs(j-locations(goal,2))
                if actual.S == P.E 
                    auxSum(1) = 1;
                elseif actual.S == P.Df
                    auxSum(2) = 1;
                elseif actual.S == P.Sr
                    auxSum(3) = 1;
                elseif actual.S == P.Sc
                    auxSum(4) = 1;
                end
            else
                if actual.S == P.E 
                    auxSum(5) = 1;
                elseif actual.S == P.Df
                    auxSum(6) = 1;
                elseif actual.S == P.Sr
                    auxSum(7) = 1;
                elseif actual.S == P.Sc
                    auxSum(8) = 1;
                end
            end

            %North
            if distance < abs(i-1-locations(goal,1)) + abs(j-locations(goal,2))
                if actual.N == P.E 
                    auxSum(1) = 1;
                elseif actual.N == P.Df
                    auxSum(2) = 1;
                elseif actual.N == P.Sr
                    auxSum(3) = 1;
                elseif actual.N == P.Sc
                    auxSum(4) = 1;
                end
            else
                if actual.N == P.E 
                    auxSum(5) = 1;
                elseif actual.N == P.Df
                    auxSum(6) = 1;
                elseif actual.N == P.Sr
                    auxSum(7) = 1;
                elseif actual.N == P.Sc
                    auxSum(8) = 1;
                end
            end

            %East
            if distance < abs(i-locations(goal,1)) + abs(j+1-locations(goal,2))
                if actual.E == P.E 
                    auxSum(1) = 1;
                elseif actual.E == P.Df
                    auxSum(2) = 1;
                elseif actual.E == P.Sr
                    auxSum(3) = 1;
                elseif actual.E == P.Sc
                    auxSum(4) = 1;
                end
            else
                if actual.E == P.E 
                    auxSum(5) = 1;
                elseif actual.E == P.Df
                    auxSum(6) = 1;
                elseif actual.E == P.Sr
                    auxSum(7) = 1;
                elseif actual.E == P.Sc
                    auxSum(8) = 1;
                end
            end

            %West
            if distance < abs(i-locations(goal,1)) + abs(j-1-locations(goal,2))
                if actual.W == P.E 
                    auxSum(1) = 1;
                elseif actual.W == P.Df
                    auxSum(2) = 1;
                elseif actual.W == P.Sr
                    auxSum(3) = 1;
                elseif actual.W == P.Sc
                    auxSum(4) = 1;
                end
            else
                if actual.W == P.E 
                    auxSum(5) = 1;
                elseif actual.W == P.Df
                    auxSum(6) = 1;
                elseif actual.W == P.Sr
                    auxSum(7) = 1;
                elseif actual.W == P.Sc
                    auxSum(8) = 1;
                end
            end
            
            sigma(2.^[0:9]*auxSum',s) = 1;

        end
                
        for k=1:nAction
			[i j] = size(totalT{k});
			auxT = [totalT{k}(:,:) zeros(i,nState); zeros(nState,j) T{k}];
			totalT{k} = auxT;
        end        
        totalSigma = [totalSigma sigma];
    end

    %chega na meta e para
    totalSigma = [totalSigma ones(nAbstract,1)/nAbstract];    
    [i j] = size(totalT{1});
    for k=1:nAction        
        auxT = [totalT{k} zeros(i,1); zeros(1,j) 1];
        totalT{k} = auxT;
    end
    
    count = 0;
    R = zeros(1,i+1);
    for goal=goals
        for k=1:nAction
            totalT{k}(goal + count,:) = 0;
            totalT{k}(goal + count,i+1) = 1;
        end
        R(goal + count) = 1;
        count = count + nState;
    end

    nState = i+1;

    T = totalT;
    sigma = totalSigma;
    
    % Distribuição uniforme de estados iniciais (exceto o ultimo, que é o de absorcao)
    bInit = ones(nState,1)/(nState-1);
    bInit(nState) = 0;
end
