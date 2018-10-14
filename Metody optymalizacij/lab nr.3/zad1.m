%{
x=[x
   x'
   kat
   kat']
%}
%dane pomiarowe
M=0.5;
b=0.1;
g=9.81;
T=0.01;
t=0:T:20;

u=1;


syms m l I;

k=I*(M+m)+M*m*l^2;

A=[0 1 0 0;
   0 (-(I+m*l^2)/k) (m^2*g*l^2/k) 0;
   0 0 0 0;
   0 (-m*l*b/k) (m*g*l(M+m)/k) 0];

B=[0;
   (I+m*l^2)/k;
   0;
   m*l/k];

C=[1 0 0 0;
   0 0 1 0];

D=[0;
   0];

sys=ss(A,B,C,D)
[y,t,x]=lsim(sys,u,t)
%szukane m, l, I
%{
   
   
   
   
%}


