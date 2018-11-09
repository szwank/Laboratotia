clear
%% WCZYTANIE danych
% load('Macierze_do_danzinga_wolfa.mat')
load('Copy_of_Macierze_do_danzinga_wolfa.mat')
% przekszta³enie macierzy
A = {A0, A1, A2, A3, A4};
B = {B1, B2, B3, B4};
C = {C0, C1, C2, C3, C4};
b = {b0, b1, b2, b3, b4};


%% INICJALIZACJA ALGORYTMU
options = optimoptions('linprog','Algorithm','dual-simplex');

if length(A) ~= length(B)           % Sprawdzenie czy w zadaniu istnieje macierz A0
    obecnosc_A0 = true;          
else
    obecnosc_A0 = false;
end

ilosc_pod_zagadnien = length(B);


for i =1:ilosc_pod_zagadnien            % Znalezienie pierwszych zagadnieñ dopuszczalnych
    
    [X{i} f{i}]= linprog(C{obecnosc_A0 + i},[],[], B{i}, b{obecnosc_A0 + i},...
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
ilosc_kolumn_A0 = length(A{1}(1,:));

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
    pi1 = PI(1:ilosc_kolumn_A0)'
    pi2 = PI(ilosc_kolumn_A0 + 1:end)'
   
    for i = 1:ilosc_pod_zagadnien

        gamma{i} = -pi1 * A{obecnosc_A0 + i}; % dzielimy PI

    end

    %Obliczenie nowych zadañ
    for i = 1:ilosc_pod_zagadnien

        [xe2{i},fe2(i)] = linprog(gamma{i}, [], [], B{i}, b{i+1}, zeros(1,length(B{i}(1,:))), [], [], options);

    end

    w = fe2 - pi2;

    kolejna_iteracja = false;       % wyzerowanie flagi dopowiedzialnej za przerwanie while
    epsilon = 10^-14;
    for i = 1:length(w)     % Sprawdzenie czy kolejna iteracja jest potrzebna

       if w(i) <  0 - epsilon
           kolejna_iteracja = true;     % Ustawienie flagi w przypadku gdy potrzeban jest kolejna iteracja
           
           X{end + 1} = xe2{i};            % przypisanie x do X odpowiadaj¹cego za nie przerwanie while
           
           wektor_jednostkowy = zeros(ilosc_pod_zagadnien, 1);     % Utworzenie odpowiedniego wektora jednostkowego
           wektor_jednostkowy(i,1) = 1;
           Ke{end + 1} = [A{obecnosc_A0 + i}  *xe2{i}; wektor_jednostkowy]; %dodanie nowej kolumny ekstremalnej do zagadnienia
           
           f{end + 1} = fe2(i);               %dodanie wartoœci do komurki
           %break
       end

    end
end

%% DRUGA FAZA

Z = [C{1}, cell2mat(f)];

Be = [cell2mat(Kn), cell2mat(Ke)];

be = [b{1}; ones(ilosc_pod_zagadnien,1)];

[x,fe,~,~,lambda] = linprog(W, [], [], Be, be, zeros(1,length(Be(1,:))), [], [], options);

PI = -1 * lambda.eqlin;

 for i = 1:ilosc_pod_zagadnien

        gamma(i) = C{obecnosc_A0 + i} - PI(1:ilosc_kolumn_A0)' * A{obecnosc_A0 + i}; % dzielimy PI

 end
 
%Obliczenie zadañ koñcowych
for i = 1:ilosc_pod_zagadnien

    [xe(i),fe(i)] = linprog(gamma(i), [], [], B{i}, b{i+1}, zeros(1,length(B{i}(1,:))), [], [], options);

end

 w = fe - PI(ilosc_kolumn_A0 + 1, end);
 
for i = 1:length(w)     % Sprawdzenie czy kolejna iteracja jest potrzebna

    if w(i) >  0 + epsilon
        printf('Coœ siê zjeba³o')
        break
    end

end

% Wyznaczenie wyniku

rozwianie_dla_formy_standardowej = [x(1:2)',(x(3)*X01)', (x(4)*X02)' + (x(5)*[0;4;8;0])']