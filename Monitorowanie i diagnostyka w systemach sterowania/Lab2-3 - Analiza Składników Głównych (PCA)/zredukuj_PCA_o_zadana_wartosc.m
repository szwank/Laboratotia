function [ zredukowany_wektor_wartosci_wlasnych, zredukowana_macierz_wektorow_wlasnych ] = ...   
         zredukuj_PCA_o_zadana_wartosc(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych, wartosc_redukcij )
%Funkcja ucina procent(cyfra dziesiêtna np. 0.30 <- 30%) najmniejszych rzêdów wektora wartoœci wlasnych i
    %odpowiadaj¹ce mu wiersze macierzy wektorow wlasnych, z niedomiarem.
    %Zwarca posortowane wektory.


if length(macierz_wektorow_wlasnych(:,1)) ~= length(wektor_wartosci_wlasnych)        % Sprawdzenie d³ugoœci wektora i macierzy
   error('D³ugoœci macierzy  wektora s¹ ró¿ne!!') 
end

[posortowany_wektor_wartosci_wlasnych, posortowany_macierz_wektorow_wlasnych] =...
    posortuj_wektor_przesuwajac_elementy_w_macierzy(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych); % posortowanie danych

suma_wektorow_wlasnych = sum(wektor_wartosci_wlasnych);

suma = 0;
for i = length(wektor_wartosci_wlasnych) : -1: 1          % znalezienie miejsca w którym wektor osi¹ga wartoœæ wiêksz¹ ni¿ zadana(procentowo)
                                                          % iteracja w dó³
    suma = suma + wektor_wartosci_wlasnych(i);  
    
    if suma > suma_wektorow_wlasnych * wartosc_redukcij        % Sprawdzenie w którym miejscu uciaæ wektor wartoœci w³asnych
        break                                                   % wyjœcie z pêtli je¿eli spe³niony jest warunek
    end
   
end
                                                               
zredukowany_wektor_wartosci_wlasnych = posortowany_wektor_wartosci_wlasnych(1:i);
zredukowana_macierz_wektorow_wlasnych = posortowany_macierz_wektorow_wlasnych(:, 1:i); % przepisanie odpowiednich kolumn
    
end