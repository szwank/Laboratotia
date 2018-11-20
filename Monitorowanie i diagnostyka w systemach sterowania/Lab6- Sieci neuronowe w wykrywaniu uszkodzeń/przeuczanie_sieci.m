X = tonndata(X,false,false);
T = tonndata(T,false,false);
[xc,xic,aic,tc] = preparets(netc,X,{},T);
netc = train(netc1,xc,tc,xic,aic);
yc = netc1(xc,xic,aic);
closedLoopPerformance = perform(net,tc,yc)
