iteration = 100000;
runs = 1:10;
goals = [16];

Vm20 = zeros(iteration,1);
Vm50 = zeros(iteration,1);
Vm100 = zeros(iteration,1);

k = 0;
for r=runs
    for g=goals
        k = k + 1;
        load(['step+20_alphaCount_g' int2str(g) '_r' int2str(r)]);
        Vm20 = Vm20 + (V - Vm20)/k;
        load(['step+50_alphaCount_g' int2str(g) '_r' int2str(r)]);
        Vm50 = Vm50 + (V - Vm50)/k;
        load(['step+100_alphaCount_g' int2str(g) '_r' int2str(r)]);
        Vm100 = Vm100 + (V - Vm100)/k;        
    end
end


plot(Vm20, 'b');
hold on;
plot(Vm50, 'r');
plot(Vm100, 'g');
hold off;