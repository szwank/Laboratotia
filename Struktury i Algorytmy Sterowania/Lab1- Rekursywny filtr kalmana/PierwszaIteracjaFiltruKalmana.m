Ad = [1 0 0.01 0; 0 1 0 0.01; 0 0 1 0; 0 0 0 1];
Bd = [0.0001 0;0 0.0001;0.01 0;0 0.01];
Cd = [1 0 0 0; 0 1 0 0];
G = eye(4,2);
Z = [10 10 ; 10 10];
V = [10 10;
     10 10];
y=[0; 0]
u1 = 0; u2 = 0;
u = [u1;u2];

 x = [pi/2; 0; 0; 0;];
    P = x * x' ;
    xHat_kk1 = Ad * x + Bd * u;
    P_kk1 = Ad * P * Ad' + G * Z * G';
    K = P_kk1 * Cd' * inv(Cd * P_kk1 * Cd' + V);
    P = (eye(4) - K * Cd) * P_kk1 * (eye(4) - K * Cd)' + K * V * K';
    xHat = xHat_kk1 + K * (y - Cd * xHat_kk1)