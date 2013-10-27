function [L,LDescription] = atualizarL(L,LDescription, o, i, piCurrent, currentLibrary, nome)
    % L é um struct array. Cada elemento é um struct, com elementos: Policies e
    % Names
    % LDescription é uma matriz n x n, as linhas representam bibliotecas e
    % as colunas politicas. O valor 1 indica que a politica está inclusa na
    % biblioteca.
    % o é um inteiro, indicador da ordem
    % i é um inteiro, indicador da iteracao (sourcetask)
    % currentLibrary é a descrição de uma biblioteca (1 linha de
    % LDescription)
    % nome é uma string com o nome da biblioteca
    [nLibs, nSource] = size(LDescription);     
    indexLib = find(sum(LDescription == repmat(currentLibrary,nLibs,1),2) == nSource); % Procura library igual já guardada
    if (size(indexLib,1) > 0) % Tem uma igual já, só inclui o nome
        L(indexLib).Names{end+1,1} = [nome '_o' int2str(o) '_s' int2str(i)];
    else % Se for uma inédita, adiociona a biblioteca na lista de bibliotecas L
        nLibs = nLibs + 1;
        L(nLibs).Names = cell(1,1);
        L(nLibs).Names{1,1} = [nome '_o' int2str(o) '_s' int2str(i)];
        L(nLibs).Policies = L(nLibs-1).Policies;            
        L(nLibs).Policies{end+1} = piCurrent;            
        LDescription(nLibs,:) = currentLibrary;        
    end
end