Generacja_danych_do_nauki;
net = layrecnet(1:2,20);
net.sampleTime=0.1; 
net.trainParam.lr = 0.001;         % Learning rate
[Xs,Xi,Ai,Ts] = preparets(net,X,T);
net = train(net,Xs,Ts,Xi,Ai);
view(net)
Y = net(Xs,Xi,Ai);
perf = perform(net,Y,Ts)