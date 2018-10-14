clc;
clear;


wartosci=fmincon(@kwadraty,[0.1, 0.1, 0.1],[],[],[],[],[0, 0, 0],[2, 1, 1]);


m = wartosci(1);
l = wartosci(2);
I = wartosci(3);


M=0.5;
b=0.1;
g=9.81;
T=0.01;
t=0:T:1;

u=0.2.*ones(101,1);
load('dane1_wah_grupa4.mat')



k=I*(M+m)+M*m*l^2;

A=[0, 1, 0, 0;
   0, -(I+m*l^2)/k, (m^2*g*l^2)/k, 0;
   0, 0, 0, 1;
   0, (-m*l*b)/k, (m*g*l*(M+m))/k, 0];

B=[0;
   (I+m*l^2)/k;
   0;
   m*l/k];

C=[1 0 0 0;
   0 0 1 0];

D=[0;
   0];

sys=ss(A,B,C,D);
[y,t,x]=lsim(sys,u,t);

subplot(1,2,1)
plot(t,y(:,1))

subplot(1,2,2)
plot(t,dane1.ym(:,1))

figure

subplot(1,2,1)
plot(t,y(:,2))

subplot(1,2,2)
plot(t,dane1.ym(:,2))
