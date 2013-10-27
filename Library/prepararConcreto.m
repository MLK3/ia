function [S,A,T,R,library] = prepararConcreto(environment,locations,DTG,goal,abstractLibrary)
        
    % Traduz politicas abstratas e coloca-as na library
    [nState,nAbstract,nAction,Tab,Rab,sigma] = montarMDP(environment,locations,DTG,goal);
    
    nPi = size(abstractLibrary,2);
    library = cell(nPi+1,1);
    
    for i=1:nPi
        library{i+1} = traduzirPolitica(abstractLibrary{i},sigma,Tab,locations);
    end
    
    [S,A,T,R] = montarMDPConcreto(environment,locations,goal);
    nS = max(size(S));
    nA = max(size(A));

    % Coloca politica a ser aprendida na Library
    piCurrent = rand(nS,nA);
    for i=1:nS
        piCurrent(i,:) = piCurrent(i,:)/sum(piCurrent(i,:));
    end
    library{1} = piCurrent;        
end
