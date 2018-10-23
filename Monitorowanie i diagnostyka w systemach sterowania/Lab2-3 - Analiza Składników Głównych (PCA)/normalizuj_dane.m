function [ X_norm ] = normalizuj_dane( X )
%Funkcja normalizuje dane(œrednia = 0, odchylenie standardowe = 1)
X_mean = mean(X);

for i = 1:length(X(1,:)) % wyliczenie macierzy diagonalnej odchyleñ standardowych
    suma = 0;
    
    for j = 1:length(X(:,i))
        suma = suma + (X(j,i) - X_mean(i))^2;        
    end
    E(i,i) = sqrt(suma / (length(X(:,i)) - 1));
end

X_norm = (X - ones(length(X(:,1)), 1) * X_mean) * inv(E);


end

