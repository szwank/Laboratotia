clc; clear all; close all;

rng('default'); rng('shuffle')          % parametry generatora liczb losowych
%rng('shuffle');

% INICJALIZACJA PARAMETRÓW

Ts=1;                             % krok symulacji [s]
t=1:Ts:150;                          % czas symulacji [s] 
 
m=2;								% rz¹d modelu procesu
dq=1; 								% odchylenie standardowe szumu procesu
dr=10; 								% odchylenie standardowe szumu pomiaru
ddq=1;							% wariancja szumu procesu
ddr=100;							% wariancja szumu pomiaru


Z=ddq*eye(1);                       % macierz wariancji szumu w(k) procesu (sta³a)
V=ddr*eye(1);           			% macierz wariancji szumu v(k) pomiaru (sta³a)
P=ddq*eye(m);                			    % inicjalizacja macierzy wariancji estymaty procesu (zmienna)


a = 0.35;
xe = [1;1];
x = [1; a];
A = [a x(1);
     0    1];
B = [0;1];
C = [1 0];
G = [1;0];



XP=[];								% historia prognoz procesu x(k+1/k)
XE=[];								% historia estymat procesu x(k/k)
XX=[];								% historia procesu x(k)
ZZ=[];								% historia pomiarów z(k)
KK=[];								% historia wspó³czynnika wzmocnienia K
randn('seed',0);					% szum normalny: œrednia=0, odchylenie standardowe=1

for k = 1:length(t)
      
       % - GENEROWANIE DANYCH Z PROCESU
      % OBLICZENIE STANU MODELU x(k+1)
      A = [a 0; 0 1];
        x=A*x+G*(dq*randn(1,1));
      % WYKONANIE POMIARU z(k+1)
        z=x(1)+dr*randn(1,1);
      A = [xe(2) xe(1); 0 1];
      
%       if k == 150
%           a = 0.9;
%       elseif k == 300
%           a = 0.35;
%       end
              
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
        P=(eye(2)-KA*C)*P1*(eye(2)-KA*C)' + KA*V*KA';
      
      % - ARCHIWIZACJA DANYCH
      % HISTORIA ESTYMACJI
        XP=[XP; x1'];
        XE=[XE; xe'];
        XX=[XX; x'];
        ZZ=[ZZ; z'];
        KK=[KK; (KA(:,1))'];
    
   
end

X1=XX(:,1);% X2=XX(:,2);
Z1=ZZ(:,1); 
X1E=XE(:,1); X2E=XE(:,2);
K1=KK(:,1); K2=KK(:,2);

figure(1);
subplot(3,1,1), plot(t,Z1,'r*', t,X1, 'b', t,X1E, 'g');
title('Zmienna stanu x');
ylabel('Po³o¿enie s [m]');
legend('pomiar','model', 'estymator');
grid on;

subplot(3,1,2), plot( t,a, 'b', t,X2E, 'g');
title('Zmienna stanu a');
ylabel('Wartoœæ a');
legend('Wartoœc rzeczywista','estymator');
grid on;


subplot(3,1,3), plot(t,K1,t,K2);
title('Wzmocnienia Kalmana');
xlabel('czas [s]');
legend('K_{x1}','K_{x2}');
grid on;

figure(2);
subplot(1,1,1), plot(t,X1-Z1, 'b', t,X1-X1E, 'g');
ylabel('B³¹d po³o¿enia [m]');
title('B³¹d po³o¿enia z pomiaru i estymatora');
grid on;