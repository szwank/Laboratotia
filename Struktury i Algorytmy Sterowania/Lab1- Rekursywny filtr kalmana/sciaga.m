clear
close all
syms m1 m2 J1 J2 lc1 lc2 a1 a2 aPrim1 aPrim2 g l1 l2 u1 u2  aBis
m1 = 2; m2 = 1; l1 = 1.5; l2 = 1; lc1 = l1/2; lc2 = l2/2; J1 = (m1*l1^2)/3; J2 = (m2*l2^2)/3; g = 9.81;
H11 = m1*lc1^2 + J1 + m2*(l1^2 + lc2^2 + 2*l1*l2*cos(a2)) + J2;
H12  = m2*l1*lc2*cos(a2) + m2*lc2^2 + J2;
H21 = H12;
H22 = m2*lc2^2 + J2;
h = m2*l1*lc2*sin(a2);
g1 = m1*lc1*g*cos(a1) + m2*g*(lc2*cos(a1+a2)+l1*cos(a1));
g2 = m2*lc2*g*cos(a1+a2);
H = [H11 H12; H21 H22];
H2 = inv(H);

J = [-h*aPrim2, -h*aPrim1-h*aPrim2; h*aPrim1,0];
M = [g1;g2];
U = [u1;u2];
%rozwik³anie 
Roz = -1*H2*J*[aPrim1; aPrim2] -1*H2*M + H2*U; 
aBis = simplify(Roz)
%stan umys³u:
x = [a1  a2 aPrim1 aPrim2]';
%punkt pracy
u10 = 0; u20= 0; aPrim10 = 0; aPrim20 = 0; a10 = pi/2; a20 = 0;
x0 = [a10 a20 aPrim10 aPrim20]'
%rów cz¹stkowe
d1 = jacobian(aBis(1),x');%oblicza pochodn¹ cz¹stkow¹ dla f1
d2 = jacobian(aBis(2),x');%oblicza pochodn¹ cz¹stkow¹ dla f2
%podstawiam wsp pkt pracy
d1 = subs(d1, [u1, u2, aPrim1, aPrim2, a1, a2], [u10, u20, aPrim10, aPrim20, a10, a20]);
d2 = subs(d2, [u1, u2, aPrim1, aPrim2, a1, a2], [u10, u20, aPrim10, aPrim20, a10, a20]);
%budujê macierz A
A = [0 0 1 0]
A(2,:) = [0 0 0 1];
A(3,:) = d1;
A(4,:) = d2;
A
%TERAZ MACIERZ B
d1 = jacobian(aBis(1), [u1,u2]);%oblicza pochodn¹ cz¹stkow¹ dla f1
d2 = jacobian(aBis(2), [u1,u2]);%oblicza pochodn¹ cz¹stkow¹ dla f1
%podstawiam wsp pkt pracy
d1 = subs(d1, [u1, u2, aPrim1, aPrim2, a1, a2], [u10, u20, aPrim10, aPrim20, a10, a20]);
d2 = subs(d2, [u1, u2, aPrim1, aPrim2, a1, a2], [u10, u20, aPrim10, aPrim20, a10, a20]);
%sk³adam macierz B
B = [0 0; 0 0; double(d1); double(d2)]
%rów wyjœcia
%opcja 1 czyli sensory prêdkoœci i po³o¿enia, stan jest dostêpny pomiarowo
C = [1 0 0 0; 0 1 0 0];

%% STEROWANIE5
%sprawdzam sterowalnoœæ
ster = rank(ctrb(A,B))
%wyznaczam wzmocnienia wstecz
Q = [100 0 0 0; 0 100 0 0; 0 0 1 0; 0 0 0 1];
R = [1,0 ; 0,1];
L = lqr(A,B,Q,R)
%L = place(A,B,[-1, -2, -3, -4])

M = inv(C * (B * L - A)^-1 * B)



