clear
close all
%% Data
syms x1 x2 x3 x4 J1 J2 T1 T2
m1 = 2;
m2 = 1;
L1 = 1.5;
Lc1 = L1/2;
L2 = 1;
Lc2 = L2/2;
g = 9.81;
% J1 = 1; %Nie prawid³owa wartoœæ przypisana wpisana ¿eby policzyœ pochodne
% J2 = 2;

H11 = m1*Lc1^2 + J1 + m2 * (L1^2 + Lc2^2 + 2*L1*L2*cos(x2));
H22 = m1*Lc1^2 +J2;
H12 = m2*L1*L2*cos(x2) + m2*Lc2 + J2;
H21 = H12;
h = m2*L1*Lc2*sin(x2);
g1 = m1*Lc1*g*cos(x1) + m2*g*(Lc2*cos(x1+x2) + L1*cos(x1));
g2 = m2*Lc2*g*cos(x1+x2);

F1 = (H22*H11-H12*H21)/H22;
F2 = (-H11*H22 + H12*H21)/H21;

x6 = -H11*(T2 - h*x3^2 - g2)/(-H11*H22 + H12*H21) + h*x4*x3/F2 - ((-h*x3 - h*x4)*x4)/F2 - g1/F2 + T1/F2;
x5 = -H12*(T2 - h*x3^2 - g2)/(H22*H11 - H12*H21) + h*x4*x3/F1 - (-h*x1-h*x4)*x3/F1 - g/F1 + T1/F1;

%% Linearization
jakobian_A(1,1) = diff(x5, x1);%wyliczenie jakobianu macierzy A
jakobian_A(1,2) = diff(x5, x2);
jakobian_A(1,3) = diff(x5, x3);
jakobian_A(1,4) = diff(x5, x4);

jakobian_A(2,1) = diff(x6, x1);
jakobian_A(2,2) = diff(x6, x2);
jakobian_A(2,3) = diff(x6, x3);
jakobian_A(2,4) = diff(x6, x4);

jakobian_A = [0 0 1 0;
              0 0 0 1;
              jakobian_A];

funkcjaZJakobian_A = matlabFunction(jakobian_A);

% T1 = -h*x4*x3/H12 + (h*x3 - h*x4)*x4/H12 - g/H12;% podstawienie za nominalne trajektorie wejœæ
% T2 = -h*x3^2 - g2;
T1 = 0;
T2 = 0;
J1 = m1*Lc1^2;                                        % wstawienie za bezw³adnoœæ ramion
J2 = m2*Lc2^2;

A = funkcjaZJakobian_A(J1,J2,T1,T2,pi/2,0,0,0);%macierz A
A = double(A);
% A = cell2mat(A)
% A(3,1) = -2.84
% A(3,2) = -2.84
% A(4,1) = -10.47
% A(4,2) = 6.57

syms T1 T2% przywrucenie T1 T2
jakobian_B(1,1) = diff(x5,T1);%wyliczenie jakobianu macierzy B
jakobian_B(1,2) = diff(x5,T2);
jakobian_B(2,1) = diff(x6,T1);
jakobian_B(2,2) = diff(x6,T2);

funkcjaZJakobian_B = matlabFunction(jakobian_B);
B = funkcjaZJakobian_B(J1,J2,0);
B = [0 0;
     0 0;
     B];
C = eye(4);

%% State feedback controll calculation


sterowalnosc = rank(ctrb(A,B));                 %sprawdzenie sterowalnoœci
sprintf('sterowalnoœæ:%1d', sterowalnosc)

KFeedBack = place(A,B,[-15,-6,-9,-12]);                  %wyznaczenie macierzy K

sysStateFeedback = ss(A-B*KFeedBack, B, C, 0);
sysLinear = ss(A,B,C,0);
%% State feedback control symulation
t = 1:0.1:100;
u = zeros(2,length(t));
u(1,:) = 10*sin(t);
u(2,:) = 30*sin(t);
u0 = zeros(2,length(t));
[yL,tL,xL] = lsim(sysLinear,u,t,[pi/2;0;0;0]);
plot(t,yL)
ylim([-10 10])
title('Symulacja Linear')

[y,t,x] = lsim(sysStateFeedback,u,t,[0;0;0;0]);

figure
plot(t,y)
ylim([-10 10])
title('Symulacja state feedback control')

%% Kalman filter without any noise
% Ts = 0.01;
% continousSystem = ss(A, B, C, 0);
% discreteSystem = c2d(continousSystem, Ts);
% 
% % Kalman inicjation
% G = zeros(4,4);
% x0 = [pi/2 0 0 0];
% Pk1 = x0*x0'
% Pkk1 = A*Pk1*A'
% K = (C * (Pkk1 - Pkk1')) * (C * (Pkk1' + Pkk1) * C')
% P = (ones(4) - K * C) * Pkk1 * (ones(4) - K * C)'
% J = (ones(4) - K*C) * A
% L = (ones(4) - K*C) * B
% % Z = zeros(4,4)% Z = E{z*z'}
% % V = zeros(4,4)% V = E{v*v'}
% 
% % % K = Pkk1 * C' * (C * Pkk1 * C' + V)^-1
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
