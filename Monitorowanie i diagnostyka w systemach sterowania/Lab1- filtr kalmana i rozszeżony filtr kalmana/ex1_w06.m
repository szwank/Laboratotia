%************************************************************************
%  MiDwSS Przyk�ad 1: Filtr Kalmana - filtracja sygna�u z GPS           *
%************************************************************************
 
clc; clear all; close all;

rng('default'); rng(8787);          % parametry generatora liczb losowych
%rng('shuffle');

% INICJALIZACJA PARAMETR�W

a=1;                                % przyspieszenie pojazdu [m/s^2]
Ts=50;                             % krok symulacji [s]
t=0:Ts:1000;                          % czas symulacji [s] 
 
m=3;								% rz�d modelu procesu
dq=1; 								% odchylenie standardowe szumu procesu
dr=5; 								% odchylenie standardowe szumu pomiaru
ddq=dq*dq;							% wariancja szumu procesu
ddr=dr*dr;							% wariancja szumu pomiaru

%Q=ddq*[(Ts^2/2)^2 (Ts^2/2)*Ts; (Ts^2/2)*Ts Ts^2];   % macierz wariancji szumu w(k) procesu (sta�a)
Q=ddq*eye(1); 
R=ddr*eye(1);           			% macierz wariancji szumu v(k) pomiaru (sta�a)
P=zeros(3,3);                			    % inicjalizacja macierzy wariancji estymaty procesu (zmienna)

A=[1 Ts Ts^2/2;
   0 1 Ts;
   0 0 0];                      % model procesu, macierz przejscia stanu
B=[0;
   0;
   1];     			% model procesu, macierz przej�cia wymuszenia, wej�cia
G=[0;
   0;
   1];             	% model procesu, macierz szumu procesu
u=a;                           % modelu procesu, wymuszeni, wej�cie (przyspieszenie)
C=[1 0 0];						% model pomiaru, macierz przej�cia wilko�ci mierzonej
I=eye(m);							% macierz jednostkowa

x=zeros(m,1);						% warto�� pocz�tkowa wektora stanu
xe=zeros(m,1);						% warto�� pocz�tkowa estymaty wektora stanu x(k/k)
XP=[];								% historia prognoz procesu x(k+1/k)
XE=[];								% historia estymat procesu x(k/k)
XX=[];								% historia procesu x(k)
ZZ=[];								% historia pomiar�w z(k)
KK=[];								% historia wsp�czynnika wzmocnienia K
randn('seed',0);					% szum normalny: �rednia=0, odchylenie standardowe=1

% P�TLA G��WNA ESTYMATORA

for k = 1:length(t)
              
      % - GENEROWANIE DANYCH Z PROCESU
      % OBLICZENIE STANU MODELU x(k+1)
        x=A*x+B*u+G*(dq*randn(1,1));
      % WYKONANIE POMIARU z(k+1)
        z=C*x+dr*randn(1,1);
      
      % - ALGORYTM FILTRU KALMANA
      % OBLICZENIE MACIERZY WARIANCJI PROGNOZY P(k+1/k)
        P1=A*P*A'+G*Q*G';
      % OBLICZENIE WZMOCNIENIA KALMANA A(k+1)
        KA=P1*C'*inv(C*P1*C'+R);
      % OBLICZENIE PROGNOZY STANU PROCESU x(k+1/k)
        x1=A*xe+B*u;
      % OBLICZENIE PROGNOZY POMIARU z(k+1/k)
        z1=C*x1;
      % OBLICZENIE ESTYMATY STANU x(k+1/k+1)
        xe=x1+KA*(z-z1);
      % OBLICZENIE MACIERZY WARIANCJI ESTYMATY P(k+1/k+1)
        P=(I-KA*C)*P1;
      
      % - ARCHIWIZACJA DANYCH
      % HISTORIA ESTYMACJI
        XP=[XP; x1'];
        XE=[XE; xe'];
        XX=[XX; x'];
        ZZ=[ZZ; z'];
        KK=[KK; (KA(:,1))'];
end

% WIZUALIZACJA WYNIK�W

X1=XX(:,1); X2=XX(:,2); X3=XX(:,3);
Z1=ZZ(:,1); %Z2=ZZ(:,2);
X1E=XE(:,1); X2E=XE(:,2); X3E=XE(:,3);
K1=KK(:,1); K2=KK(:,2); K3=KK(:,3);

figure(1);
subplot(4,1,1), plot(t,Z1,'r*', t,X1, 'b', t,X1E, 'g');
title('Zmienna stanu x_1 - polo�enie s');
ylabel('Po�o�enie s [m]');
legend('pomiar','model', 'estymator');
grid on;
subplot(4,1,2), plot(t,X2, 'b', t,X2E, 'g');
title('Zmienna stanu x_2 - pr�dko�� v');
ylabel('Pr�dko�� [m/s]');
legend('model', 'estymator');
grid on;
subplot(4,1,4), plot(t,K1,t,K2,K3,t);
title('Wzmocnienia Kalmana');
xlabel('czas [s]');
legend('K_{x1}', 'K_{x2}', 'K_{x3}');
grid on;
subplot(4,1,3), plot(t,X3, 'b', t,X3E, 'g');
title('Zmienna stanu x_2 - pr�dko�� a');
ylabel('Pr�dko�� [m/s^2]');
legend('model', 'estymator');
grid on;

figure(2);
subplot(2,1,1), plot(t,X1-Z1, 'b', t,X1-X1E, 'g');
ylabel('B��d po�o�enia [m]');
title('B��d po�o�enia z pomiaru i estymatora');
grid on;
subplot(2,1,2), plot(t,X2-X2E, 'b');
xlabel('czas [s]');
ylabel('B��d pr�dko�ci [m/s]');
title('B��d pr�dko�ci z estymatora');
grid on;