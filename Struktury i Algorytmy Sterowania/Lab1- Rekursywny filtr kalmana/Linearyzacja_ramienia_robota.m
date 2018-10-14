clear
close all
syms x1 x2 x3 x4 u1 u2
%% Linearyzacja modelu
m1 = 2;
m2 = 1;
L1 = 1.5;
L2 = 1;
Lc1 = L1/2;
Lc2 = L2/2;
J1 = (m1*L1^2)/3;
J2 = (m2*L2^2)/3;
g = 9.81;

H11 = m1 * Lc1^2 + J1 + m2 * (L1^2 + Lc2^2 + 2 * L1 * L2 * cos(x2)) + J2;
H12  = m2 * L1 * Lc2 * cos(x2) + m2 * Lc2^2 + J2;
H21 = H12;
H22 = m2 * Lc2^2 + J2;

h = m2 * L1 * Lc2 * sin(x2);
g1 = m1 * Lc1 * g * cos(x1) + m2 * g * (Lc2 * cos(x1+x2) + L1 * cos(x1));
g2 = m2 * Lc2 * g * cos(x1+x2);

H = [H11 H12;
     H21 H22];
H2 = inv(H);

J = [-h * x4, -h * x3 - h *x4;
     h*x3, 0];
M = [g1;
     g2];
U = [u1;
     u2];

xBis = -1 * H2 * J * [x3; x4] -1 * H2 * M + H2 * U; 
xBis = simplify(xBis)

x = [x1  x2 x3 x4]';

u10 = 0; u20= 0; x30 = 0; x40 = 0; x10 = pi/2; x20 = 0;
x0 = [x10 x20 x30 x40]'

d1 = jacobian(xBis(1), x');%oblicza pochodn¹ cz¹stkow¹ dla f1
d2 = jacobian(xBis(2), x');%oblicza pochodn¹ cz¹stkow¹ dla f2

d1 = subs(d1, [u1, u2, x3, x4, x1, x2], [u10, u20, x30, x40, x10, x20]);
d2 = subs(d2, [u1, u2, x3, x4, x1, x2], [u10, u20, x30, x40, x10, x20]);

A = [0 0 1 0];
A(2,:) = [0 0 0 1];
A(3,:) = d1;
A(4,:) = d2;
A

d1 = jacobian(xBis(1), [u1,u2]);%oblicza pochodn¹ cz¹stkow¹ dla f1
d2 = jacobian(xBis(2), [u1,u2]);%oblicza pochodn¹ cz¹stkow¹ dla f2

d1 = subs(d1, [u1, u2, x3, x4, x1, x2], [u10, u20, x30, x40, x10, x20]);
d2 = subs(d2, [u1, u2, x3, x4, x1, x2], [u10, u20, x30, x40, x10, x20]);

B = [0 0; 0 0; double(d1); double(d2)]

C = [1 0 0 0; 0 1 0 0];

%% Sterowanie

sterowanie = rank(ctrb(A,B))

Q = [100 0 0 0;
     0 100 0 0;
     0 0 1 0;
     0 0 0 1];
R = [1 0 ;
     0 1];
L = lqr(A, B, Q, R)
%L = place(A,B,[-1, -2, -3, -4])

M = inv(C * (B * L - A)^-1 * B)



