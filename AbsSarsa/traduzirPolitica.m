function [piConcreta] = traduzirPolitica(politicaAbstrata, sigma, T, locations)
    %
    % T - funçao de transferencia do MDP Abstrato
    %
    definitions;
    nLocations = size(locations, 1) + 1;
    nActionAbs = size(politicaAbstrata, 2);
    nAction = 4;
    piConcreta = zeros(nLocations,nAction);
    
	% Calcula Tpi
    Tpi = zeros(nLocations);
    for i=1:nActionAbs
        piA = politicaAbstrata(:,i)'*sigma;
        piA = repmat(piA',1,nLocations);
        Tpi = Tpi + T{i}(:,:).*piA;
    end
        
    for i=1:nLocations
        estadosVizinhos = find(Tpi(i,:));

        for j=estadosVizinhos
            a = -1;
            if j ~= nLocations
                if j == i+1
                    a = ACTION.E;
                elseif j == i-1
                    a = ACTION.W;
                elseif j < i
                    a = ACTION.N;
                elseif j > i
                    a = ACTION.S;
                end
            end
            if a ~= -1
                piConcreta(i,a) = Tpi(i,j);
            end
        end
        % Normalizar para somar 1
        soma = sum(piConcreta(i,:));
        if (soma > 0)
            piConcreta(i,:) = piConcreta(i,:)./soma;
        else
            piConcreta(i,:) = 1.0/size(piConcreta(i,:),2);
        end
    end
end
