clc; clear all; close all;

rng('default'); rng(8787);          % parametry generatora liczb losowych
%rng('shuffle');

% INICJALIZACJA PARAMETRÓW

a=1;                                % przyspieszenie pojazdu [m/s^2]
Ts=1;                             % krok symulacji [s]
t=1:Ts:50;                          % czas symulacji [s] 
 
m=1;								% rz¹d modelu procesu
dq=10; 								% odchylenie standardowe szumu procesu
dr=10; 								% odchylenie standardowe szumu pomiaru
ddq=10;							% wariancja szumu procesu
ddr=100;							% wariancja szumu pomiaru


Z=ddq*eye(m); % macierz wariancji szumu w(k) procesu (sta³a)
V=ddr*eye(m);           			% macierz wariancji szumu v(k) pomiaru (sta³a)
P=Z;                			    % inicjalizacja macierzy wariancji estymaty procesu (zmienna)

A = 1;
B = 0;
C = 1;
G = 0;

x = 104;
xe = 100;

XP=[];								% historia prognoz procesu x(k+1/k)
XE=[];								% historia estymat procesu x(k/k)
XX=[];								% historia procesu x(k)
ZZ=[];								% historia pomiarów z(k)
KK=[];								% historia wspó³czynnika wzmocnienia K
randn('seed',0);					% szum normalny: œrednia=0, odchylenie standardowe=1

for k = 1:length(t)
    
      % - GENEROWANIE DANYCH Z PROCESU
      % OBLICZENIE STANU MODELU x(k+1)
        x=A*x+G*(dq*randn(1,1));
      % WYKONANIE POMIARU z(k+1)
        z=A*x+dr*randn(1,1);
      
      % - ALGORYTM FILTRU KALMANA
      % OBLICZENIE MACIERZY WARIANCJI PROGNOZY P(k+1/k)
        P1=A*P*A'+G*Z*G';
      % OBLICZENIE WZMOCNIENIA KALMANA A(k+1)
        KA=P1*C'*inv(C*P1*C'+V);
      % OBLICZENIE PROGNOZY STANU PROCESU x(k+1/k)
        x1=A*xe;
      % OBLICZENIE PROGNOZY POMIARU z(k+1/k)
        z1=C*x1;
      % OBLICZENIE ESTYMATY STANU x(k+1/k+1)
        xe=x1+KA*(z-z1);
      % OBLICZENIE MACIERZY WARIANCJI ESTYMATY P(k+1/k+1)
        P=(1-KA*C)*P1*(1-KA*C)' + KA*V*KA';
      
      % - ARCHIWIZACJA DANYCH
      % HISTORIA ESTYMACJI
        XP=[XP; x1'];
        XE=[XE; xe'];
        XX=[XX; x'];
        ZZ=[ZZ; z'];
        KK=[KK; (KA(:,1))'];
    
   
end

X1=XX(:,1);
Z1=ZZ(:,1); 
X1E=XE(:,1);
K1=KK(:,1);

figure(1);
subplot(2,1,1), plot(t,Z1,'r*', t,X1, 'b', t,X1E, 'g');
title('Zmienna stanu x_1 - polo¿enie s');
ylabel('Po³o¿enie s [m]');
legend('pomiar','model', 'estymator');
grid on;

subplot(2,1,2), plot(t,K1);
title('Wzmocnienia Kalmana');
xlabel('czas [s]');
legend('K_{x1}');
grid on;

figure(2);
subplot(1,1,1), plot(t,X1-Z1, 'b', t,X1-X1E, 'g');
ylabel('B³¹d po³o¿enia [m]');
title('B³¹d po³o¿enia z pomiaru i estymatora');
grid on;