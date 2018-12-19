net = network(1,3,[0;0;0],[1; zeros(2,1)],[0 0 0; 1 0 0; 0 1 0],[0 0 1]);
net.inputs{1}.range = [-200 200; 0 400; -pi pi];
net.layers{1}.size = 14;
net.layers{2}.size = 14;
net.layers{3}.size = 1;
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
view(net)
% save('podstawowa_siec','net')
% pierwsze wagi: net.IW{1} 14x3
% drugie wagi: net.LW{2,1} 14x14
% trzecie wagi: net.LW{3,2} 1x14
% wielkoœæ osobnika 14*3+14*14+14 = 252
% ,'UseParallel', true,
options = optimoptions('ga','PlotFcn', @gaplotbestf, 'UseParallel', true, 'PopulationSize', 30);
[x,fval] = ga(@Ciezarowka_cwiczenie_sieci, 252,[],[],[],[],-30 * ones(1,252),30 * ones(1,252),[],options);