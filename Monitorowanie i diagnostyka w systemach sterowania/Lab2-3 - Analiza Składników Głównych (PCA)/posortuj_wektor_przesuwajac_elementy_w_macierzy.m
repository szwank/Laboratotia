function [ posortowany_wektor_wartosci_wlasnych, posortowana_macierz_wekorow_wlasnych ] = posortuj_wektor_przesuwajac_elementy_w_macierzy( wektor_wartosci_wlasnych, macierz_wekorow_wlasnych )
%Funkcja sortuje elementy wektora wartoœci w³asnych i przestawja
%jednoczeœnie odpowiadaj¹ce mu elementy macierzy wektorów w³asnych
%   Detailed explanation goes here
if length(macierz_wekorow_wlasnych(1,:)) ~= length(wektor_wartosci_wlasnych)
   error('D³ugoœci macierzy  wektora s¹ ró¿ne!!') 
end

wektor_wartosci_wlasnych_kopja = wektor_wartosci_wlasnych;  % przekopjowanie wektora, dzia³anie na kopij
posortowana_macierz_wekorow_wlasnych = macierz_wekorow_wlasnych;          

posortowany_wektor_wartosci_wlasnych = [];                  % zainicjowanie

for j = 1:length(wektor_wartosci_wlasnych_kopja)
        max = wektor_wartosci_wlasnych_kopja(1);           % przypisanie pierwszego elementu jako najwiêkszego
        miejsce = 1;                                % przypisanie 1 miejsca do usuniêcia
    for i = 1:length(wektor_wartosci_wlasnych_kopja)      % pêtla znajduje najwiekszy pozosta³y element
                
        if max < wektor_wartosci_wlasnych_kopja(i)        % sprawdzenie czy nastêpny element jest wiêkszy
            max = wektor_wartosci_wlasnych_kopja(i);      % aktualizacja zmiennych
            miejsce = i;
        end
    end
    
    posortowany_wektor_wartosci_wlasnych(j) = max;  % wpisanie znalezionej wartoœci do wektora
    wektor_wartosci_wlasnych_kopja(miejsce) = [];               % usuniêcie wartoœci z wektora
    posortowana_macierz_wekorow_wlasnych = zamien_kolumny_wierszami(posortowana_macierz_wekorow_wlasnych, miejsce, j);
end

end

