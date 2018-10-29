function [ X_PCA, X_PCAL_1, X_PCAL_pro ] = stworzPCA( dane_uczace, dane_testowe, procent_redukcij, procent_T2, procent_SPE )
%Funkcja tworzy model PCA. 
%Argumenty kolejno:
%Dane_ucz¹ce, dane testowe, procent redukcij uk³adu, procent ufnoœci dla
%limitu T2, procent ufnoœci dla limitu SPE
%% Hermetyzacja funkcij, dodanie zabespieczeñ

% Check number of inputs.
if nargin > 5
    error('StworzPCA:Za du¿o wejœæ', ...
        'Mo¿na podaæ najwy¿ej 1 opcjonalny argument');
end

% Fill in unset optional values.
switch nargin
    case 1
        dane_testowe = [1 1; 1 1];
        procent_redukcij = 0.30;
        procent_T2 = 0.95;
        procent_SPE = 0.95;
    case 2
        procent_redukcij = 0.30;
    case 3
        procent_T2 = 0.95;
        procent_SPE = 0.95;
    case 4
        procent_SPE = procent_T;
end



X = dane_uczace;
XT = dane_testowe;
%% Normalizacja danych
[X_norm, X_mean, X_odchylenie_standardowe] = normalizuj_dane(X);
XT_norm = normalizuj_dane(XT, X_mean, X_odchylenie_standardowe);

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

%Wykresik X_norm
subplot(2,2,3)
plot(X_PCA(:,1), X_PCA(:,2),'*')
xlim([-2, 12])
ylim([-5, 12])
title('X PCA');
grid on

%% Redukcja uk³adu PCA
[zredukowany_wektor_wartosci_wlasnych_1, zredukowana_macierz_wektorow_wlasnych_1] =...              % uciêcie wartoœci poni¿ej 1
    Utnij_skladniki_wartosci_wlasnych_mniejsze_od_1(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych);

[ zredukowany_wektor_wartosci_wlasnych_pro, zredukowana_macierz_wektorow_wlasnych_pro ] =...        % zredukowanie o zadany procent
    zredukuj_PCA_o_zadana_wartosc(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych, procent_redukcij);
%% Wyznaczenie zredukowanego PCA
X_PCAL_1 = X_norm * zredukowana_macierz_wektorow_wlasnych_1;
X_PCAL_pro = X_norm * zredukowana_macierz_wektorow_wlasnych_pro;

%Wykresik X_norm
subplot(2,2,4)
plot(X_PCAL_1(:,1), zeros(1,length(X_PCAL_1)),'*')
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

%% Wyznaczenie SPE dla X PCAL_1
SPE_L_1 = [];
for i = 1:length(X(:,1))
    
   a = X_norm(i,:) * (macierz_wektorow_wlasnych - [zredukowana_macierz_wektorow_wlasnych_1, ...
       zeros(length(macierz_wektorow_wlasnych(:,1)), ...
       length(macierz_wektorow_wlasnych(1,:)) - length(zredukowana_macierz_wektorow_wlasnych_1(1,:)))]);
   SPE_L_1(i) = (a * a') ^ 2;
end

%% Wyznaczenie T2 dla X PCAL_1

T2_L_1= X_PCAL_1 * inv(diag(zredukowany_wektor_wartosci_wlasnych_1)) * X_PCAL_1';
T2_L_1 = diag(T2_L_1);

%% Wyznaczenie SPE dla X PCAL_pro
SPE_L_pro = [];
for i = 1:length(X(:,1))
    
   a = X_norm(i,:) * (macierz_wektorow_wlasnych - [zredukowana_macierz_wektorow_wlasnych_pro, ...
       zeros(length(macierz_wektorow_wlasnych(:,1)), ...
       length(macierz_wektorow_wlasnych(1,:)) - length(zredukowana_macierz_wektorow_wlasnych_pro(1,:)))]);
   SPE_L_pro(i) = (a * a') ^ 2;
end

%% Wyznaczenie T2 dla X PCAL_pro

T2_L_pro = X_PCAL_pro * inv(diag(zredukowany_wektor_wartosci_wlasnych_pro)) * X_PCAL_pro';
T2_L_pro = diag(T2_L_pro);

%% Policzenie granic SPE i T2

SPE_limit = policz_SPE_limit(wektor_wartosci_wlasnych, procent_SPE);
T2_limit = policz_T2_limit(X_PCA, procent_T2);

SPE_limit_L_1 = policz_SPE_limit(zredukowany_wektor_wartosci_wlasnych_1, procent_SPE);
T2_limit_L_1 = policz_T2_limit(X_PCAL_1, procent_T2);

SPE_limit_L_pro = policz_SPE_limit(zredukowany_wektor_wartosci_wlasnych_pro, procent_SPE);
T2_limit_L_pro = policz_T2_limit(X_PCAL_pro, procent_T2);
%% wykresiki SPE I T2
figure(2)

subplot(3,2,1)                  % Wykres SPE
plot(1:length(SPE), SPE, 'r*')
hold on
rysuj_granice(SPE_limit, 1:length(SPE));
title('SPE')
grid on

subplot(3,2,2)                  % Wykres SPE dla zredukowanego uk³adu - 1
plot(1:length(SPE_L_1), SPE_L_1,'b*')
hold on
rysuj_granice(SPE_limit_L_1, 1:length(SPE_L_1));
title('SPE dla zredukowanego PCA- 1')
grid on

subplot(3,2,3)                  % Wykres SPE dla zredukowanego uk³adu - pro
plot(1:length(SPE_L_pro), SPE_L_pro,'b*')
hold on
rysuj_granice(SPE_limit_L_pro, 1:length(SPE_L_pro));
title('SPE dla zredukowanego PCA- pro')
grid on

subplot(3,2,4)                  % Wykres T2
plot(1:length(T2), T2, 'b*')
hold on
rysuj_granice(T2_limit, 1:length(T2));
title('T2')
grid on

subplot(3,2,5)                  % Wykres T2 dla zredukowanego uk³adu - 1
plot(1:length(T2_L_1), T2_L_1 ,'b*')
title('T2 dla zredukowanego PCA- 1')
hold on
rysuj_granice(T2_limit_L_1, 1:length(T2_L_1));
grid on

subplot(3,2,6)                  % Wykres T2 dla zredukowanego uk³adu - pro
plot(1:length(T2_L_pro), T2_L_pro ,'b*')
title('T2 dla zredukowanego PCA- pro')
hold on
rysuj_granice(T2_limit_L_pro, 1:length(T2_L_pro));
grid on

%% Rekonstrukcja danych
X_zrekonstruowany = X_PCA * macierz_wektorow_wlasnych';
XL_zrekunstruowany_1 = X_PCAL_1 * zredukowana_macierz_wektorow_wlasnych_1';
XL_zrekunstruowany_pro = X_PCAL_pro * zredukowana_macierz_wektorow_wlasnych_pro';

% wykresik X_zrekonstruowany i XL_zrekunstruowany
figure(3)
plot(X_zrekonstruowany(:,1), X_zrekonstruowany(:,2), 'r*',XL_zrekunstruowany_1(:,1),XL_zrekunstruowany_1(:,2),'b*',...
     XL_zrekunstruowany_1(:,1), XL_zrekunstruowany_1(:,2),'k*')
hold on
plot(X_norm(1),X_norm(2), 'g*')
title('Zrekonstruowane dane')
legend('Zrekonstruowane dane', 'Zrekonstruowane dane dla zredukowanego PCA- 1', 'Zrekonstruowane dane dla zredukowanego PCA- pro',...
       'Znormalizowane dane')
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
    
   a = XT_norm(i,:) * (macierz_wektorow_wlasnych - [zredukowana_macierz_wektorow_wlasnych_1, ...
       zeros(length(macierz_wektorow_wlasnych(:,1)), ...
       length(macierz_wektorow_wlasnych(1,:)) - length(zredukowana_macierz_wektorow_wlasnych_1(1,:)))]);
   SPE_TL(i) = (a * a') ^ 2;
end

% T2
T2_T = XT_norm * macierz_wektorow_wlasnych * inv(diag(wektor_wartosci_wlasnych)) * macierz_wektorow_wlasnych' * XT_norm';
T2_T = diag(T2_T);

% T2 reduced
T2_TL = XT_norm * zredukowana_macierz_wektorow_wlasnych_1 * inv(diag(zredukowany_wektor_wartosci_wlasnych_1)) * zredukowana_macierz_wektorow_wlasnych_1' * XT_norm';
T2_TL = diag(T2_TL);



%% Wykresik dla danych testowych

figure(4)
subplot(2,2,1)
plot(1:length(SPE_T), SPE_T, 'r*', length(SPE_T) + 1 : length(SPE_T) + length(SPE), SPE, 'b*')
rysuj_granice(SPE_limit, 1:(length(SPE_T) + length(SPE)));
title('WskaŸnik SPE- dane testowe, R = 2')
grid on

subplot(2,2,2)
plot(1:length(SPE_TL), SPE_TL, 'r*', length(SPE_TL) + 1 : length(SPE_TL) + length(SPE_L_1) , SPE_L_1, 'b*' )
rysuj_granice(SPE_limit_L_1, 1:(length(SPE_TL) + length(SPE_L_1)));
title('WskaŸnik SPE- dane testowe, R = 1')
grid on

subplot(2,2,3)
plot(1: length(T2_T), T2_T, 'r*', length(T2_T) + 1 : length(T2_T) + length(T2), T2, 'b*')
rysuj_granice(T2_limit, 1:(length(T2_T) + length(T2)));
title('WskaŸnik T2- dane testowe, R = 2')
grid on

subplot(2,2,4)
plot(1: length(T2_TL), T2_TL, 'r*', length(T2_TL) + 1 : length(T2_TL) + length(T2_L_1), T2_L_1, 'b*')
rysuj_granice(T2_limit_L_1, 1:(length(T2_TL) + length(T2_L_1)));
title('WskaŸnik T2- dane testowe, R = 1')
grid on








end