% Retorna environment

linhas = 18;
colunas = 30;

environment = cell(linhas,colunas);
for i=1:linhas
    for j=1:colunas
        environment{i,j}.N = 0;
        environment{i,j}.S = 0;
        environment{i,j}.E = 0;
        environment{i,j}.W = 0;
        environment{i,j}.In = 0;
        environment{i,j}.L = 0;
    end
end

    % 2,2
    environment{2,2}.In = P.R;
    environment{2,2}.S = P.Df;
    environment{2,2}.E = P.Df;

    % 3,2
    environment{3,2}.In = P.R;
    environment{3,2}.N = P.E;
    environment{3,2}.S = P.Sr;

    % 4,2
    environment{4,2}.In = P.R;
    environment{4,2}.N = P.Sr;
    environment{4,2}.S = P.E;

    % 5,2
    environment{5,2}.In = P.R;
    environment{5,2}.N = P.Df;
    environment{5,2}.S = P.Df;
    environment{5,2}.E = P.Df;

    % 6,2
    environment{6,2}.In = P.R;
    environment{6,2}.N = P.E;
    environment{6,2}.S = P.Sr;

    % 7,2
    environment{7,2}.In = P.R;
    environment{7,2}.N = P.Sr;
    environment{7,2}.S = P.E;

    % 8,2
    environment{8,2}.In = P.R;
    environment{8,2}.N = P.Df;
    
    % 11,2
    environment{11,2}.In = P.R;
    environment{11,2}.S = P.Df;
    
    % 12,2
    environment{12,2}.In = P.R;
    environment{12,2}.N = P.E;
    environment{12,2}.S = P.Sr;
    
    % 13,2
    environment{13,2}.In = P.R;
    environment{13,2}.N = P.Sr;
    environment{13,2}.S = P.E;
    
    % 14,2
    environment{14,2}.In = P.R;
    environment{14,2}.N = P.Df;
    environment{14,2}.E = P.Df;
	
	% 17,2
    environment{17,2}.In = P.R;
    environment{17,2}.E = P.Df;
    
    % 2,3
    environment{2,3}.In = P.R;
    environment{2,3}.W = P.E;
    environment{2,3}.E = P.Sr;

    % 5,3
    environment{5,3}.In = P.R;
    environment{5,3}.W = P.E;
    environment{5,3}.E = P.Sc;
    
    % 14,3
    environment{14,3}.In = P.R;
    environment{14,3}.W = P.E;
    environment{14,3}.E = P.Sr;
	
	% 17,3
    environment{17,3}.In = P.R;
    environment{17,3}.W = P.E;
    environment{17,3}.E = P.Sc;    
   
    % 2,4
    environment{2,4}.In = P.R;
    environment{2,4}.E = P.E;
    environment{2,4}.W = P.Sr;
    
    % 5,4
    environment{5,4}.In = P.C;
    environment{5,4}.E = P.E;
    environment{5,4}.W = P.Sr;   
    
    % 14,4
    environment{14,4}.In = P.R;
    environment{14,4}.E = P.E;
    environment{14,4}.W = P.Sr;
	
	% 17,4
    environment{17,4}.In = P.C;
    environment{17,4}.E = P.E;
    environment{17,4}.W = P.Sr;
        
    % 2,5
    environment{2,5}.In = P.R;
    environment{2,5}.W = P.Df;

    % 5,5
    environment{5,5}.In = P.C;
    environment{5,5}.E = P.E;
    environment{5,5}.W = P.Df;

    % 8,5
    environment{8,5}.In = P.R;
    environment{8,5}.E = P.Df;
    
    % 11,5
    environment{11,5}.In = P.C;
    environment{11,5}.E = P.E;
    environment{11,5}.S = P.Df;
    
    % 12,5
    environment{12,5}.In = P.C;
    environment{12,5}.N = P.E;
    environment{12,5}.S = P.Sr;
    
    % 13,5
    environment{13,5}.In = P.R;
    environment{13,5}.N = P.Sc;
    environment{13,5}.S = P.E;
    
    % 14,5
    environment{14,5}.In = P.R;
    environment{14,5}.N = P.Df;
    environment{14,5}.W = P.Df;
	
	% 17,5
    environment{17,5}.In = P.C;
    environment{17,5}.E = P.E;
    environment{17,5}.W = P.Df;
       
    % 5,6
    environment{5,6}.In = P.C;
    environment{5,6}.E = P.E;
    environment{5,6}.W = P.E;

    % 8,6
    environment{8,6}.In = P.R;
    environment{8,6}.E = P.Sr;
    environment{8,6}.W = P.E;
    
    % 11,6
    environment{11,6}.In = P.C;
    environment{11,6}.E = P.E;
    environment{11,6}.W = P.E;
    
	% 17,6
    environment{17,6}.In = P.C;
    environment{17,6}.E = P.E;
    environment{17,6}.W = P.E;
   
    % 5,7
    environment{5,7}.In = P.C;
    environment{5,7}.E = P.E;
    environment{5,7}.W = P.E;

    % 8,7
    environment{8,7}.In = P.R;
    environment{8,7}.W = P.Sr;
    environment{8,7}.E = P.E;
    
    % 11,7
    environment{11,7}.In = P.C;
    environment{11,7}.W = P.E;
    environment{11,7}.E = P.E;
	
	% 17,7
    environment{17,7}.In = P.C;
    environment{17,7}.W = P.E;
    environment{17,7}.E = P.E;
    
    % 2,8
    environment{2,8}.In = P.R;
    environment{2,8}.S = P.Df;

    % 3,8
    environment{3,8}.In = P.R;
    environment{3,8}.S = P.Sc;
    environment{3,8}.N = P.E;

    % 4,8
    environment{4,8}.In = P.C;
    environment{4,8}.N = P.Sr;
    environment{4,8}.S = P.E;

    % 5,8
    environment{5,8}.In = P.C;
    environment{5,8}.N = P.Df;
    environment{5,8}.S = P.Df;
    environment{5,8}.E = P.E;
    environment{5,8}.W = P.E;
    
    % 6,8
    environment{6,8}.In = P.C;
    environment{6,8}.N = P.E;
    environment{6,8}.S = P.Sr;
    
    % 7,8
    environment{7,8}.In = P.R;
    environment{7,8}.N = P.Sc;
    environment{7,8}.S = P.E;

    % 8,8
    environment{8,8}.In = P.R;
    environment{8,8}.W = P.Df;
	environment{8,8}.E = P.Df;
    environment{8,8}.N = P.Df;
    
    % 11,8
    environment{11,8}.In = P.C;
    environment{11,8}.W = P.E;
    environment{11,8}.E = P.E;
    environment{11,8}.S = P.E;
    
    % 12,8
    environment{12,8}.In = P.C;
    environment{12,8}.N = P.E;
    environment{12,8}.S = P.E;
    
    % 13,8
    environment{13,8}.In = P.C;
    environment{13,8}.N = P.E;
    environment{13,8}.S = P.E;
    
    % 14,8
    environment{14,8}.In = P.C;
    environment{14,8}.N = P.E;
    environment{14,8}.S = P.E;
	
	% 15,8
    environment{15,8}.In = P.C;
    environment{15,8}.N = P.E;
    environment{15,8}.S = P.E;
	
	% 16,8
    environment{16,8}.In = P.C;
    environment{16,8}.N = P.E;
    environment{16,8}.S = P.E;
	
	% 17,8
    environment{17,8}.In = P.C;
    environment{17,8}.N = P.E;
    environment{17,8}.W = P.E;
	environment{17,8}.E = P.E;
    
    % 5,9
    environment{5,9}.In = P.C;
    environment{5,9}.E = P.E;
    environment{5,9}.W = P.E;
	
	% 8,9
    environment{8,9}.In = P.R;
    environment{8,9}.E = P.Sr;
    environment{8,9}.W = P.E;
      
    % 11,9
    environment{11,9}.In = P.C;
    environment{11,9}.E = P.E;
    environment{11,9}.W = P.E;
    
    % 17,9
    environment{17,9}.In = P.C;
    environment{17,9}.E = P.E;
    environment{17,9}.W = P.E;

    % 5,10
    environment{5,10}.In = P.C;
    environment{5,10}.E = P.E;
    environment{5,10}.W = P.E;  
	
	% 8,10
    environment{8,10}.In = P.R;
    environment{8,10}.E = P.E;
    environment{8,10}.W = P.Sr; 	
    
    % 11,10
    environment{11,10}.In = P.C;
    environment{11,10}.E = P.E;
    environment{11,10}.W = P.E;
    
    % 17,10
    environment{17,10}.In = P.C;
    environment{17,10}.E = P.E;
    environment{17,10}.W = P.E;

    % 2,11
    environment{2,11}.In = P.R;
    environment{2,11}.E = P.Df;

    % 5,11
    environment{5,11}.In = P.C;
    environment{5,11}.E = P.E;
    environment{5,11}.W = P.E;

    % 8,11
    environment{8,11}.In = P.R;
    environment{8,11}.S = P.Df;
	environment{8,11}.W = P.Df;
    
    % 9,11
    environment{9,11}.In = P.R;
    environment{9,11}.S = P.Sc;
    environment{9,11}.N = P.E;
    
    % 10,11
    environment{10,11}.In = P.C;
    environment{10,11}.N = P.Sr;
    environment{10,11}.S = P.E;
    
    % 11,11
    environment{11,11}.In = P.C;
    environment{11,11}.N = P.Df;
    environment{11,11}.E = P.E;
    environment{11,11}.W = P.E;
    
    % 14,11
    environment{14,11}.In = P.R;
    environment{14,11}.E = P.Df;
	
	% 17,11
    environment{17,11}.In = P.C;
    environment{17,11}.E = P.E;
	environment{17,11}.W = P.E;
    
    % 2,12
    environment{2,12}.In = P.R;
    environment{2,12}.W = P.E;
    environment{2,12}.E = P.Sr;
    
    % 5,12
    environment{5,12}.In = P.C;
    environment{5,12}.W = P.E;
    environment{5,12}.E = P.E;

    % 11,12
    environment{11,12}.In = P.C;
    environment{11,12}.W = P.E;
    environment{11,12}.E = P.E;
    
    % 14,12
    environment{14,12}.In = P.R;
    environment{14,12}.W = P.E;
    environment{14,12}.E = P.Sr;
	
	% 17,12
    environment{17,12}.In = P.C;
    environment{17,12}.W = P.E;
    environment{17,12}.E = P.E;
    
    % 2,13
    environment{2,13}.In = P.R;
    environment{2,13}.E = P.E;
    environment{2,13}.W = P.Sr;
    
    % 5,13
    environment{5,13}.In = P.C;
    environment{5,13}.E = P.E;
    environment{5,13}.W = P.E;

    % 11,13
    environment{11,13}.In = P.C;
    environment{11,13}.W = P.E;
    environment{11,13}.E = P.E;
    
    % 14,13
    environment{14,13}.In = P.R;
    environment{14,13}.W = P.Sr;
    environment{14,13}.E = P.E;
    
	% 17,13
    environment{17,13}.In = P.C;
    environment{17,13}.W = P.E;
    environment{17,13}.E = P.E;
	
    % 2,14
    environment{2,14}.In = P.R;
    environment{2,14}.W = P.Df;
    environment{2,14}.S = P.Df;
    
    % 3,14
    environment{3,14}.In = P.R;
    environment{3,14}.N = P.E;
    environment{3,14}.S = P.Sc;
    
    % 4,14
    environment{4,14}.In = P.C;
    environment{4,14}.N = P.Sr;
    environment{4,14}.S = P.E;

    % 5,14
    environment{5,14}.In = P.C;
    environment{5,14}.N = P.Df;
    environment{5,14}.E = P.E;
    environment{5,14}.W = P.E;
    
    % 8,14
    environment{8,14}.In = P.R;
    environment{8,14}.E = P.Df;
    
    % 11,14
    environment{11,14}.In = P.C;
    environment{11,14}.E = P.E;
    environment{11,14}.W = P.E;
    
    % 14,14
    environment{14,14}.In = P.R;
    environment{14,14}.W = P.Df;
	environment{14,14}.S = P.Df;
	
	% 15,14
    environment{15,14}.In = P.R;
    environment{15,14}.N = P.E;
	environment{15,14}.S = P.Sc;
	
	% 16,14
    environment{16,14}.In = P.C;
    environment{16,14}.N = P.Sr;
	environment{16,14}.S = P.E;
	
	% 17,14
    environment{17,14}.In = P.C;
    environment{17,14}.N = P.Df;
	environment{17,14}.W = P.E;
	environment{17,14}.E = P.E;
        
    % 5,15
    environment{5,15}.In = P.C;
    environment{5,15}.E = P.E;
    environment{5,15}.W = P.E;
    
    % 8,15
    environment{8,15}.In = P.R;
    environment{8,15}.E = P.Sr;
    environment{8,15}.W = P.E;
    
    % 11,15
    environment{11,15}.In = P.C;
    environment{11,15}.E = P.E;
    environment{11,15}.W = P.E;
        
	% 17,15
    environment{17,15}.In = P.C;
    environment{17,15}.E = P.E;
    environment{17,15}.W = P.E;
                 
    % 5,16
    environment{5,16}.In = P.C;
    environment{5,16}.W = P.E;    
    environment{5,16}.E = P.E;
    
    % 8,16
    environment{8,16}.In = P.C;
    environment{8,16}.W = P.Sr;    
    environment{8,16}.E = P.E;
      
    % 11,16
    environment{11,16}.In = P.C;
    environment{11,16}.W = P.E;    
    environment{11,16}.E = P.E;
	
	% 17,16
    environment{17,16}.In = P.C;
    environment{17,16}.W = P.E;    
    environment{17,16}.E = P.E;
        
    % 2,17
    environment{2,17}.In = P.R;
    environment{2,17}.S = P.Df;    
    environment{2,17}.E = P.Df;
    
    % 3,17
    environment{3,17}.In = P.R;
    environment{3,17}.S = P.Sc;    
    environment{3,17}.N = P.E;
    
    % 4,17
    environment{4,17}.In = P.C;
    environment{4,17}.S = P.E;    
    environment{4,17}.N = P.Sr;
    
    % 5,17
    environment{5,17}.In = P.C;
    environment{5,17}.N = P.Df;    
    environment{5,17}.S = P.Df;
    environment{5,17}.W = P.E;
	environment{5,17}.E = P.E;
    
    % 6,17
    environment{6,17}.In = P.C;
    environment{6,17}.N = P.E;    
    environment{6,17}.S = P.Sr;
    
    % 7,17
    environment{7,17}.In = P.R;
    environment{7,17}.N = P.Sc;    
    environment{7,17}.S = P.E;
    
    % 8,17
    environment{8,17}.In = P.R;
    environment{8,17}.N = P.Df; 
    environment{8,17}.W = P.Df;
     
    % 11,17
    environment{11,17}.In = P.C;
    environment{11,17}.S = P.Df; 
    environment{11,17}.W = P.E;    
    environment{11,17}.E = P.E;
	
	% 12,17
    environment{12,17}.In = P.C;
    environment{12,17}.N = P.E; 
    environment{12,17}.S = P.Sr;
	
	% 13,17
    environment{13,17}.In = P.R;
    environment{13,17}.N = P.Sc; 
    environment{13,17}.S = P.E;
       
    % 14,17
    environment{14,17}.In = P.R;
    environment{14,17}.N = P.Df;  

	% 17,17
    environment{17,17}.In = P.C;
    environment{17,17}.W = P.E; 
	environment{17,17}.E = P.E;	
      
    % 2,18
    environment{2,18}.In = P.R;
    environment{2,18}.W = P.E;    
    environment{2,18}.E = P.Sr;
	
	% 5,18
    environment{5,18}.In = P.C;
    environment{5,18}.W = P.E;    
    environment{5,18}.E = P.E;
    
    % 11,18
    environment{11,18}.In = P.C;
    environment{11,18}.W = P.E;    
    environment{11,18}.E = P.E;
    
    % 17,18
    environment{17,18}.In = P.C;
    environment{17,18}.W = P.E;    
    environment{17,18}.E = P.E;
    
    % 2,19
    environment{2,19}.In = P.R;
    environment{2,19}.W = P.Sr;    
    environment{2,19}.E = P.E;
	
	% 5,19
    environment{5,19}.In = P.C;
    environment{5,19}.W = P.E;    
    environment{5,19}.E = P.E;
    
    % 11,19
    environment{11,19}.In = P.C;
    environment{11,19}.W = P.E;    
    environment{11,19}.E = P.E;
    
    % 17,19
    environment{17,19}.In = P.C;
    environment{17,19}.W = P.E;    
    environment{17,19}.E = P.E;
    
    % 2,20
    environment{2,20}.In = P.R;
    environment{2,20}.W = P.Df; 
	environment{2,20}.E = P.Df; 
	environment{2,20}.S = P.Df; 
	
	% 3,20
    environment{3,20}.In = P.R;
    environment{3,20}.N = P.E; 
	environment{3,20}.S = P.Sc; 
	
	% 4,20
    environment{4,20}.In = P.C;
    environment{4,20}.N = P.Sr; 
	environment{4,20}.S = P.E;
    
    % 5,20
    environment{5,20}.In = P.C;
    environment{5,20}.N = P.Df;
	environment{5,20}.W = P.E;
	environment{5,20}.E = P.E;
    
    % 8,20
    environment{8,20}.In = P.R;
    environment{8,20}.E = P.Df; 
    
    % 11,20
    environment{11,20}.In = P.C;
    environment{11,20}.S = P.Df;
    environment{11,20}.W = P.E;
	environment{11,20}.E = P.E;
    
    % 12,20
    environment{12,20}.In = P.C;
    environment{12,20}.N = P.E;
    environment{12,20}.S = P.Sr;
    
    % 13,20
    environment{13,20}.In = P.R;
    environment{13,20}.N = P.Sc;
    environment{13,20}.S = P.E;
    
    % 14,20
    environment{14,20}.In = P.R;
    environment{14,20}.N = P.Df;
    environment{14,20}.E = P.Df; 

	% 17,20
    environment{17,20}.In = P.C;
    environment{17,20}.W = P.E;
    environment{17,20}.E = P.E; 

	% 2,21
    environment{2,21}.In = P.R;
    environment{2,21}.W = P.E;
    environment{2,21}.E = P.Sr; 
	
	% 5,21
    environment{5,21}.In = P.C;
    environment{5,21}.W = P.E;
    environment{5,21}.E = P.E; 
	
	% 8,21
    environment{8,21}.In = P.R;
    environment{8,21}.W = P.E;
    environment{8,21}.E = P.Sr; 
	
	% 11,21
    environment{11,21}.In = P.C;
    environment{11,21}.W = P.E;
    environment{11,21}.E = P.E; 
	
	% 14,21
    environment{14,21}.In = P.R;
    environment{14,21}.W = P.E;
    environment{14,21}.E = P.Sr;
	
	% 17,21
    environment{17,21}.In = P.C;
    environment{17,21}.W = P.E;
    environment{17,21}.E = P.E;
	
	% 2,22
    environment{2,22}.In = P.R;
    environment{2,22}.W = P.Sr;
    environment{2,22}.E = P.E;
	
	% 5,22
    environment{5,22}.In = P.C;
    environment{5,22}.W = P.E;
    environment{5,22}.E = P.E;
	
	% 8,22
    environment{8,22}.In = P.R;
    environment{8,22}.W = P.Sr;
    environment{8,22}.E = P.E;
	
	% 11,22
    environment{11,22}.In = P.C;
    environment{11,22}.W = P.E;
    environment{11,22}.E = P.E;
	
	% 14,22
    environment{14,22}.In = P.R;
    environment{14,22}.W = P.Sr;
    environment{14,22}.E = P.E;
	
	% 17,22
    environment{17,22}.In = P.C;
    environment{17,22}.W = P.E;
    environment{17,22}.E = P.E;
	
	% 2,23
    environment{2,23}.In = P.R;
    environment{2,23}.W = P.E;
	
	% 5,23
    environment{5,23}.In = P.C;
    environment{5,23}.W = P.E;
    environment{5,23}.E = P.E;
	
	% 8,23
    environment{8,23}.In = P.R;
    environment{8,23}.W = P.Df;
    environment{8,23}.E = P.Df;
	
	% 11,23
    environment{11,23}.In = P.C;
    environment{11,23}.W = P.E;
    environment{11,23}.E = P.E;
	environment{11,23}.S = P.Df;
	
	% 12,23
    environment{12,23}.In = P.C;
    environment{12,23}.N = P.E;
    environment{12,23}.S = P.Sr;
	
	% 13,23
    environment{13,23}.In = P.R;
    environment{13,23}.N = P.Sc;
    environment{13,23}.S = P.E;
	
	% 14,23
    environment{14,23}.In = P.R;
    environment{14,23}.N = P.Df;
    environment{14,23}.W = P.Df;
	
	% 17,23
    environment{17,23}.In = P.C;
    environment{17,23}.W = P.E;
    environment{17,23}.E = P.Df;
	
	% 5,24
    environment{5,24}.In = P.C;
    environment{5,24}.E = P.E;
    environment{5,24}.W = P.E;
	
	% 8,24
    environment{8,24}.In = P.R;
    environment{8,24}.E = P.Sc;
    environment{8,24}.W = P.E;
	
	% 11,24
    environment{11,24}.In = P.C;
    environment{11,24}.E = P.E;
    environment{11,24}.W = P.E;
	
	% 17,24
    environment{17,24}.In = P.C;
    environment{17,24}.E = P.Sr;
    environment{17,24}.W = P.E;
	
	% 5,25
    environment{5,25}.In = P.C;
    environment{5,25}.E = P.E;
    environment{5,25}.W = P.E;
	
	% 8,25
    environment{8,25}.In = P.C;
    environment{8,25}.E = P.E;
    environment{8,25}.W = P.Sr;
	
	% 11,25
    environment{11,25}.In = P.C;
    environment{11,25}.E = P.E;
    environment{11,25}.W = P.E;
	
	% 17,25
    environment{17,25}.In = P.R;
    environment{17,25}.E = P.E;
    environment{17,25}.W = P.Sc;
	
	% 2,26
    environment{2,26}.In = P.R;
    environment{2,26}.E = P.Df;
    environment{2,26}.S = P.Df;
	
	% 3,26
    environment{3,26}.In = P.R;
    environment{3,26}.N = P.E;
    environment{3,26}.S = P.Sc;
	
	% 4,26
    environment{4,26}.In = P.C;
    environment{4,26}.N = P.Sr;
    environment{4,26}.S = P.E;
	
	% 5,26
    environment{5,26}.In = P.C;
    environment{5,26}.N = P.Df;
    environment{5,26}.S = P.E;
	
	% 6,26
    environment{6,26}.In = P.C;
    environment{6,26}.N = P.E;
    environment{6,26}.S = P.E;
	
	% 7,26
    environment{7,26}.In = P.C;
    environment{7,26}.N = P.E;
    environment{7,26}.S = P.E;
	
	% 8,26
    environment{8,26}.In = P.C;
    environment{8,26}.N = P.E;
    environment{8,26}.S = P.E;
	environment{8,26}.W = P.Df;
    environment{8,26}.E = P.Df;
	
	% 9,26
    environment{9,26}.In = P.C;
    environment{9,26}.N = P.E;
    environment{9,26}.S = P.E;
	
	% 10,26
    environment{10,26}.In = P.C;
    environment{10,26}.N = P.E;
    environment{10,26}.S = P.E;
	
	% 11,26
    environment{11,26}.In = P.C;
    environment{11,26}.N = P.E;
    environment{11,26}.S = P.Df;
	environment{11,26}.W = P.E;
    environment{11,26}.E = P.E;
	
	% 12,26
    environment{12,26}.In = P.C;
    environment{12,26}.N = P.E;
    environment{12,26}.S = P.Sr;
	
	% 13,26
    environment{13,26}.In = P.R;
    environment{13,26}.N = P.Sc;
    environment{13,26}.S = P.E;
	
	% 14,26
    environment{14,26}.In = P.R;
    environment{14,26}.N = P.Df;
	
	% 17,26
    environment{17,26}.In = P.R;
    environment{17,26}.W = P.Df;
	
	% 2,27
    environment{2,27}.In = P.R;
    environment{2,27}.W = P.E;
    environment{2,27}.E = P.Sr;
	
	% 8,27
    environment{8,27}.In = P.C;
    environment{8,27}.W = P.E;
    environment{8,27}.E = P.Sr;
	
	% 11,27
    environment{11,27}.In = P.C;
    environment{11,27}.W = P.E;
    environment{11,27}.E = P.E;
	
	% 2,28
    environment{2,28}.In = P.R;
    environment{2,28}.W = P.Sr;
    environment{2,28}.E = P.E;
	
	% 8,28
    environment{8,28}.In = P.R;
    environment{8,28}.W = P.Sc;
    environment{8,28}.E = P.E;
	
	% 11,28
    environment{11,28}.In = P.C;
    environment{11,28}.W = P.E;
    environment{11,28}.E = P.E;
	
	% 2,29
    environment{2,29}.In = P.R;
    environment{2,29}.W = P.Df;
	
	% 5,29
    environment{5,29}.In = P.R;
    environment{5,29}.S = P.Df;
	
	% 6,29
    environment{6,29}.In = P.R;
    environment{6,29}.N = P.E;
	environment{6,29}.S = P.Sr;
	
	% 7,29
    environment{7,29}.In = P.R;
    environment{7,29}.N = P.Sr;
	environment{7,29}.S = P.E;
	
	% 8,29
    environment{8,29}.In = P.R;
    environment{8,29}.N = P.Df;
	environment{8,29}.W = P.Df;
	
	% 11,29
    environment{11,29}.In = P.C;
    environment{11,29}.W = P.E;
	environment{11,29}.S = P.Df;
	
	% 12,29
    environment{12,29}.In = P.C;
    environment{12,29}.N = P.E;
	environment{12,29}.S = P.Sr;
	
	% 13,29
    environment{13,29}.In = P.R;
    environment{13,29}.N = P.Sc;
	environment{13,29}.S = P.E;
	
	% 14,29
    environment{14,29}.In = P.R;
    environment{14,29}.N = P.Df;
	environment{14,29}.S = P.Df;
	
	% 15,29
    environment{15,29}.In = P.R;
    environment{15,29}.N = P.E;
	environment{15,29}.S = P.Sr;
	
	% 16,29
    environment{16,29}.In = P.R;
    environment{16,29}.N = P.Sr;
	environment{16,29}.S = P.E;
	
	% 17,29
    environment{17,29}.In = P.R;
    environment{17,29}.N = P.Df;

locations = zeros(0,2);

count = 0;

for j=1:colunas
    for i=1:linhas
        if environment{i,j}.In > 0
            count = count + 1;
            locations = [locations; [i j]];
            environment{i,j}.L = count;
        end
    end
end
