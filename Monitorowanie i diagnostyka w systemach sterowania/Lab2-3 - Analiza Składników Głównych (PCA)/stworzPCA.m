function [ zbior_PCA ] = stworzPCA( dane_wejsciowe_uczace, dane_wejsciowe_testowe )
%Funkcja tworzy model PCA
%   Detailed explanation goes here
%% Hermetyzacja funkcij, dodanie zabespieczeñ

% Check number of inputs.
if nargin > 2
    error('StworzPCA:Za du¿o wejœæ', ...
        'Mo¿na podaæ najwy¿ej 1 opcjonalny argument');
end

% Fill in unset optional values.
switch nargin
    case 1
        dane_wejsciowe_testowe = [1 1; 1 1];
end



X = dane_wejsciowe_uczace;

%% Normalizacja danych
X_norm = normalizuj_dane(dane_wejsciowe_uczace);
XT_norm = normalizuj_dane(dane_wejsciowe_testowe);

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
wektor_wartosci_wlasnych = eig(R)';


%% Przekszta³cenie do nowych wspó³¿êdnych
[wektor_wartosci_wlasnych, macierz_wektorow_wlasnych] = posortuj_wektor_przesuwajac_elementy_w_macierzy(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych);  % sortu, sortu, abra kadabra
X_PCA = X_norm * macierz_wektorow_wlasnych;     %utworzenie danych w PCA
zbior_PCA = X_PCA;              % przyporzadowanie martoœci dla macierzy wyjœcia
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

%% Wyznaczenie SPE dla X PCA
SPE = [];
for i = 1:length(X(:,1))
    
   a = X_norm(i,:) * (macierz_wektorow_wlasnych - macierz_wektorow_wlasnych);
   SPE(i) = (a * a') ^ 2;
end

%% Wyznaczenie T2 dla X PCA


T2 = X_PCA * inv(diag(wektor_wartosci_wlasnych)) * X_PCA';
T2 = diag(T2);

%% Wyznaczenie SPE dla X PCAL
SPE_L = [];
for i = 1:length(X(:,1))
    
   a = X_norm(i,:) * (macierz_wektorow_wlasnych - [zredukowana_macierz_wektorow_wlasnych, zeros(2,1)]);
   SPE_L(i) = (a * a') ^ 2;
end

%% Wyznaczenie T2 dla X PCAL

T2_L = X_PCAL * inv(diag(zredukowany_wektor_wartosci_wlasnych)) * X_PCAL';
T2_L = diag(T2_L);

%% Policzenie granic SPE i T2

SPE_limit = policz_SPE_limit(wektor_wartosci_wlasnych);
T2_limit = policz_T2_limit(X_PCA);

SPE_limit_L = policz_SPE_limit(zredukowany_wektor_wartosci_wlasnych);
T2_limit_L = policz_T2_limit(X_PCAL);
%% wykresiki SPE I T2
figure(2)

subplot(2,2,1)
plot(1:length(SPE), SPE, 'r*')
hold on
plot(1:length(SPE), SPE_limit)
title('SPE')
grid on

subplot(2,2,2)
plot(1:length(SPE_L), SPE_L,'b*')
hold on
plot(1:length(SPE), SPE_limit, 1:length(SPE), -SPE_limit)
title('SPE dla zredukowanego PCA')
grid on

subplot(2,2,3)
plot(1:length(T2), T2, 'b*')
hold on
plot(1:length(T2_limit), T2_limit, 1:length(T2_limit), -T2_limit)
title('T2')
grid on

subplot(2,2,4)
plot(1:length(T2_L), T2_L ,'b*')
title('T2 dla zredukowanego PCA')
hold on
plot(1:length(T2_limit), T2_limit, 1:length(T2_limit), -T2_limit)
grid on

%% Rekonstrukcja danych
X_zrekonstruowany = X_PCA * macierz_wektorow_wlasnych';
XL_zrekunstruowany = X_PCAL * zredukowana_macierz_wektorow_wlasnych';

% wykresik X_zrekonstruowany i XL_zrekunstruowany
figure(3)
plot(X_zrekonstruowany(:,1), X_zrekonstruowany(:,2), 'r*',XL_zrekunstruowany(:,1),XL_zrekunstruowany(:,2),'b*')
hold on
plot(X_norm(1),X_norm(2), 'g*')
title('Zrekonstruowane dane')
legend('Zrekonstruowane dane', 'Zrekonstruowane dane dla zredukowanego PCA', 'Znormalizowane dane')
grid on

%% Miary SPE i T2 dla danych testowych

% SPE
SPE_T = [];
for i = 1:length(XT_norm(:,1))
    
   a = XT_norm(i,:) * (macierz_wektorow_wlasnych - macierz_wektorow_wlasnych);
   SPE_T(i) = (a * a') ^ 2;
end

% SPE reduced
SPE_TL = [];
for i = 1:length(XT_norm(:,1))
    
   a = XT_norm(i,:) * (macierz_wektorow_wlasnych - [zredukowana_macierz_wektorow_wlasnych, zeros(2,1)]);
   SPE_TL(i) = (a * a') ^ 2;
end

% T2
T2_T = XT_norm * macierz_wektorow_wlasnych * inv(diag(wektor_wartosci_wlasnych)) * macierz_wektorow_wlasnych' * XT_norm';
T2_T = diag(T2_T);

% T2 reduced
T2_TL = XT_norm * zredukowana_macierz_wektorow_wlasnych * inv(diag(zredukowany_wektor_wartosci_wlasnych)) * zredukowana_macierz_wektorow_wlasnych' * XT_norm';
T2_TL = diag(T2_TL);

% Wykresik dla danych testowych

figure(4)
subplot(2,2,1)
plot(1:length(SPE_T), SPE_T, 'r*')
title('WskaŸnik SPE- dane testowe, R = 2')
grid on

subplot(2,2,2)
plot(1:length(SPE_TL), SPE_TL, 'r*' )
title('WskaŸnik SPE- dane testowe, R = 1')
grid on

subplot(2,2,3)
plot(1: length(T2_T), T2_T, 'r*')
title('WskaŸnik T2- dane testowe, R = 2')
grid on

subplot(2,2,4)
plot(1: length(T2_TL), T2_TL, 'r*')
title('WskaŸnik T2- dane testowe, R = 1')
grid on








end