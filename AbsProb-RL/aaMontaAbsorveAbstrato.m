error = 0.1;
nAbstract = 1024;
epsilon = 0.05;
gamma = 0.9;

P.E = 1;  %empty space
P.Dc = 2; %close door
P.Df = 3; %far door
P.Sc = 4; %see corridor
P.Sr = 5; %see room
P.R = 6; %room
P.C = 7; %corridor

DTG = 5; %distancia para definir perto da meta

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

%Near Goal 512

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


linhas = 9;
colunas = 15;


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

% 5,3
environment{5,3}.In = P.R;
environment{5,3}.W = P.E;
environment{5,3}.E = P.Sc;

% 5,4
environment{5,4}.In = P.C;
environment{5,4}.E = P.E;
environment{5,4}.W = P.Sr;

% 2,5
environment{2,5}.In = P.R;
environment{2,5}.E = P.Df;

% 5,5
environment{5,5}.In = P.C;
environment{5,5}.E = P.E;
environment{5,5}.W = P.Df;

% 8,5
environment{8,5}.In = P.R;
environment{8,5}.E = P.Df;

% 2,6
environment{2,6}.In = P.R;
environment{2,6}.E = P.Sr;
environment{2,6}.W = P.E;

% 5,6
environment{5,6}.In = P.C;
environment{5,6}.E = P.E;
environment{5,6}.W = P.E;

% 8,6
environment{8,6}.In = P.R;
environment{8,6}.E = P.Sr;
environment{8,6}.W = P.E;

% 2,7
environment{2,7}.In = P.R;
environment{2,7}.W = P.Sr;
environment{2,7}.E = P.E;

% 5,7
environment{5,7}.In = P.C;
environment{5,7}.E = P.E;
environment{5,7}.W = P.E;

% 8,7
environment{8,7}.In = P.R;
environment{8,7}.W = P.Sr;
environment{8,7}.E = P.E;

% 2,8
environment{2,8}.In = P.R;
environment{2,8}.S = P.Df;
environment{2,8}.W = P.Df;

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
environment{5,8}.E = P.E;
environment{5,8}.W = P.E;

% 8,8
environment{8,8}.In = P.R;
environment{8,8}.W = P.Df;
environment{8,8}.E = P.Df;

% 5,9
environment{5,9}.In = P.C;
environment{5,9}.E = P.E;
environment{5,9}.W = P.E;

% 8,9
environment{8,9}.In = P.R;
environment{8,9}.E = P.Sc;
environment{8,9}.W = P.E;

% 5,10
environment{5,10}.In = P.C;
environment{5,10}.E = P.E;
environment{5,10}.W = P.E;

% 8,10
environment{8,10}.In = P.C;
environment{8,10}.E = P.E;
environment{8,10}.W = P.Sr;

% 2,11
environment{2,11}.In = P.R;
environment{2,11}.S = P.Df;
environment{2,11}.E = P.Df;

% 3,11
environment{3,11}.In = P.R;
environment{3,11}.S = P.Sc;
environment{3,11}.N = P.E;

% 4,11
environment{4,11}.In = P.C;
environment{4,11}.N = P.Sr;
environment{4,11}.S = P.E;

% 5,11
environment{5,11}.In = P.C;
environment{5,11}.N = P.Df;
environment{5,11}.S = P.E;
environment{5,11}.W = P.E;

% 6,11
environment{6,11}.In = P.C;
environment{6,11}.N = P.E;
environment{6,11}.S = P.E;

% 7,11
environment{7,11}.In = P.C;
environment{7,11}.N = P.E;
environment{7,11}.S = P.E;

% 8,11
environment{8,11}.In = P.C;
environment{8,11}.N = P.E;
environment{8,11}.W = P.Df;
environment{8,11}.E = P.Df;

% 2,12
environment{2,12}.In = P.R;
environment{2,12}.W = P.E;
environment{2,12}.E = P.Sr;

% 8,12
environment{8,12}.In = P.C;
environment{8,12}.W = P.E;
environment{8,12}.E = P.Sr;

% 2,13
environment{2,13}.In = P.R;
environment{2,13}.E = P.E;
environment{2,13}.W = P.Sr;

% 8,13
environment{8,13}.In = P.R;
environment{8,13}.W = P.Sc;
environment{8,13}.E = P.E;

% 2,14
environment{2,14}.In = P.R;
environment{2,14}.W = P.Df;

% 5,14
environment{5,14}.In = P.R;
environment{5,14}.S = P.Df;

% 6,14
environment{6,14}.In = P.R;
environment{6,14}.N = P.E;
environment{6,14}.S = P.Sr;

% 7,14
environment{7,14}.In = P.R;
environment{7,14}.N = P.Sr;
environment{7,14}.S = P.E;

% 8,14
environment{8,14}.In = P.R;
environment{8,14}.N = P.Df;
environment{8,14}.W = P.Df;

locations = zeros(0,2);

count = 0;
for i=1:linhas
    for j=1:colunas
        if environment{i,j}.In > 0
            count = count + 1;
            locations = [locations; [i j]];
            environment{i,j}.L = count;
        end
    end
end

[nAction x] = size(auxActions);
[nState x] = size(locations);

totalSigma = zeros(nAbstract,0);
totalT = zeros(0,0,nAction);
for goal=goals
T = zeros(nState,nState,nAction);
for a=1:nAction
    for s=1:nState
        i = locations(s,1);
        j = locations(s,2);
        actual = environment{i,j};
        distance = abs(i-locations(goal,1)) + abs(j-locations(goal,2));
        count = 0;
        
        %South
        next = environment{i+1,j};
        if actual.S == auxActions(a,1)
            if distance > abs(i+1-locations(goal,1)) + abs(j-locations(goal,2)) && auxActions(a,2) == 1
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
            if distance < abs(i+1-locations(goal,1)) + abs(j-locations(goal,2)) && auxActions(a,2) == 0
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
        end

        %North
        next = environment{i-1,j};
        if actual.N == auxActions(a,1)
            if distance > abs(i-1-locations(goal,1)) + abs(j-locations(goal,2)) && auxActions(a,2) == 1
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
            if distance < abs(i-1-locations(goal,1)) + abs(j-locations(goal,2)) && auxActions(a,2) == 0
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
        end

        %East
        next = environment{i,j+1};
        if actual.E == auxActions(a,1)
            if distance > abs(i-locations(goal,1)) + abs(j+1-locations(goal,2)) && auxActions(a,2) == 1
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
            if distance < abs(i-locations(goal,1)) + abs(j+1-locations(goal,2)) && auxActions(a,2) == 0
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
        end

        %West
        next = environment{i,j-1};
        if actual.W == auxActions(a,1)
            if distance > abs(i-locations(goal,1)) + abs(j-1-locations(goal,2)) && auxActions(a,2) == 1
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
            if distance < abs(i-locations(goal,1)) + abs(j-1-locations(goal,2)) && auxActions(a,2) == 0
                T(s,:,a) = T(s,:,a)*count/(count+1);
                T(s,next.L,a) = 1/(count+1);
                count = count+1;
            end
        end
        
        T(s,:,a) = T(s,:,a)*(1-error);
        T(s,s,a) = 0;
        T(s,s,a) = 1 - sum(T(s,:,a));
    end
end
T(goal,:,:) = 1/nState;

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
[i j] = size(totalT(:,:,1));
auxT = zeros(i+nState,j+nState,nAction);
for k=1:nAction
auxT(:,:,k) = [totalT(:,:,k) zeros(i,nState); zeros(nState,j) T(:,:,k)];
end
totalT = auxT;
totalSigma = [totalSigma sigma];
end

% % Chega na meta e recomeça
% [i j] = size(totalT(:,:,1));
% 
% 
% count = 0;
% R = zeros(1,i);
% for goal=goals
%     totalT(goal + count,:,:) = 1/i;
%     R(goal + count) = 1;
%     count = count + nState;
% end
% 
% bInit = ones(nState,1)/nState;


%chega na meta e para
[i j] = size(totalT(:,:,1));
totalSigma = [totalSigma ones(nAbstract,1)/nAbstract];
auxT = zeros(i+1,j+1,nAction);
for k=1:nAction
    auxT(:,:,k) = [totalT(:,:,k) zeros(i,1); zeros(1,j) 1];
end
totalT = auxT;
count = 0;
R = zeros(1,i+1);
for goal=goals
    totalT(goal + count,:,:) = 0;
    totalT(goal + count,i+1,:) = 1;
    R(goal + count) = 1;
    count = count + nState;
end


nState = i+1;

bInit = ones(nState,1)/(nState-1);
bInit(nState) = 0;

T = totalT;
sigma = totalSigma;

% nAbstract = nState;
% sigma = eye(nState);
