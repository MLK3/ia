%dir = 'results/';
dir = '~/Documents/Mestrado/Exp3/';

% Mapa Fernandez2006
targetTasks = [22,7,31,56,78,96,130,138,154,174,181,251,236,278,264];
% Mapa grande
%targetTasks = [40,86,64,246,228,378,524,533,686,725];

name1 = 'L25';
name2 = 'Ag';
s = 20;
orders = 1:4;
runs = 1:25;
episodes = 2000;
points = 1:10:episodes;

nOrders = max(size(orders));
nRuns = max(size(runs));
nTarget = max(size(targetTasks));

tStudent = zeros(max(size(points)),1);
j = 1;
for point=points
    W1 = zeros(nOrders*nRuns*nTarget,1);
    W2 = zeros(nOrders*nRuns*nTarget,1);

    i = 1;
    for o=orders
        for t=1:nTarget
            for r=runs
                load([dir name1 '_o' int2str(o) '_s' int2str(s) '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
                X = cumsum(W)./(1:episodes)';
                W1(i) = X(point);
                load([dir name2 '_o' int2str(o) '_s' int2str(s) '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
                X = cumsum(W)./(1:episodes)';
                W2(i) = X(point);
                i = i + 1;
            end
        end
    end

    [h,p,ci,stats] = ttest(W1,W2);
    
    tStudent(j) = stats.tstat;
    j = j + 1;
end

