function [ zredukowany_wektor_wartosci_wlasnych, zredukowana_macierz_wektorow_wlasnych ] = ...   
         zredukuj_PCA_o_zadana_wartosc(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych, wartosc_redukcij )
%Funkcja ucina procent(cyfra dziesi�tna np. 0.30 <- 30%) najmniejszych rz�d�w wektora warto�ci wlasnych i
    %odpowiadaj�ce mu wiersze macierzy wektorow wlasnych, z niedomiarem.
    %Zwarca posortowane wektory.


if length(macierz_wektorow_wlasnych(:,1)) ~= length(wektor_wartosci_wlasnych)        % Sprawdzenie d�ugo�ci wektora i macierzy
   error('D�ugo�ci macierzy  wektora s� r�ne!!') 
end

[posortowany_wektor_wartosci_wlasnych, posortowany_macierz_wektorow_wlasnych] =...
    posortuj_wektor_przesuwajac_elementy_w_macierzy(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych); % posortowanie danych

suma_wektorow_wlasnych = sum(wektor_wartosci_wlasnych);

suma = 0;
for i = length(wektor_wartosci_wlasnych) : -1: 1          % znalezienie miejsca w kt�rym wektor osi�ga warto�� wi�ksz� ni� zadana(procentowo)
                                                          % iteracja w d�
    suma = suma + wektor_wartosci_wlasnych(i);  
    
    if suma > suma_wektorow_wlasnych * wartosc_redukcij        % Sprawdzenie w kt�rym miejscu ucia� wektor warto�ci w�asnych
        break                                                   % wyj�cie z p�tli je�eli spe�niony jest warunek
    end
   
end
                                                               
zredukowany_wektor_wartosci_wlasnych = posortowany_wektor_wartosci_wlasnych(1:i);
zredukowana_macierz_wektorow_wlasnych = posortowany_macierz_wektorow_wlasnych(:, 1:i); % przepisanie odpowiednich kolumn
    
end