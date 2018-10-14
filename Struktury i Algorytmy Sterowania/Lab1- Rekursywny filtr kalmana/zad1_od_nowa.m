clear
close all
%% Data
syms x1 x2 x3 x4 u1 u2
m1 = 2;
m2 = 1;
L1 = 1.5;
Lc1 = L1/2;
L2 = 1;
Lc2 = L2/2;
g = 9.81;
J1 = (m1*L1^2)/3;                                        % wstawienie za bezw³adnoœæ ramion
J2 = (m2*L2^2)/3;

H11 = m1*Lc1^2 + J1 + m2 * (L1^2 + Lc2^2 + 2*L1*Lc2*cos(x2)) + J2;
H22 = m2*Lc2^2 +J2;
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
T = [u1; u2];

O = inv(H) * (T - G - J * [x3; x4]);
O = simplify(O);
x = [x1, x2, x3, x4]';
a1 = jacobian(O(1), x');
% jakobian_A(1,1) = diff(O(1,:), x1);%wyliczenie jakobianu macierzy A
% jakobian_A(1,2) = diff(O(1,:), x2);
% jakobian_A(1,3) = diff(O(1,:), x3);
% jakobian_A(1,4) = diff(O(1,:), x4);
a2 = jacobian(O(2,:), x');
% jakobian_A(2,1) = diff(O(2,:), x1);
% jakobian_A(2,2) = diff(O(2,:), x2);
% jakobian_A(2,3) = diff(O(2,:), x3);
% jakobian_A(2,4) = diff(O(2,:), x4);

a1 = subs(a1, [u1, u2, x3, x4, x1, x2], [0,0,0,0,pi/2,0]);
a2 = subs(a2, [u1, u2, x3, x4, x1, x2], [0,0,0,0,pi/2,0]); 

A_linear = [0 0 1 0;
            0 0 0 1];
A_linear(3,:) = a1;
A_linear(4,:) = a2;
            
A_linear = double(A_linear)
          
% funkcjaZJakobian_A = matlabFunction(jakobian_A);

u1 = 0;
u2 = 0;


% A_linear = funkcjaZJakobian_A(u1,u2,pi/2,0,0,0);%macierz A
% A_linear = double(A_linear);

syms T1 T2% przywrucenie T1 T2
jakobian_B(1,1) = diff(O(1),u1);%wyliczenie jakobianu macierzy B
jakobian_B(1,2) = diff(O(1),u2);
jakobian_B(2,1) = diff(O(2),u1);
jakobian_B(2,2) = diff(O(2),u2);

funkcjaZJakobian_B = matlabFunction(jakobian_B);
B_linear = funkcjaZJakobian_B(0,0,pi/2,0,0,0);
B_linear = [0 0;
     0 0;
     B_linear];
C = eye(4);

sterowalnosc = rank(ctrb(A_linear,B_linear));                 %sprawdzenie sterowalnoœci
sprintf('sterowalnoœæ:%1d', sterowalnosc)

Q = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
R = [1,0 ; 0,1];
%K_Feedback = lqr(A_linear, B_linear, Q, R)
%K_Feedback = place(A_linear,B_linear,[-1,-2,-3,-4])

