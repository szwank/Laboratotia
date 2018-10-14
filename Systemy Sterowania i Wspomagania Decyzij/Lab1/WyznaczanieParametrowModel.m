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
Beq = 0.01; % N.m/(rad/s), Arm viscous damping. 
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
[A45,B45] = linearyzacja(pi*45/180);
[A90,B90] = linearyzacja(pi*90/180);
[A135,B135] = linearyzacja(pi*135/180);
[A180,B180] = linearyzacja(pi);


[A0,B0]=linearyzacja(0.00000000000000000000000000001);
A0(3:4,2)=[125.66;111.52];%%UWAGA LINEARYZACJA JEST ZLE WYKONANA DLA ALFA RÓWNEGO 0 UWAGA%%
%A90(3,2)=0;
%A90(4,3)=0;
%A180(3:4,2)=[0;0];
%B90(4)=0;

