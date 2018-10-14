Ac = [(A0-B0*K)];
Bc = [B0];
Cc = [0 1 0 0; 1 0 0 0];



sys_cl = ss(Ac,Bc,Cc,0);

t = 0:0.01:5;
r =0.2*ones(size(t));
[y,t,x]=lsim(sys_cl,r,t);
plot(t,y(:,1),t,y(:,2))

