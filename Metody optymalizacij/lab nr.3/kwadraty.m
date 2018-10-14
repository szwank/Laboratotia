function suma=kwadraty(x)


%{
x=[x
   x'
   kat
   kat']
%}
%dane pomiarowe
m = x(1);
l = x(2);
I = x(3);

M=0.5;
b=0.1;
g=9.81;
T=0.01;
t=0:T:1;

u=0.2.*ones(101,1);
load('dane1_wah_grupa4.mat')



k=I*(M+m)+M*m*(l^2);

A=[0, 1, 0, 0;
   0, -(I+m*(l^2))/k, ((m^2)*g*(l^2))/k, 0;
   0, 0, 0, 1;
   0, (-m*l*b)/k, (m*g*l*(M+m))/k, 0];

B=[0;
   (I+m*(l^2))/k;
   0;
   m*l/k];

C=[1 0 0 0;
   0 0 1 0];

D=[0;
   0];

sys=ss(A,B,C,D);
[y,t,x]=lsim(sys,u,t);
%szukane m, l, I
%{
   
   
   
   
%}
suma=0;
for i=0:1:100
    
    suma = suma + (dane1.ym(i+1,1)-y(i+1,1))^2 + (dane1.ym(i+1,2)-y(i+1,2))^2
    
end

