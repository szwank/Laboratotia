% [X,T] = simpleseries_dataset;
X = [Ut_in.signals.values'; Uw_in.signals.values'; M_in.signals.values'];
X = con2seq(X);
T = [It_out.signals.values'; Iw_out.signals.values'; Omega_out.signals.values'];
T = con2seq(T);
% X = rand(10,3);
% T = rand(10,1);
% net = narxnet(1:2,1:5,10);
net = layrecnet(1:3,10);
% net.divideFcn = 'divideblock';  % Divide data randomly
% net.divideMode = 'time';  % Divide up every sample
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;

[Xs,Xi,Ai,Ts] = preparets(net,X,T);
view(net)
net = train(net,Xs,Ts,Xi,Ai);
% view(net)
% Xs = seq2con(Xs);
% Xi = seq2con(Xi);
Y = net(Xs,Xi,Ai);

perf = perform(net,Y,Ts)
% gensim(net,0.01)