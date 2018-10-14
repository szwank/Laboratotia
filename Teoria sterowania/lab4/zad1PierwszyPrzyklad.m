A = [-1 0;
     0 -2];
B = [1;
     sqrt(2)];
C = [1 -2/sqrt(2)];


%% podpunkt a
bieguny = eig(A)
sterowalnosc = rank(ctrb(A,B))
%% podpunkt b
sys=ss(A,B,C,0);
[y,t,x]=step(sys);
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2))
title('x1,x2')
subplot(1,2,2);
plot(t,y)
title('y')
%% podpunkt c
fun=@(x)(100*exp(-pi.*x./(sqrt(1-x.^2)))-0.01);
 przeregulowanie=fzero(@(x)(100*exp(-pi*x/(sqrt(1-x^2)))-0.01),0);
 t=-100:0.1:100;
fun(0.9998)
%%zakladamy ze wartosc wynoci 1
wn=double(2.995/(1*1))% wartoœc dla 95% wartoœci ustalonej

bieguny_cI=roots([1 2*wn wn^2])
%% podpunkt d
L=place(A,B,(bieguny_cI));
%% podpunkt e
sysL=ss(A-B*L,B,C,0);
[y,t,x]=step(sysL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2))
title('x1,x2- sysL')
ylim([0 1])
subplot(1,2,2);
plot(t,y)
title('y- sysL')
ylim([-0.25 0])
%% podpunkt f
Ahat = [A zeros(2,1);
        -C 0];
Bhat = [B;
        0];
%Lhat = place(Ahat,Bhat,[-2.995 -2.995 -2.995])

%% podpunkt j

sys=ss(A,B,C,0,0.001);

Ahat = [sys.A zeros(2,1);
        -sys.C 0];
Bhat = [sys.B;
        0];
Lhat = place(Ahat,Bhat,[-2.995 -2.995 -2.995]);

