function [libraryDesc] = PRPL(L, LDescription,currentLibraryDesc,currentValue,iteration,T,R,gamma,sigma,bInit,delta) 
    
    libraryDesc = currentLibraryDesc;
    currentLibrary = montarLibrary(L,LDescription,currentLibraryDesc);
    
    Vmax = 0;
    for i=1:size(currentLibrary,2)
        V = calcValorPolitica(currentLibrary{i},T,R,gamma,sigma,bInit);
        if V > Vmax
            Vmax = V;
        end
    end
    
    if (Vmax < delta * currentValue)
        % Insere politica na library    
        libraryDesc(iteration) = 1;    
    else
        libraryDesc(iteration) = 0;
    end   
end
