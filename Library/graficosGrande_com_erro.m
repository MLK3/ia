function graficosGrande_com_erro

    dir = '~/Documents/Mestrado/Exp3/Grande/';

    % Mapa grande
    targetTasks = [40,86,64,246,228,378,524,533,686,725];

    orders = 1;
    runs = 1:70;
    episodes = 2000;
    s = 20;

    curves = struct;
    i = 1;
    curves(i).name = 'QL';
    curves(i).legend = 'No transfer';
    curves(i).lineStyle = '-.k';
    curves(i).markerStyle = '';
    i = i+1;
    curves(i).name = 'Ag';
    curves(i).legend = 'Generalized Policy';
    curves(i).lineStyle = '--k';
    curves(i).markerStyle = '^k';
    curves(i).realStyle = '--^k';
     i = i+1;
     curves(i).name = 'L0';
     curves(i).legend = 'Library (delta = 0)';
     curves(i).lineStyle = '--k';
     curves(i).markerStyle = 'ok';
     curves(i).realStyle = '--ok';
    i = i+1;
    curves(i).name = 'L25';
    curves(i).legend = 'Library (delta = 0.25)';
    curves(i).lineStyle = '--k';
    curves(i).markerStyle = '';
    i = i+1;
    curves(i).name = 'L50';
    curves(i).legend = 'Library (delta = 0.50)';
    curves(i).lineStyle = '-k';
    curves(i).markerStyle = '';
%     i = i+1;
%     curves(i).name = 'L75';
%     curves(i).legend = 'Library (delta = 0.75)';
%     curves(i).lineStyle = '-m';
    i = i+1;
    curves(i).name = 'L1';
    curves(i).legend = 'Library (delta = 1.0)';
    curves(i).lineStyle = ':k';
    curves(i).markerStyle = '';

    nOrders = max(size(orders));
    nRuns = max(size(runs));
    nCurves = max(size(curves));
    nTarget = max(size(targetTasks));
    
    W1r = zeros(episodes,nRuns);
    W1t = zeros(episodes,nTarget);
    W1o = zeros(episodes,nOrders);
    Ei = zeros(episodes,nRuns*nTarget*nOrders);
    
    handlers = zeros(nCurves,1);
        
    % Barras de erro
    Xe = [300:300:episodes]';
    Ye = zeros(size(Xe,1),1);
    Le = zeros(size(Xe,1),1); % lower bound
    Ue = zeros(size(Xe,1),1);
    
    % Estilo (para imprimir marcadores em intervalos e não em todos os
    % pontos)
    Xstyle = [100:100:episodes]';
    Ystyle = zeros(size(Xstyle,1),1);
        
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
                    W1r(:,r) = cumsum(W)./([1:episodes])';
                    Ei(:,i) = W1r(:,r);
                    i = i + 1;
                end
                W1t(:,t) = mean(W1r,2);
            end
            W1o(:,o) = mean(W1t,2);
        end
        W1 = mean(W1o,2);
                
        Y = W1;
        
        % Monta barras de erro
        j = 1;        
        for x=Xe'
            [h,p,ci] = ttest(Ei(x,:));            
            Ye(j,1) = Y(x,1);
            Le(j,1) = abs(Ye(j,1) - ci(1));
            Ue(j,1) = abs(Ye(j,1) - ci(2));
            j = j + 1;
        end
        
         j = 1;
        for x=Xstyle'
            Ystyle(j,1) = Y(x,1);
            j = j + 1;
        end
        
        h = plot(Y, curves(c).lineStyle);        
        hold on;  
        if  strcmp(curves(c).markerStyle,'') == 0 % Se tem estilo de marcador
            plot(Xstyle, Ystyle, curves(c).markerStyle);
            h = plot(NaN,curves(c).realStyle); % Workaround para ter legenda certa
        end
        errorbar(Xe,Ye,Le, Ue, '.k');
        
        handlers(c,1) = h;
    end

    %axis([0 2000 0 0.2]);
    legend(handlers, 'No transfer','Generalized Policy', 'L0','L25',  'L50',  'L100');

    hold off;
end

