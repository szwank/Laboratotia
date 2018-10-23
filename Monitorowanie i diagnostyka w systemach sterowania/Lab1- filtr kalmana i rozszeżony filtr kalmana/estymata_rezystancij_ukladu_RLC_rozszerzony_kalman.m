clc; clear all; close all;

rng('default'); rng(8787);          % parametry generatora liczb losowych
%rng('shuffle');

% INICJALIZACJA PARAMETRÓW

a=1;                                % przyspieszenie pojazdu [m/s^2]
Ts=0.001;                             % krok symulacji [s]
t=0:Ts:600*Ts-Ts;                          % czas symulacji [s] 
 
m=3;								% rz¹d modelu procesu
dq=0.01; 								% odchylenie standardowe szumu procesu
dr=0.05; 								% odchylenie standardowe szumu pomiaru
ddq=dq*dq;							% wariancja szumu procesu
ddr=dr*dr;							% wariancja szumu pomiaru

Q=ddq*[(Ts^2/2)^2 (Ts^2/2)*Ts; (Ts^2/2)*Ts Ts^2];
Q=ddq*eye(1); % macierz wariancji szumu w(k) procesu (sta³a)
R=ddr*eye(2);           			% macierz wariancji szumu v(k) pomiaru (sta³a)
P=ddq*eye(m);                			    % inicjalizacja macierzy wariancji estymaty procesu (zmienna)

L = 1;
Ck = 0.02;
x = [0;
     0;
     30];
xe = [0;
     0;
     20];
Uwe = 1;


A = [-Ts*L -Ts*x(3)/L+1 -Ts*x(2)/L;
     1      Ts/Ck         0      ;
     0        0          1      ];

B = [Ts/L;
     0;
     0];
 
G = [Ts/L;
     0;
     0];             	% model procesu, macierz szumu procesu
u = [Uwe];                           % modelu procesu, wymuszeni, wejœcie (przyspieszenie)
C = [1 0 0;
     0 1 0];						% model pomiaru, macierz przejœcia wilkoœci mierzonej
I = eye(m);							% macierz jednostkowa


XP=[];								% historia prognoz procesu x(k+1/k)
XE=[];								% historia estymat procesu x(k/k)
XX=[];								% historia procesu x(k)
ZZ=[];								% historia pomiarów z(k)
KK=[];								% historia wspó³czynnika wzmocnienia K
randn('seed',0);					% szum normalny: œrednia=0, odchylenie standardowe=1

% PÊTLA G£ÓWNA ESTYMATORA

for k = 1:length(t)
              
      % - GENEROWANIE DANYCH Z PROCESU
      % OBLICZENIE STANU MODELU x(k+1)
        x2 = (Ts/L)*(u-x(3)*x(2)-x(1)) + x(2) + (Ts/L) * dq * randn;
        x1 = x(2)*Ts/Ck + x(1);
        x = [x1;x2;x(3)];
      % WYKONANIE POMIARU z(k+1)
        z=C*x+dr*randn(2,1);
      A = [1      Ts/Ck         0      ;
          -Ts*L -Ts*xe(3)/L+1 -Ts*xe(2)/L;
            0        0           1     ];
        if k == 300
            u = 0;
        end
      % - ALGORYTM FILTRU KALMANA
      % OBLICZENIE MACIERZY WARIANCJI PROGNOZY P(k+1/k)
        P1=A*P*A'+G*Q*G';
      % OBLICZENIE WZMOCNIENIA KALMANA A(k+1)
        KA=P1*C'*inv(C*P1*C'+R);

      % OBLICZENIE PROGNOZY POMIARU z(k+1/k)
        z1=C*(A*xe+B*u);
      % OBLICZENIE ESTYMATY STANU x(k+1/k+1)
        xe=A*xe+B*u+KA*(z-z1);
      % OBLICZENIE MACIERZY WARIANCJI ESTYMATY P(k+1/k+1)
        P=(I-KA*C)*P1*(I-KA*C)' + KA*R*KA';
      
      % - ARCHIWIZACJA DANYCH
      % HISTORIA ESTYMACJI
        XP=[XP; x1'];
        XE=[XE; xe'];
        XX=[XX; x'];
        ZZ=[ZZ; z'];
        KK=[KK; (KA(:,1))'];
end

% WIZUALIZACJA WYNIKÓW

X1=XX(:,1); X2=XX(:,2);  X3=XX(:,3);
Z1=ZZ(:,1); Z2=ZZ(:,2);
X1E=XE(:,1); X2E=XE(:,2); X3E=XE(:,3);
K1=KK(:,1); K2=KK(:,2); K3=KK(:,3);

figure(1);
subplot(4,1,1), plot(t,Z1,'r*', t,X1, 'b', t,X1E, 'g');
title('Zmienna stanu x_1 - napiêcie na kondensatorze');
ylabel('napiêcie na kondensatorze [V]');
legend('pomiar','model', 'estymator');
grid on;
subplot(4,1,2), plot(t,X2, 'b', t,X2E, 'g');
title('Zmienna stanu x_2 - natê¿enie na cewce');
ylabel('natê¿enie na cewce [A]');
legend('model', 'estymator');
grid on;
subplot(4,1,3), plot(t,X3, 'b', t,X3E, 'g');
title('Zmienna stanu x_2 - estymowana rezystancja');
ylabel('estymowana rezystancja [Ohm]');
legend('model', 'estymator');
grid on;
subplot(4,1,4), plot(t,K1,t,K2,t,K3);
title('Wzmocnienia Kalmana');
xlabel('czas [s]');
legend('K_{x1}', 'K_{x2}', 'K_{x3}');
grid on;

figure(2);
subplot(2,1,1), plot(t,X1-Z1, 'b', t,X1-X1E, 'g');
ylabel('B³¹d napiêcia [V]');
title('B³¹d napiêcia z pomiaru i estymatora');
grid on;
subplot(2,1,2), plot(t,X2-Z2, 'b', t,X2-X2E, 'g');
ylabel('B³¹d natêzenia [A]');
title('B³¹d natê¿enia z pomiaru i estymatora');
grid on;