%{
A=[-0.14 0.33 -0.33;
   0.1 -0.28 0;
   0 1.7 -0.77];
B=[0;
   0;
   -0.025];
C=[2 0 0];

q=[0 1250 0];

V=[0 1250 0;
   125 -350 0;
   -52.5 139.25 -41.25];

Accf = V*A*inv(V);
Bccf = V*B;
Cccf = C*inv(V);
lccf(1) = 0.3008 - Accf(3,1);
lccf(2) = 1.3467 - Accf(3,2);
lccf(3) = 2.01 - Accf(3,3);
%lccf = [0.2399 1.10171 0.82];
L = lccf * V;
syms r;
wielomian = det(r*eye(3)-A+B*L)
%}

%% zad1 II
A = [0 1 0;
     0 0 1
     -52 -30 -4];
B = [0;
     0;
     1];
C = [20 1 0];

Ahat = [A zeros(3,1);
        C 0];
Bhat = [B;
        0];
syms q1 q2 q3 q4;

q=[q1 q2 q3 q4];
q=[-1/20 0 0 1/20];

V=[q;
   q*Ahat;
   q*Ahat^2;
   q*Ahat^3];
