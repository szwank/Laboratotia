A = [-100 0 0;
     1 -9 0;
     0 1 0];
 B = [1000;
      0;
      0];
 C = [0 0 0.4];

%% podpunkt a
rzadObserwowalnosci = rank(obsv(A,C))

%% podpunkt b
% postulowany wielomian: x^3+78*x^2+1904*x+14112
syms g1 g2 g3 q;
G = [g1; g2; g3];
wielomian = det(eye(3)*q-A+G*C)
% wielomian uk³adu:
% q^3+(0.4g3+109)*q^2+(43.6g3+0.4g2+900)*q+360g3+40g2+0.4g1
G = [-990720; 10957.5; -77.5];
%% podpunkt c
sys = ss(A,B,C,0);
t = 0:0.01:10; % czas symulacij
u = 1.*t; %wejœcie
[y,t,x] = lsim(sys,u,t,[0 0 0])%zerowe warunki pocz
[yZerWar,t,xZerWar] = lsim(sys,u,t,[4 5 6])%nie zerowe warunki pocz

sysObs=ss(A,[B G],C,0);
%[y,t,x] = lsim(sys,[u y],t,[0 0 0])%zerowe warunki pocz
%% 
system=ss(A,B,C,0);
T=0.011
systemDyskretny = c2d(system,T,'foh')

GDyskretne = acker(systemDyskretny.A',systemDyskretny.C',[exp(T*-14),exp(T*-28),exp(T*-36)])'


