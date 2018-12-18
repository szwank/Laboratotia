rng default
options = optimoptions('ga','MaxStallTime',inf,'MaxTime',inf,'PopulationSize',10)
nvars = 2;
% A = diag(ones(1,nvars));
% b = zeros(nvars,1);
[x,fval] = ga(@funkcja_celu, nvars, [], [], [], [], zeros(1,nvars),10*ones(1,nvars),[],[1:nvars],options);