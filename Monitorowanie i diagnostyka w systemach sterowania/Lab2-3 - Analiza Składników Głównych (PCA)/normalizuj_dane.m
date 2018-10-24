function [ X_norm, X_mean, odchylenie_standardowe ] = normalizuj_dane( X, X_mean, odchylenie_standardowe)
%Funkcja normalizuj_dane normalizuje dane tak by œrednia = 0, odchylenie standardowe = 1
    %Je¿eli do funkcij poda siê tylko jeden argument(dane do normalizacij) funkcja zwraca tak¿e œredni¹ dla
    %ka¿dej kolumny oraz odchylenie standardowe ka¿dego kolumny
    %wprowadzonych danych. 
    %
    %Jezeli do funkcij poda siê 3 argumenty kolejno: dane do normalizacij,
    %œredni¹ dla kazdej kolumny, odchylenie standardowe dla ka¿dej kolumny,
    %funkcja znormalizuje dane wzglêdem podanych parametrów.

%% Zabezpieczenie

if isempty(X) == 1          % Zwruæ pust¹ macierz je¿eli wejœcie jest puste
    X_norm = [];
    return
end

if nargout > 3              % Sprawdzenie czy do funkcij nie podano za du¿ej lidzby parametrów
    error('normalizuj_dane: Podano do funkcij za du¿¹ lidzbê parametrów.')
end


%% W£AŒCIWA FUNKCJA
if nargin == 1              % Przypadek jednego argumentu
    %% obliczenie œredniej
    X_mean = mean(X);

    for i = 1:length(X(1,:))    % Wyliczenie macierzy diagonalnej odchyleñ standardowych
        suma = 0;

        for j = 1:length(X(:,i))
            suma = suma + (X(j,i) - X_mean(i))^2;    % Suma ró¿nicy kwadratu ró¿nicy wartoœci i œredniej    
        end
        odchylenie_standardowe(i,i) = sqrt(suma / (length(X(:,i)) - 1));
    end

    X_norm = (X - ones(length(X(:,1)), 1) * X_mean) * inv(odchylenie_standardowe);
    
    
elseif narfin == 3          % przypadek gdy podam 3 argumenty(wartoœci œredniej i odchylenia s¹ wyliczone)

    X_norm = (X - ones(length(X(:,1)), 1) * X_mean) * inv(odchylenie_standardowe);      % Normalizacja danych
      
end

