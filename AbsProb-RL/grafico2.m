iteration = 100000;
runs = 1:10;
goals = [16];

Vm20 = zeros(iteration,1);
Vm50 = zeros(iteration,1);
Vm20f = zeros(iteration,1);
Vm50f = zeros(iteration,1);

k = 0;
for r=runs
    for g=goals
        k = k + 1;
        load(['step+20_alphai_g' int2str(g) '_r' int2str(r)]);
        Vm20 = Vm20 + (V - Vm20)/k;
        load(['step+50_alphai_g' int2str(g) '_r' int2str(r)]);
        Vm50 = Vm50 + (V - Vm50)/k;        
    end
end

k = 0;
for r=1:20
    for g=goals
        k = k + 1;        
        load(['step20+0_alphai_g' int2str(g) '_r' int2str(r)]);
        Vm20f = Vm20f + (V - Vm20f)/k;
        load(['step+0_alphai_g' int2str(g) '_r' int2str(r)]);
        Vm50f = Vm50f + (V - Vm50f)/k;
    end
end


plot(Vm20, 'b');
hold on;
plot(Vm50, 'r');
plot(Vm20f, 'g');
plot(Vm50f, 'k');
hold off;