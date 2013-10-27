function graficos2(e)
    % e = numero fixo de episódios transcorridos.
    %Eixo x = numero de source tasks
    %Eixo y = recompensa acumulada
    
    %dir = 'results/';
    dir = '~/Documents/Mestrado/Exp3/';

    curves = struct;
    i = 1;
%     curves(i).name = 'QL';
%     curves(i).legend = 'No reuse';
%     curves(i).lineStyle = '-c';
%     i = i+1;
    curves(i).name = 'Ag';
    curves(i).legend = 'Generalized Policy';
    curves(i).lineStyle = '-r';
    i = i+1;
%     curves(i).name = 'L0';
%     curves(i).legend = 'Library (delta = 0)';
%     curves(i).lineStyle = '-g';
%     i = i+1;
     curves(i).name = 'L25';
     curves(i).legend = 'Library (delta = 0.25)';
     curves(i).lineStyle = '-b';
     i = i+1;
     curves(i).name = 'L50';
     curves(i).legend = 'Library (delta = 0.50)';
     curves(i).lineStyle = '-m';
     i = i+1;
%     curves(i).name = 'L75';
%     curves(i).legend = 'Library (delta = 0.75)';
%     curves(i).lineStyle = '-m';
%     i = i+1;
    curves(i).name = 'L1';
    curves(i).legend = 'Library (delta = 1.0)';
    curves(i).lineStyle = '-k';

    %targetTasks = [22,7,31,56,78,96,130,138,154,174,181,251,236,278,264];
    targetTasks = 138;
    
    orders = 1:4;
    runs = 1:20;
    nSource = 20;
    episodes = 2000;
    
    nOrders = max(size(orders));
    nRuns = max(size(runs));
    nCurves = max(size(curves));
    nTarget = max(size(targetTasks));

    W1r = zeros(nSource,nRuns);
    W1t = zeros(nSource,nTarget);
    W1o = zeros(nSource,nOrders);
    W1 = zeros(nSource,1);
    
    for c=1:nCurves
        for s=1:nSource
            for o=orders                        
                for t=1:nTarget
                    for r=runs                    
%                         if (c == 1)
%                             load([dir curves(c).name '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
%                         else    
                            load([dir curves(c).name '_o' int2str(o) '_s' int2str(s) '_t' int2str(targetTasks(t)) '_r' int2str(r)]);
%                         end
                        X = cumsum(W)./(1:episodes)';
                        W1r(s,r) = X(e,1);
                    end
                    W1t(s,t) = mean(W1r(s,:),2);
                end
                W1o(s,o) = mean(W1t(s,:),2);
            end            
        end
        W1 = mean(W1o,2);
        
        plot(W1, curves(c).lineStyle);
        legend(curves(c).legend);

        hold on;
    end

    %axis([0 2000 0 0.2]);
    legend('Ag', 'L25', 'L50', 'L100');

    hold off;
end

