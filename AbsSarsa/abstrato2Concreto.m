function [a] = abstrato2Concreto(s,aabs,environment,locations,ACTION,ABSACTIONS)
    
    nLocations = size(locations,1);
    if s <= nLocations
        i = locations(s,1);
        j = locations(s,2);    
        actual = environment{i,j};            
        
        aabsDef = ABSACTIONS(aabs,:);
            
        possibleActions = [];
        if actual.N == aabsDef(1)
            possibleActions = [possibleActions ACTION.N];
        end
        if actual.S == aabsDef(1)
            possibleActions = [possibleActions ACTION.S];
        end        
        if actual.E == aabsDef(1)
            possibleActions = [possibleActions ACTION.E];
        end
        if actual.W == aabsDef(1)
            possibleActions = [possibleActions ACTION.W];
        end
        
        if numel(possibleActions) <= 0
            a = ceil(rand*4);
        elseif numel(possibleActions) == 1
            a = possibleActions;
        else
            a = possibleActions(ceil(rand*numel(possibleActions)));
        end
    else
        a = ceil(rand*4);
    end
end
