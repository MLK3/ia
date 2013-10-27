function a = epsilonGreedy(s,Q,epsilon)
    [nS nA] = size(Q);
    if rand > epsilon % Explotation 
        [aux a] = max(Q(s,:));
    else % Exploration (random)
        a = ceil(rand*nA);
    end
end
