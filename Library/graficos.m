function W1=graficos(s)
    %dir = 'results/';
    dir = '~/Documents/Mestrado/Exp3/';

    curves = struct;
    i = 1;
    curves(i).name = 'QL';
    curves(i).legend = 'No transfer';
    curves(i).lineStyle = '-k';
    i = i+1;
    curves(i).name = 'Ag';
    curves(i).legend = 'Generalized Policy';
    curves(i).lineStyle = '-.k';
%     i = i+1;
%     curves(i).name = 'L0';
%     curves(i).legend = 'Library (delta = 0)';
%     curves(i).lineStyle = '-g';
    i = i+1;
    curves(i).name = 'L25';
    curves(i).legend = 'Library (delta = 0.25)';
    curves(i).lineStyle = '--k';
    i = i+1;
    curves(i).name = 'L50';
    curves(i).legend = 'Library (delta = 0.50)';
    curves(i).lineStyle = '-k';
%     i = i+1;
%     curves(i).name = 'L75';
%     curves(i).legend = 'Library (delta = 0.75)';
%     curves(i).lineStyle = '-m';
    i = i+1;
    curves(i).name = 'L1';
    curves(i).legend = 'Library (delta = 1.0)';
    curves(i).lineStyle = ':k';

    % Mapa Fernandez2006
    targetTasks = [22,7,31,56,78,96,130,138,154,174,181,251,236,278,264];
    % Mapa grande
    %targetTasks = [40,86,64,246,228,378,524,533,686,725];

    orders = 1:4;
    runs = 1:9;
    episodes = 2000;

    nOrders = max(size(orders));
    nRuns = max(size(runs));
    nCurves = max(size(curves));
    nTarget = max(size(targetTasks));

    W1r = zeros(episodes,nRuns);
    W1t = zeros(episodes,nTarget);
    W1o = zeros(episodes,nOrders);
            
    for c=1:nCurves
        i = 1;
        for o=orders
            for t=1:nTarget
                for r=runs
                    if (c == 1)
                        load([dir curves(c).name '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
                    else    
                        load([dir curves(c).name '_o' int2str(o) '_s' int2str(s) '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
                    end
                    W1r(:,r) = W;                    
                    i = i + 1;
                end
                W1t(:,t) = mean(W1r,2);
            end
            W1o(:,o) = mean(W1t,2);
        end
        W1 = mean(W1o,2);
        
        Y = cumsum(W1)./([1:episodes])';
        
        plot(Y, curves(c).lineStyle);
        hold on;
                
        %legend(curves(c).legend);
        %hold on;
        
    end

    %axis([0 2000 0 0.2]);
    legend('No transfer','Generalized Policy', 'Library (delta = 0.25)', 'Library (delta = 0.5)', 'Library (delta = 1.0)');

    hold off;
end

