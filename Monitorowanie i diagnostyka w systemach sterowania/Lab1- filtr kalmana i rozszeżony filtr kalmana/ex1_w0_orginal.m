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
 
m=2;								% rz�d modelu procesu
dq=1; 								% odchylenie standardowe szumu procesu
dr=5; 								% odchylenie standardowe szumu pomiaru
ddq=dq*dq;							% wariancja szumu procesu
ddr=dr*dr;							% wariancja szumu pomiaru

Q=ddq*[(Ts^2/2)^2 (Ts^2/2)*Ts; (Ts^2/2)*Ts Ts^2];
Q=ddq*eye(m); % macierz wariancji szumu w(k) procesu (sta�a)
R=ddr*eye(m);           			% macierz wariancji szumu v(k) pomiaru (sta�a)
P=Q;                			    % inicjalizacja macierzy wariancji estymaty procesu (zmienna)

F=[1 Ts; 0 1];                      % model procesu, macierz przejscia stanu
B=[Ts^2/2 0; 0 Ts];     			% model procesu, macierz przej�cia wymuszenia, wej�cia
G=[Ts^2/2 0; 0 Ts];             	% model procesu, macierz szumu procesu
u=[a a]';                           % modelu procesu, wymuszeni, wej�cie (przyspieszenie)
H=[1 0; 0 0];						% model pomiaru, macierz przej�cia wilko�ci mierzonej
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
        x=F*x+B*u+G*(dq*randn(m,1));
      % WYKONANIE POMIARU z(k+1)
        z=H*x+dr*randn(m,1);
      
      % - ALGORYTM FILTRU KALMANA
      % OBLICZENIE MACIERZY WARIANCJI PROGNOZY P(k+1/k)
        P1=F*P*F'+G*Q*G';
      % OBLICZENIE WZMOCNIENIA KALMANA A(k+1)
        KA=P1*H'*inv(H*P1*H'+R);
      % OBLICZENIE PROGNOZY STANU PROCESU x(k+1/k)
        x1=F*xe+B*u;
      % OBLICZENIE PROGNOZY POMIARU z(k+1/k)
        z1=H*x1;
      % OBLICZENIE ESTYMATY STANU x(k+1/k+1)
        xe=x1+KA*(z-z1);
      % OBLICZENIE MACIERZY WARIANCJI ESTYMATY P(k+1/k+1)
        P=(I-KA*H)*P1*(I-KA*H)' + KA*R*KA';
      
      % - ARCHIWIZACJA DANYCH
      % HISTORIA ESTYMACJI
        XP=[XP; x1'];
        XE=[XE; xe'];
        XX=[XX; x'];
        ZZ=[ZZ; z'];
        KK=[KK; (KA(:,1))'];
end

% WIZUALIZACJA WYNIK�W

X1=XX(:,1); X2=XX(:,2); 
Z1=ZZ(:,1); Z2=ZZ(:,2);
X1E=XE(:,1); X2E=XE(:,2);
K1=KK(:,1); K2=KK(:,2);

figure(1);
subplot(3,1,1), plot(t,Z1,'r*', t,X1, 'b', t,X1E, 'g');
title('Zmienna stanu x_1 - polo�enie s');
ylabel('Po�o�enie s [m]');
legend('pomiar','model', 'estymator');
grid on;
subplot(3,1,2), plot(t,X2, 'b', t,X2E, 'g');
title('Zmienna stanu x_2 - pr�dko�� v');
ylabel('Pr�dko�� [m/s]');
legend('model', 'estymator');
grid on;
subplot(3,1,3), plot(t,K1,t,K2);
title('Wzmocnienia Kalmana');
xlabel('czas [s]');
legend('K_{x1}', 'K_{x2}');
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