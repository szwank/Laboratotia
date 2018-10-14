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
[A30,B30] = linearyzacja(pi/6);
[A60,B60] = linearyzacja(pi/3);
[A90,B90] = linearyzacja(pi/2);
[A120,B120] = linearyzacja(pi*4/6);
[A150,B150] = linearyzacja(pi*5/6);
[A180,B180] = linearyzacja(pi-0.001);

[A0,B0]=linearyzacja(0.00000000000000000000000000001);
A0(3:4,2)=[125.66;111.52];%%UWAGA LINEARYZACJA JEST ZLE WYKONANA DLA ALFA RÓWNEGO 0 UWAGA%%
A90(3,2)=0;
A90(4,3)=0;
A180(3:4,2)=[0;0];
B90(4)=0;
%% wyznaczenie nastaw

Q0 = diag([1.1e-1 3.5e-2 2.22e-5 3.35e-4]);
R0 = 1.33e-4;
K0 = lqr(A0,B0,Q0,R0);


Q30 = diag([1.1e-1 3.5e-2 2.22e-5 3.35e-4]);
R30 = 1.33e-4;
K30 = lqr(A30,B30,Q30,R30)

%%%%% tu zmieniamy wartoœci macierzy Q60 i R60
Q60 = diag([1.1e-1 1 2.22e-5 3.35e-4]);
R60 = 100;
K60 = lqr(A60,B60,Q60,R60)




rank(ctrb((A0),B0))
