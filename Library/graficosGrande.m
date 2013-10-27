function graficosGrande
    %dir = 'results/';
    dir = '~/Documents/Mestrado/Exp3/Grande/';

    curves = struct;
    i = 1;
    curves(i).name = 'QL';
    curves(i).legend = 'No transfer';
    curves(i).lineStyle = '-k';
    i = i+1;
    curves(i).name = 'Ag';
    curves(i).legend = 'Generalized Policy';
    curves(i).lineStyle = '-.k';
    i = i+1;
    curves(i).name = 'L0';
    curves(i).legend = 'Library (delta = 0.25)';
    curves(i).lineStyle = '--k';
    i = i+1;
    curves(i).name = 'L25';
    curves(i).legend = 'Library (delta = 0.25)';
    curves(i).lineStyle = '-k';
    i = i+1;
%     curves(i).name = 'L50';
%     curves(i).legend = 'Library (delta = 0.50)';
%     curves(i).lineStyle = '-k';
%     i = i+1;
    curves(i).name = 'L1';
    curves(i).legend = 'Library (delta = 1.0)';
    curves(i).lineStyle = ':k';

    % Mapa grande
    targetTasks = [40,86,64,246,228,378,524,533,686,725];

    orders = 1;
    runs = 1:70;
    episodes = 2000;
    s = 20;

    nOrders = max(size(orders));
    nRuns = max(size(runs));
    nCurves = max(size(curves));
    nTarget = max(size(targetTasks));

    W1r = zeros(episodes,nRuns);
    W1t = zeros(episodes,nTarget);
    W1o = zeros(episodes,nOrders);
    W1 = zeros(episodes,1);
    
    for c=1:nCurves
        for o=orders
            for t=1:nTarget
                for r=runs
                    if (c == 1)
                        load([dir curves(c).name '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
                    else    
                        load([dir curves(c).name '_o' int2str(o) '_s' int2str(s) '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
                    end
                    W1r(:,r) = W;
                end
                W1t(:,t) = mean(W1r,2);
            end
            W1o(:,o) = mean(W1t,2);
        end
        W1 = mean(W1o,2);
        
        plot(cumsum(W1)./([1:episodes])', curves(c).lineStyle);
%         legend(curves(c).legend);

        hold on;
    end

    %axis([0 2000 0 0.2]);
    legend('No transfer','Generalized Policy', 'L0', 'L25', 'L100');

    hold off;
end

