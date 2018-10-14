clc;
clear;

A=[0 1;
   1 0];
B=[0;
   1];
C=[1 -1];
D=0;
u=1;
syms s t;
mac_tranzycij_s=(s*eye(length(A(1,:)))-A)^-1;
mac_tranzycij=ilaplace(mac_tranzycij_s);


odp_swobodna_x_s = mac_tranzycij_s*[0;0];
odp_swobodna_x = ilaplace(odp_swobodna_x_s);

odp_wymuszona_x_s = mac_tranzycij_s*B*u;
odp_wymuszona_x = ilaplace(odp_wymuszona_x_s);

x = odp_swobodna_x + odp_wymuszona_x;


y_s = C * mac_tranzycij_s * [0;0] + C * mac_tranzycij_s * B * u + D * u;
y = C * mac_tranzycij * [0;0] + C * mac_tranzycij * B * u + D * u;

t = 0:0.1:30;

subplot(2,1,1)
yf = matlabFunction(y);
wyjscie=yf(t);
plot(t,wyjscie);
subplot(2,1,2)
xf= matlabFunction(x);
stany = xf(t);
plot(stany(1,:),stany(2,:))

