function [sabs,aabs] = concreto2Abstrato(s,a,environment,locations,sigma,goal,ACTION,ABSACTIONS)
            
    sabs = find(sigma(:,s) > 0);
    if numel(sabs) > 1
        sabs = sabs(ceil(rand*numel(sabs)));
        aabs = ceil(rand*8);
    else    
        i = locations(s,1);
        j = locations(s,2);
        x_goal = locations(goal,1);
        y_goal = locations(goal,2);
        actual = environment{i,j};            
        distance = abs(i-x_goal) + abs(j-locations(goal,2));
        
        if a == ACTION.N        
            dist_next = abs(i-1-x_goal) + abs(j-y_goal);
            observation = actual.N;       
            
        elseif a == ACTION.S        
            dist_next = abs(i+1-x_goal) + abs(j-y_goal);
            observation = actual.S;
            
        elseif a == ACTION.E
            dist_next = abs(i-x_goal) + abs(j+1-y_goal);
            observation = actual.E;        
        
        else % a == ACTION.W
            dist_next = abs(i-x_goal) + abs(j-1-y_goal);
            observation = actual.W;
        end 
        
        aabs = find(ABSACTIONS(1:4,1) == observation);
        if numel(aabs) == 0 % Nao achou nenhuma acao
            %sees = [actual.N actual.S actual.E actual.W];
            %aabs = min(setdiff(ABSACTIONS(1:4,1),sees));
            aabs = 3;
        elseif distance >= dist_next % Está indo na direçao da meta
            aabs = aabs + 4; % Sao 8 acoes simetricas: 4 primeiras sao opostas a meta, e 4 ultimas na direcao. Por isso +4;
        end
    end           
end
