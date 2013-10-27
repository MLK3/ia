nP = zeros(1000,2);
for r=runs
    for t=1:nTarget
        nome = [dir 'SARSA_t' int2str(targetTasks(t)) '_r' int2str(r)];
        load(nome, 'nPassosL');
        nP = nP + (nPassosL > 0);
    end
end

for i=1:1000
    nP(i,:) = nP(i,:) / 150;
end

x = (1:1000)';
p1 = polyfit(x,nP(:,1),7);
nP1 = polyval(p1,x);
p2 = polyfit(x,nP(:,2),7);
nP2 = polyval(p2,x);
% nP1 = nP1 - max(nP1);
% nP2 = nP2 + abs(min(nP2));

plot([nP1 nP2]);
        