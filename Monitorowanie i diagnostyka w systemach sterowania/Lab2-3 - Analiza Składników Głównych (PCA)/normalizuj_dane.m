function [ X_norm, X_mean, odchylenie_standardowe ] = normalizuj_dane( X, X_mean, odchylenie_standardowe)
%Funkcja normalizuj_dane normalizuje dane tak by �rednia = 0, odchylenie standardowe = 1
    %Je�eli do funkcij poda si� tylko jeden argument(dane do normalizacij) funkcja zwraca tak�e �redni� dla
    %ka�dej kolumny oraz odchylenie standardowe ka�dego kolumny
    %wprowadzonych danych. 
    %
    %Jezeli do funkcij poda si� 3 argumenty kolejno: dane do normalizacij,
    %�redni� dla kazdej kolumny, odchylenie standardowe dla ka�dej kolumny,
    %funkcja znormalizuje dane wzgl�dem podanych parametr�w.

%% Zabezpieczenie

if isempty(X) == 1          % Zwru� pust� macierz je�eli wej�cie jest puste
    X_norm = [];
    return
end

if nargout > 3              % Sprawdzenie czy do funkcij nie podano za du�ej lidzby parametr�w
    error('normalizuj_dane: Podano do funkcij za du�� lidzb� parametr�w.')
end


%% W�A�CIWA FUNKCJA
if nargin == 1              % Przypadek jednego argumentu
    %% obliczenie �redniej
    X_mean = mean(X);

    for i = 1:length(X(1,:))    % Wyliczenie macierzy diagonalnej odchyle� standardowych
        suma = 0;

        for j = 1:length(X(:,i))
            suma = suma + (X(j,i) - X_mean(i))^2;    % Suma r�nicy kwadratu r�nicy warto�ci i �redniej    
        end
        odchylenie_standardowe(i,i) = sqrt(suma / (length(X(:,i)) - 1));
    end

    X_norm = (X - ones(length(X(:,1)), 1) * X_mean) * inv(odchylenie_standardowe);
    
    
elseif narfin == 3          % przypadek gdy podam 3 argumenty(warto�ci �redniej i odchylenia s� wyliczone)

    X_norm = (X - ones(length(X(:,1)), 1) * X_mean) * inv(odchylenie_standardowe);      % Normalizacja danych
      
end

