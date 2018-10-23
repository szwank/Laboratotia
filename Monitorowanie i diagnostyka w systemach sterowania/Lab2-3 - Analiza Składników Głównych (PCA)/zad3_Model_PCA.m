clc; clear; close all;
load dane_zad1.mat      % Za³adowanie danych
%% Normalizacja danych
X_norm = normalizuj_dane(X);
XT_norm = normalizuj_dane(XT);

%Wykresik X
figure(1)
subplot(2,2,1)
plot(X(:,1), X(:,2),'*')
xlim([-2, 12])
ylim([-5, 12])
title('X');
grid on

%% Wyznaczenie macierzy prze³adowañ
R = X_norm' * X_norm/(length(X(:,1)) - 1);     % Wyznaczenie macierzy korelacij

%Wykresik X_norm
subplot(2,2,2)
plot(X_norm(:,1), X_norm(:,2),'*')
title('X znormalizowane');
xlim([-2, 12])
ylim([-5, 12])
grid on

[macierz_wektorow_wlasnych, D] = eig(R);
wektor_wartosci_wlasnych = eig(R);


%% Przekszta³cenie do nowych wspó³¿êdnych
[wektor_wartosci_wlasnych, macierz_wektorow_wlasnych] = posortuj_wektor_przesuwajac_elementy_w_macierzy(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych);  % sortu, sortu, abra kadabra
X_PCA = X_norm * macierz_wektorow_wlasnych;     %utworzenie danych w PCA

%Wykresik X_norm
subplot(2,2,3)
plot(X_PCA(:,1), X_PCA(:,2),'*')
xlim([-2, 12])
ylim([-5, 12])
title('X PCA');
grid on

%% Uciecie danych wektorów i wartoœci w³asnych
[zredukowany_wektor_wartosci_wlasnych, zredukowana_macierz_wektorow_wlasnych] = Utnij_skladniki_wartosci_wlasnych_mniejsze_od_1(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych);

%% Wyznaczenie zredukowanego PCA
X_PCAL = X_norm * zredukowana_macierz_wektorow_wlasnych;

%Wykresik X_norm
subplot(2,2,4)
plot(X_PCAL(:,1), zeros(1,length(X_PCAL)),'*')
xlim([-2, 12])
ylim([-5, 12])
title('X PCAL');
grid on
%% Wyznaczenie SPE
SPE = [];
for i = 1:length(X(:,1))
    
   a = (X_norm(i,:) * (macierz_wektorow_wlasnych - [zredukowana_macierz_wektorow_wlasnych, zeros(2,1)]));
   SPE(i) = (a * a') ^ 2;
end

%% Wyznaczenie T2 dla X PCAL

T2 = X_PCAL * zredukowany_wektor_wartosci_wlasnych * X_PCAL';






