clear; clc; close all;
%Dane obiektu
%% Motor
Rm = 3.3; % ohms, Motor armature resistance 
Kt = 0.0280; % N.m, Motor torque constant
Km = 0.0280; % V/(rad/s), Motor back-emf constant (same as Ktin SI units)
Jm = 9.64e-6; % kg.m2, Moment of inertia of motor rotor. 
Jeq = 1.23e-4; % kg.m2, Equivalent moment of inertia about motor shaft pivot axis.
%% Pendulum Arm:
Marm = 0.0280; % kg, Mass of the arm.
r = 0.0826; % m, Length of arm pivot to pendulum pivot.
Beq = 0.000; % N.m/(rad/s), Arm viscous damping. 
%% Pendulum Link:
Mp = 0.0270; % kg, Mass of the pendulum link and weight combined.
Lp = 0.191; % m, Total length of pendulum.
lp = 0.153; % m, Length of pendulum center of mass from pivot.
Jp = 1.20e-4; % kg.m2, Pendulum moment of inertia about its pivot axis.
Bp = 0.000; % N.m/(rad/s), Pendulum viscous damping.
%% Pulse-Width Modulated Amplifier:
Vmax = 24; % V, PWM amplifier maximum output voltage
PWM = 5; % A, amplifier maximum output current
Kw = 2.3; % V/V, PWM amplifier gain
%% Sta³e
m = Marm;
g = 9.80665;
%% Skroty do linearyzacij
a = Jeq + m * r^2;
b = m * lp * r;
e = m*lp^2 + Jp;
f = m*g*lp;
c = Km*Kw/Rm;
d = (Km*Kt+Beq*Rm)/Rm;
alfa = 0;
%% Linearyzacja w punktach pracy
[A30,B30] = linearyzacja(pi*30/180);
[A60,B60] = linearyzacja(pi*60/180);
[A90,B90] = linearyzacja(pi*92/180);
[A120,B120] = linearyzacja(pi*120/180);
[A150,B150] = linearyzacja(pi*150/180);
[A180,B180] = linearyzacja(pi*178/180);


[A0,B0]=linearyzacja(0.00000000000000000000000000001);
A0(3:4,2)=[125.66;111.52];%%UWAGA LINEARYZACJA JEST ZLE WYKONANA DLA ALFA RÓWNEGO 0 UWAGA%%
%A90(3,2)=0;
%A90(4,3)=0;
%A180(3:4,2)=[0;0];
%B90(4)=0;
%% wyznaczenie nastaw

Q0 = diag([1.1e-4 3.5e-2 2.22e-5 3.35e-4]);%%0
R0 = 1.33e-4;
K0 = lqr(A0,B0,Q0,R0);


Q30 = diag([5e-2 3.5e-2 2.22e-7 3.35e-4]);%%36
R30 = 1.33e-4;
K30 = lqr(A30,B30,Q30,R30)

%%%%% tu zmieniamy wartoœci macierzy Q60 i R60
Q60 = diag([1.1e-1 3.5e-4 2.22e-1 3.35e-1]);%%72
R60 = 1.33e-4;
K60 = lqr(A60,B60,Q60,R60)

Q90 = diag([100 100 100 0.001]);%%108
R90 = 0.001;
K90 = lqr(A90,B90,Q90,R90)

Q120 = diag([1.1e-3 3.5e-2 2.22e-10 3.35e-10]);%%144
R120 = 1;
K120 = lqr(A120,B120,Q120,R120)

Q150 = diag([20 20 2.22e-10 3.35e-4]);%%180
R150 = 10;
K150 = lqr(A150,B150,Q150,R150)
%K150=acker(A150,B150,[0 3 0 0])
Q180 = diag([20 20 2.22e-10 3.35e-4]);%%180
R180 = 10;
K180 = lqr(A180,B180,Q180,R180)

rank(ctrb((A90),B90))

%% Sprawdzanie stabilnoœci
A=(A0- B0*K0);
P0=lyap(A,ones(4))

wynik=A'*P0+P0*A

A=(A30- B30*K30);
P30=lyap(A',ones(4))



%% LMI
K = [0 0.97 0 0]
 setlmis([])
structureX=[4,1]
P = lmivar(1,structureX) %% zdefiniowanie zmiennej 

A0=(A0- B0*K0);
A30=(A30- B30*K30);
A60=(A60- B60*K60);
A90=(A90- B90*K);
A120=(A120- B120*K);
A150=(A150- B150*K);
A180=(A180- B180*K);
D030=1/2*((A0- B0*K0)+(A0- B0*K30))

% A = zeros(4*7);
% A(1:4,1:4)=(A0- B0*K0)
% A(5:8,5:8)=(A30- B30*K30)
% A(9:12,9:12)=(A60- B60*K60)
% A(13:16,13:16)=(A90- B90*K)
% A(17:20,17:20)=(A120- B120*K)
% A(21:24,21:24)=(A150- B150*K)
% A(25:28,25:28)=(A180- B180*K)
%A = diag([(A0- B0*K0),(A30- B30*K30),(A60- B60*K60),(A90- B90*K),(A120- B120*K),(A150- B150*K),(A180- B180*K)])% zdefiniowanie macierzy A

P = lmivar(1,structureX) %% zdefiniowanie zmiennej --> diag(P0, P30, P60, P90, P120, P150, P180)
lmiterm([1 1 1 P],1,A0','s')%(A0- B0*K0)'*P %% argumenty kolejno typ równania 1=<, -1=>, miejsce w strukturze, która zmienna bierze udzia³
lmiterm([2 1 1 P],1,A30,'s')
lmiterm([3 1 1 P],1,A60,'s')
lmiterm([4 1 1 P],1,A90,'s')
lmiterm([5 1 1 P],1,A120,'s')
lmiterm([6 1 1 P],1,A150,'s')
lmiterm([7 1 1 P],1,A180,'s')
% lmiterm([1 1 1 P],1,D030)%(A0- B0*K0)'*P %% argumenty kolejno typ równania 1=<, -1=>, miejsce w strukturze, która zmienna bierze udzia³
% lmiterm([2 1 1 P],1,A30)
% lmiterm([2 1 1 P],1,A60)
% lmiterm([2 1 1 P],1,A90)
% lmiterm([2 1 1 P],1,A120)
% lmiterm([2 1 1 P],1,A150)
% lmiterm([2 1 1 P],1,A180)
myLMIsystem = getlmis;

[tmin,xfeas] = feasp(myLMIsystem);
P = dec2mat(myLMIsystem,xfeas,P)

