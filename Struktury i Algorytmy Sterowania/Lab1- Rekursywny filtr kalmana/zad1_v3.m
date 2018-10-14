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

H11 = m1*Lc1^2 + J1 + m2 * (L1^2 + Lc2^2 + 2*L1*Lc2*cos(x2)) + J2;
H22 = m1*Lc1^2 +J2;
H12 = m2*L1*Lc2*cos(x2) + m2*Lc2^2 + J2;
H21 = H12;
h = m2*L1*Lc2*sin(x2);
g1 = m1*Lc1*g*cos(x1) + m2*g*(Lc2*cos(x1+x2) + L1*cos(x1));
g2 = m2*Lc2*g*cos(x1+x2);

H = [H11 H12;
     H21 H22];
J = [-h*x4 -h*x3-h*x4;
     h*x3  0];
G = [g1; g2];
T = [T1; T2];

O = inv(H) * T - inv(H) * G - inv(H) * J * [x3; x4];
O = simplify(O);

% jakobian_A(1) = jacobian(O(1),[x1;x2;x3;x4])
jakobian_A(1,1) = diff(O(1,:), x1);%wyliczenie jakobianu macierzy A
jakobian_A(1,2) = diff(O(1,:), x2);
jakobian_A(1,3) = diff(O(1,:), x3);
jakobian_A(1,4) = diff(O(1,:), x4);
% jakobian_A(2) = jacobian(O(2,:),[x1;x2;x3;x4])
jakobian_A(2,1) = diff(O(2,:), x1);
jakobian_A(2,2) = diff(O(2,:), x2);
jakobian_A(2,3) = diff(O(2,:), x3);
jakobian_A(2,4) = diff(O(2,:), x4);

jakobian_A = [0 0 1 0;
              0 0 0 1;
              jakobian_A];
          
funkcjaZJakobian_A = matlabFunction(jakobian_A);

T1 = 0;
T2 = 0;
J1 = m1*Lc1^2;                                        % wstawienie za bezw³adnoœæ ramion
J2 = m2*Lc2^2;

A = funkcjaZJakobian_A(J1,J2,T1,T2,pi/2,0,0,0);%macierz A
A = double(A);

syms T1 T2% przywrucenie T1 T2
jakobian_B(1,1) = diff(O(1),T1);%wyliczenie jakobianu macierzy B
jakobian_B(1,2) = diff(O(1),T2);
jakobian_B(2,1) = diff(O(2),T1);
jakobian_B(2,2) = diff(O(2),T2);

funkcjaZJakobian_B = matlabFunction(jakobian_B);
B = funkcjaZJakobian_B(J1,J2,0);
B = [0 0;
     0 0;
     B];
C = eye(4);

sterowalnosc = rank(ctrb(A,B));                 %sprawdzenie sterowalnoœci
sprintf('sterowalnoœæ:%1d', sterowalnosc)

KFeedBack = place(A,B,[-1,-3,-5,-7]);
