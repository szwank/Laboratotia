clear
load('Macierze_do_danzinga_wolfa.mat')
%% INICJALIZACJA
%% znalezienie pierwsze zagadnienia dopuszczalne

X01 = linprog(C1,B1,b1,[],[],zeros(1,length(B1)));
X02 = linprog(C2,B2,b2,[],[],zeros(1,length(B2)));
X03 = linprog(C3,B3,b3,[],[],zeros(1,length(B3)));
X04 = linprog(C4,B4,b4,[],[],zeros(1,length(B4)));

% pierwsze kolumny naturalne (A0):
Kn1 = [A0(:,1); zeros(4,1)];        % <--jakiej d³ugoœci maj¹ by te wektory?
Kn2 = [A0(:,2); zeros(4,1)];
Kn3 = [A0(:,3); zeros(4,1)];
Kn4 = [A0(:,4); zeros(4,1)];
Kn5 = [A0(:,5); zeros(4,1)];
Kn6 = [A0(:,6); zeros(4,1)];

% Kolumny ekstremalne (tyle ile pod zagadnieñ ). Dowiedzieæ siê jak ma
% wygl¹daæ tutaj wektor jednostkowy!!!! jak roz³o¿yæ te jedynki

Ke1 = [A1*X01;1;0;0;0];
Ke2 = [A2*X02;0;1;0;0];
Ke3 = [A3*X03;0;0;1;0];
Ke4 = [A4*X04;0;0;0;1];

Ke = [Ke1, Ke2, Ke3, Ke4];

% wyznaczenie cen i kosztów

f1 = C1 * X01;
f2 = C2 * X02;
f3 = C3 * X03;
f4 = C4 * X04;

% utworzenie sztucznych zmiennych:
suma = 0;
for i = 1:4         %wysokoœæ wektora Ai*xi = 6  Coœ siê tu nie zgadza!!!!!!!!!
    suma = 0;
    
    for j = 1:4     %bo s¹ 4 kolumny naturalne w zagadnieniu
        suma = suma + Ke(i,j);
    end
    if suma > b0(i)
        u(i) = -1;      % jak ujemny to u =-1 i odwrotnie
    else
        u(i) = 1;
    end
end
 
Ku = [diag(u);                          %% <--ogran¹æ wymiary tej macierzy!!!!!
      zeros(6,4)];

%% PIERWSZA ITERACJA, FAZA I
W = [zeros(1,6+4), 1*ones(1,4)];      % Funkcja celu. Tyle jedynek ile sztucznych zmiennych
Be = [Kn1, Kn2, Kn3, Kn4, Kn5, Kn6, Ke, Ku];

b = [b0;zeros(4,1)];      % prawa strona ograniczeñ

options = optimoptions('linprog','Algorithm','simplex');
x = linprog(W,[],[],Be,b,ones(1,12),[],[],options)



% wyznaczamy Wektor mno¿ników simpleksowych
% pi1 = [C0, f1,f2,f3,f4]' * inv(Be)
