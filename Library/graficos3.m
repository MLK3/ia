function graficos3()

    % ==== Config =====
    nomeArquivo = 'mapa_grande.txt';
    %dir = 'results/';
    dir = '~/Documents/Mestrado/Exp3/';
    [environment,locations] = carregarMapa2(nomeArquivo);

    curves = struct;
    i = 1;
    curves(i).name = 'QL';
    curves(i).legend = 'No reuse';
    curves(i).lineStyle = '-c';
    i = i+1;
    curves(i).name = 'Ag';
    curves(i).legend = 'Generalized Policy';
    curves(i).lineStyle = '-r';
    i = i+1;
    curves(i).name = 'L0';
    curves(i).legend = 'Library (delta = 0)';
    curves(i).lineStyle = '-g';
    i = i+1;
    curves(i).name = 'L25';
    curves(i).legend = 'Library (delta = 0.25)';
    curves(i).lineStyle = '-b';
    i = i+1;
    curves(i).name = 'L50';
    curves(i).legend = 'Library (delta = 0.50)';
    curves(i).lineStyle = '-y';
    i = i+1;
    curves(i).name = 'L75';
    curves(i).legend = 'Library (delta = 0.75)';
    curves(i).lineStyle = '-m';
    i = i+1;
    curves(i).name = 'L1';
    curves(i).legend = 'Library (delta = 1.0)';
    curves(i).lineStyle = '-k';

    targetTasks = [22,7,31,56,78,96,130,138,154,174,181,251,236,278,264];
            
    orders = 1:4;
    runs = 1:9;
    nSource = 20;
    episodes = 2000;
    
    nOrders = max(size(orders));
    nRuns = max(size(runs));
    nCurves = max(size(curves));
    nTarget = max(size(targetTasks));
    vOptimal = zeros(nTarget,1);
    

    W1r = zeros(nSource,nRuns);
    W1t = zeros(nSource,nTarget);
    W1o = zeros(nSource,nOrders);
    W1 = zeros(nSource,1);
    
   for t=1:nTarget
        [S,A,T,R] = montarMDPConcreto(environment,locations, targetTasks(t));
        [policy,Vpolicy] = policyIteration(S,A,T,R,0.95);
        vOptimal(t) = mean(Vpolicy);
    end
        
    
    for c=1:nCurves
        for s=1:nSource
            for o=orders                        
                for t=1:nTarget                    
                    threshold = 0.2 * vOptimal(t);
                    %disp(['Optimal: ' num2str(vOptimal(t))]);
                    %threshold = 0.1;
                    for r=runs                    
                        if (c == 1)
                            nome = [dir curves(c).name '_t' int2str(targetTasks(t)) '_r' int2str(r)];
                            load(nome); %disp(nome);                            
                        else    
                            nome = [dir curves(c).name '_o' int2str(o) '_s' int2str(s) '_t' int2str(targetTasks(t)) '_r' int2str(r)];                            
                            load(nome); %disp(nome);
                        end                        
                        X = cumsum(W)./(1:episodes)';
                        %disp(max(X));
                        episode = find(X > threshold,1);
                        if (numel(episode) == 0)
                            episode = 2000;
                            disp(max(X));
                        end
                        W1r(s,r) = episode; 
                    end
                    W1t(s,t) = mean(W1r(s,:),2);
                end
                W1o(s,o) = mean(W1t(s,:),2);
            end            
        end
        W1 = mean(W1o,2);
        
        plot(W1, curves(c).lineStyle);
        %legend(curves(c).legend);

        hold on;
    end

    %axis([0 2000 0 0.2]);
    legend('QL','Ag', 'L0', 'L25', 'L50', 'L75', 'L1');

    hold off;
end

