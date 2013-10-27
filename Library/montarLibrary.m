function [library] = montarLibrary(L, LDescription, libraryDescription)
        
    library = cell(1,1);
    
    [nLibs, nSource] = size(LDescription);        
    indexLib = find(sum(LDescription == repmat(libraryDescription,nLibs,1),2) == nSource); % Procura library igual
    if (size(indexLib,1) > 0)
        library = L(indexLib).Policies;        
    end
end