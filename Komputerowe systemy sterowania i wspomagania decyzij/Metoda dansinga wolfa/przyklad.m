clear
options = optimoptions('linprog','Algorithm','simplex');
C0 = [0 0];
C1 = [-1 1 0 0];
C2 = [-3 -2 0 0];
A0 = [1 0;
      0 1];
A1 = [1 -3 0 0;
      0 1 0 0];
A2 = [-2 1 0 0;
      3 -1 0 0];

B1 = [3 2 1 0;
     -1 3 0 1];
B2 = [3 1 1 0;
      1 2 0 1];
b0 = [6;
      4];
b1 = [12;
      6];
b2 = [12;
      8];

%% INICJALIZACJA
%% znalezienie pierwsze zagadnienia dopuszczalne

X01 = linprog(C1,[],[],B1,b1,zeros(1,length(B1)),[],[],options);
X02 = linprog(C2,[],[],B2,b2,zeros(1,length(B2)),[],[],options);


% pierwsze kolumny naturalne (A0):
Kn1 = [A0(:,1); zeros(2,1)];        
Kn2 = [A0(:,2); zeros(2,1)];


% Kolumny ekstremalne (tyle ile pod zagadnieñ ). 


Ke1 = [A1*X01;1;0];
Ke2 = [A2*X02;0;1];


Ke = [Ke1, Ke2];

% wyznaczenie cen i kosztów

f1 = C1 * X01;
f2 = C2 * X02;


% utworzenie sztucznych zmiennych:
suma = 0;
for i = 1:2         %wysokoœæ wektora Ai*xi = 2  
    suma = 0;
    
    for j = 1:2     %bo s¹ 4 kolumny naturalne w zagadnieniu
        suma = suma + Ke(i,j);
    end
    if suma > b0(i)
        u(i) = -1;      % jak ujemny to u =-1 i odwrotnie
    else
        u(i) = 1;
    end
end
 
Ku = [diag(u);                         
      zeros(2,2)];

%% PIERWSZA ITERACJA, FAZA I
W = [zeros(1,4), 1*ones(1,2)];      % Funkcja celu. Tyle jedynek ile sztucznych zmiennych. jedynki bo minimalizujemy zagadnienie
Be = [Kn1, Kn2, Ke, Ku];

b = [b0;ones(2,1)];      % prawa strona ograniczeñ. jedynki bo lambdy musza wynosiæ 1


[x,f,~,~,lambda] = linprog(W,[],[],Be,b,zeros(1,6),[],[],options);

PI = -1 * lambda.eqlin; % wektor mno¿niów simpleksowych
%lambde dzielimy tak ¿eby odpowiada³a wierszom przerzutów i wypuk³oœci

gamma1 = -PI(1:2)' * A1; % dzielimy PI
gamma2 = -PI(1:2)' * A2;

% liczymy, tworzymy tyle zadañ ile jes podproblemów


[X11,f11] = linprog(gamma1, [], [], B1, b1,zeros(4,1),[],[],options);
[X21,f21] = linprog(gamma2, [], [], B2, b2,zeros(4,1),[],[],options);

% bierzemy wartoœci funkcij i odejmujemy od tego pi2

w = [f11;f21]-PI(3:4);

% tworzymy now¹ kolumne ekstremaln¹
Ke3 = [A2 * X21; 0 ;1]; % bierzemy macierz ograniczeñ odpowiedniego zagadnienie(
%chodzi o jego numer)dla drugiego bierzemy gruga
% dopisujemy wektor jednoœci tak by pasowa³ do numeru x którego bierzemy
% dla 2 jedynka na 2 miejscu

% liczymy wektor ofertowy dla danego x
f31 = C2 * X21;% Którykolwik z wierszy w jest ujemyny wiêc jedziemy z kolejn¹ iteracj¹
%% DRUGA ITERACJA, FAZA I

% tworzymy znowu macierz bazow¹
% dodajemy kolumne ekstremaln¹ do starych kolumn ekstremanych

Ke = [Ke,Ke3];
Be = [Kn1, Kn2, Ke, Ku];

W = [zeros(1,5), 1*ones(1,2)]; % dodajemy jedno zero bo dodaliœmy kolumnê

b = [b0;ones(2,1)];  % b zostawiamy
% dodaæ zero do linproga do warunków ograniczaj¹cych zmienne
[x,f,~,~,lambda] = linprog(W,[],[],Be,b,zeros(1,7),[],[],options);

PI = -1 * lambda.eqlin; % wektor mno¿niów simpleksowych
%lambde dzielimy tak ¿eby odpowiada³a wierszom przerzutów i wypuk³oœci

gamma1 = -PI(1:2)' * A1; % dzielimy PI
gamma2 = -PI(1:2)' * A2;

[X11,f11] = linprog(gamma1, [], [], B1, b1,zeros(4,1),[],[],options);
[X21,f21] = linprog(gamma2, [], [], B2, b2,zeros(4,1),[],[],options);


w = [f11;f21]-PI(3:4);

% w jest nie ujemne(uwaga dla zadania maksymalizacij nie dodatnie) wiêc
% jedziemy z kolejn¹ iteracj¹. Dodatkowo ostatnie wiersze x s¹ zerowe wiêc
% jest gicior i jedziemy z druga faz¹

%% DRUGA FAZA, TRZECIA ITERACJA

% funkcja celu sk³ada siê z c0 i policzonych wczeœniej funkcij celu
Z = [C0, f1, f2, f31];

% tworzymy macierz Be bez sztucznych zmiennych
Be = [Kn1, Kn2, Ke];
% ograniczenia prawostronne pozostaj¹ takie same
b = [b0;ones(2,1)];
% zmieniæ wielkoœæ zeros
[x,f,~,~,lambda] = linprog(Z,[],[],Be,b,zeros(1,5),[],[],options);

PI = -1 * lambda.eqlin; % wektor mno¿niów simpleksowych
%lambde dzielimy tak ¿eby odpowiada³a wierszom przerzutów i wypuk³oœci

% dodaæ Cp do tego wzorka w II fazie
gamma1 = C1-PI(1:2)' * A1; % dzielimy PI
gamma2 = C2-PI(1:2)' * A2;

[X11,f11] = linprog(gamma1, [], [], B1, b1,zeros(4,1),[],[],options);
[X21,f21] = linprog(gamma2, [], [], B2, b2,zeros(4,1),[],[],options);

w = [f11;f21]-PI(3:4);

% sprawdzamy czy w jest wiêksze albo mniejsze od zera w zale¿noœci od
% przypadku

% ogarn¹c jak zaimplementowac tu cell

% rozwi¹zanie wyznaczamy poprzez sprawdzenie ile lambdy wchodzi do
% rozwi¹zania i wymno¿enie jej. potem liczymy rozwi¹zania poszczegulnych
% podproblemów. trzeba cofn¹c siê do poprzedniej bazy. patrz ni¿ej:

%z ostatniego XE3 bierzemy dane odpowiadaj¹ce wskaŸnikom lagranga
% wczesniejsze x odpowiadaj¹ macierzy A0
%czyli:

rozwianie_dla_formy_standardowej = [x(1:2)',(x(3)*X01)', (x(4)*X02)' + (x(5)*[0;4;8;0])']

zysk = [C0,C1,C2]*rozwianie_dla_formy_standardowej'
