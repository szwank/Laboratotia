clear
%% WCZYTANIE danych
% load('Macierze_do_danzinga_wolfa.mat')
load('przyklad2.mat')
% przekszta³enie macierzy
% C0 = [0 0];
% C1 = [-1 1 0 0];
% C2 = [-3 -2 0 0];
% A0 = [1 0;
%       0 1];
% A1 = [1 -3 0 0;
%       0 1 0 0];
% A2 = [-2 1 0 0;
%       3 -1 0 0];
% 
% B1 = [3 2 1 0;
%      -1 3 0 1];
% B2 = [3 1 1 0;
%       1 2 0 1];
% b0 = [6;
%       4];
% b1 = [12;
%       6];
% b2 = [12;
%       8];
for i = 1:length(C)
    C{i} = -C{i};
    
end


% A = {A0, A1, A2};
% B = {B1, B2};
% C = {C0, C1, C2};
% b = {b0, b1, b2};
% b = {b0, b{1}, b{2}, b{3}, b{4}, b{5}};


%% INICJALIZACJA ALGORYTMU
options = optimoptions('linprog','Algorithm','interior-point');

if length(A) ~= length(B)           % Sprawdzenie czy w zadaniu istnieje macierz A0
    obecnosc_A0 = true;
else
    obecnosc_A0 = false;
end

ilosc_pod_zagadnien = length(B);


for i =1:ilosc_pod_zagadnien            % Znalezienie pierwszych zagadnieñ dopuszczalnych
    
    [X{i}, f{i}]= linprog(C{obecnosc_A0 + i},[],[], B{i}, b{i+1},...
        zeros(1,length(B{i})), [], [], options);
end

% Utworzenie kolumn naturalnych
if obecnosc_A0 == true          % tylko je¿eli A0 istnieje w zadaniu
    
    for i = 1:length(A{1}(:,1))      % tyle ile jest kolumn w macierzy A0
        
        Kn{i} =  [A{1}(:, i); zeros(ilosc_pod_zagadnien,1)]; % [A0j; 0], A0j- j-ta kolumna A0, 0- wektor zer
        
    end
else
    Kn = {};
end

% Utworzenie kolumn ekstremalnych
for i = 1:ilosc_pod_zagadnien
    
    Ppj = A{obecnosc_A0 + i} * X{i};
    
    wektor_jednostkowy = zeros(ilosc_pod_zagadnien, 1);     % Utworzenie odpowiedniego wektora jednostkowego
    wektor_jednostkowy(i,1) = 1;
    
    Ke{i} = [Ppj; wektor_jednostkowy];
    
end

% Utworzenie wektora sztucznych zmiennych
ilosc_wierszy_A = length(A{1}(:,1));

for i = 1:length(Ppj)         % Tyle wektorów jaka jest d³ugoœæ 1 czêœci wektora Ke
    suma = 0;
    
    for j = 1:ilosc_pod_zagadnien     % Iloœæ utworzonych wczeœniej kolumn odpowiada iloœci pod zagadnieñ
        suma = suma + Ke{j}(i);
    end
    
    wektor_sztucznej_zmiennej = zeros(length(Ppj), 1);  % Inicjazja wektora sztucznej zmiennej
    
    if suma > b0(i)
        wektor_sztucznej_zmiennej(i) = -1;      % jak suma jest wiêksza od b0 to u =-1 i odwrotnie
    else
        wektor_sztucznej_zmiennej(i) = 1;      % jak suma jest wiêksza od b0 to u =-1 i odwrotnie
    end
    
    Ku{i} = [wektor_sztucznej_zmiennej; zeros(ilosc_pod_zagadnien, 1)];      % Przypisanie do komurki utworzonego wektora
end


%% PIERWSZA FAZA
kolejna_iteracja = true;        % Zainicjowanie flagi tak by do while wykonywa³o siê chociarz raz

while kolejna_iteracja == true
    Be = [cell2mat(Kn), cell2mat(Ke), cell2mat(Ku)];
    
    W = [zeros(1, length((Kn))), zeros(1, length((Ke))), 1 * ones(1, length((Ku)))];    % z³o¿enie 3 wektorów
    
    be = [b{1}; ones(ilosc_pod_zagadnien,1)];
    
    [xe1,fe1,~,~,lambda] = linprog(W, [], [], Be, be, zeros(1,length(Be(1,:))), [], [], options);
    
    PI = -1 * lambda.eqlin; % wektor mno¿niów simpleksowych
    %lambde dzielimy tak ¿eby odpowiada³a wierszom przerzutów i wypuk³oœci
    pi1 = PI(1:ilosc_wierszy_A)'
    pi2 = PI(ilosc_wierszy_A + 1:end)'
    
    for i = 1:ilosc_pod_zagadnien
        
        gamma{i} = -pi1 * A{obecnosc_A0 + i}; % dzielimy PI
        
    end
    
    %Obliczenie nowych zadañ
    for i = 1:ilosc_pod_zagadnien
        
        [xe2{i},fe2(i)] = linprog(gamma{i}, [], [], B{i}, b{i+1}, zeros(1,length(B{i}(1,:))), [], [], options);
        
    end
    
    w = fe2 - pi2;
    
    kolejna_iteracja = false;       % wyzerowanie flagi dopowiedzialnej za przerwanie while
    epsilon = 10^-6;
    for i = 1:length(w)     % Sprawdzenie czy kolejna iteracja jest potrzebna
        
        if w(i) <  0 - epsilon
            kolejna_iteracja = true;     % Ustawienie flagi w przypadku gdy potrzeban jest kolejna iteracja
            
            X{end + 1} = xe2{i};            % przypisanie x do X odpowiadaj¹cego za nie przerwanie while
            
            wektor_jednostkowy = zeros(ilosc_pod_zagadnien, 1);     % Utworzenie odpowiedniego wektora jednostkowego
            wektor_jednostkowy(i,1) = 1;
            Ke{end + 1} = [A{obecnosc_A0 + i}  *xe2{i}; wektor_jednostkowy]; %dodanie nowej kolumny ekstremalnej do zagadnienia
            
            f{end + 1} = fe2(i);               %dodanie wartoœci do komurki
            %break bez breaka
        end
        
    end
end

%% DRUGA FAZA
if obecnosc_A0 == true
    Z = [C{1}, cell2mat(f)];
else
    Z = [cell2mat(f)];
end
Be = [cell2mat(Kn), cell2mat(Ke)];

be = [b{1}; ones(ilosc_pod_zagadnien,1)];

[x,f_zad,~,~,lambda] = linprog(Z, [], [], Be, be, zeros(1,length(Be(1,:))), [], [], options);

PI = -1 * lambda.eqlin;

for i = 1:ilosc_pod_zagadnien
    
    gamma{i} = C{obecnosc_A0 + i} - PI(1:ilosc_wierszy_A)' * A{obecnosc_A0 + i}; % dzielimy PI
    
end

%Obliczenie zadañ koñcowych
for i = 1:ilosc_pod_zagadnien
    
    [xe{i},fe(i)] = linprog(gamma{i}, [], [], B{i}, b{i+1}, zeros(1,length(B{i}(1,:))), [], [], options);
    
end

w = fe - PI(ilosc_wierszy_A + 1, end);

% for i = 1:length(w)     % Sprawdzenie czy kolejna iteracja jest potrzebna
%
%     if w(i) >  0 + epsilon
%         printf('Coœ siê zjeba³o')
%         break
%     end
%
% end

for i = 1:ilosc_pod_zagadnien               % wyzerowanei celów
    
    x_rozw{i} = 0;
end

% Wyznaczenie wyniku
for i = 1:length(Ke)        % liczymy x dla g³ównej funkcij celu
    
    k = 1;
    for j = 0:ilosc_pod_zagadnien-1
        
        if Ke{i}(end-j) == 1            % szukamy po³¿enia jedynki w macierzy Ke w dolnej czêœci
            k = j+1;
            break;
        end
    end
    if obecnosc_A0 == 1
        x_rozw{k} = x_rozw{k} + X{i} * x(ilosc_wierszy_A + i);
    else
        x_rozw{k} = x_rozw{k} + X{i} * x(i);
    end
end
x_rozw = flip(x_rozw);

if obecnosc_A0 == 1
    for i = 1:ilosc_wierszy_A
        
        rozwianie_dla_formy_standardowej{i} = x(i);
    end
end
if obecnosc_A0 == 1
    for i = ilosc_wierszy_A+1:ilosc_pod_zagadnien + ilosc_wierszy_A
        rozwianie_dla_formy_standardowej{i} = x_rozw{i - ilosc_wierszy_A};      % przypisanie pozosta³ych elementów
        rozwianie_dla_formy_standardowej{i} = rozwianie_dla_formy_standardowej{i}';
    end
else
    for i = 1:ilosc_pod_zagadnien
        rozwianie_dla_formy_standardowej{i} = x_rozw{i};      % przypisanie pozosta³ych elementów
        rozwianie_dla_formy_standardowej{i} = rozwianie_dla_formy_standardowej{i}';
    end
end

rozwiazanie = cell2mat(C) * cell2mat(rozwianie_dla_formy_standardowej)'

%[cell2mat(X{1:ilosc_kolumn_A0}),(x(3)*X01)', (x(4)*X02)' + (x(5)*[0;4;8;0])']