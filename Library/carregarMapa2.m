function [environment,locations] = carregarMapa2(nomeArquivo)
  
	% Essa função transforma um mapa numa estrutura environment.
	% r=room; c=corridor; d=door; - e | = wall
	% Essa versão considera que portas e paredes ocupam espaço.
	% Ela difere da primeira versão justamente nesse aspecto. 
	% Portanto, agora não é mais necessãrio completar o mapa com caracter '.'	
	
	% Essa função considera paredes e portas como células.   
    definitions;
    
    % Characters that must be skipped (represent walls)
    wall = ['-' '|' '.' ' ' '\n' 'd'];

    fid = fopen(nomeArquivo,'r');
    
    mapa = [];
    while (~feof(fid))
        linha = fgets(fid);        
        mapa = [mapa;linha];     
    end 
    fclose(fid);
    
    [linhas,colunas]=size(mapa);
        
    environment = cell(linhas,colunas);
    locations = zeros(0,2);
    count = 0;
    for i=2:(linhas-1)
        for j=2:(colunas-1)
            celula = mapa(i,j);
            if(celula == 'r')
                environment{i,j}.In = P.R;
            elseif (celula == 'c')
                environment{i,j}.In = P.C;
            elseif (celula == 'd')
            	environment{i,j}.In = P.D;
           	else
           		environment{i,j}.In = P.W;
            end
            
            if (sum(celula == wall) == 0) % Se celula não é parede
		        environment{i,j}.N = searchSurroundings(mapa,i,j,'N',P);
		        environment{i,j}.S = searchSurroundings(mapa,i,j,'S',P);
		        environment{i,j}.E = searchSurroundings(mapa,i,j,'E',P);
		        environment{i,j}.W = searchSurroundings(mapa,i,j,'W',P);
	            count = count + 1;
	            environment{i,j}.L = count;
	            locations = [locations; [i j]];
	        end
        end        
    end
end    
    
