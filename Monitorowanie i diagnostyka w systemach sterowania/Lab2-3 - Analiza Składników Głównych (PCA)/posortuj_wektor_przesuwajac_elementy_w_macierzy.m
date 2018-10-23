function [ posortowany_wektor_wartosci_wlasnych, posortowana_macierz_wekorow_wlasnych ] = posortuj_wektor_przesuwajac_elementy_w_macierzy( wektor_wartosci_wlasnych, macierz_wekorow_wlasnych )
%Funkcja sortuje elementy wektora warto�ci w�asnych i przestawja
%jednocze�nie odpowiadaj�ce mu elementy macierzy wektor�w w�asnych
%   Detailed explanation goes here
if length(macierz_wekorow_wlasnych(1,:)) ~= length(wektor_wartosci_wlasnych)
   error('D�ugo�ci macierzy  wektora s� r�ne!!') 
end

wektor_wartosci_wlasnych_kopja = wektor_wartosci_wlasnych;  % przekopjowanie wektora, dzia�anie na kopij
posortowana_macierz_wekorow_wlasnych = macierz_wekorow_wlasnych;          

posortowany_wektor_wartosci_wlasnych = [];                  % zainicjowanie

for j = 1:length(wektor_wartosci_wlasnych_kopja)
        max = wektor_wartosci_wlasnych_kopja(1);           % przypisanie pierwszego elementu jako najwi�kszego
        miejsce = 1;                                % przypisanie 1 miejsca do usuni�cia
    for i = 1:length(wektor_wartosci_wlasnych_kopja)      % p�tla znajduje najwiekszy pozosta�y element
                
        if max < wektor_wartosci_wlasnych_kopja(i)        % sprawdzenie czy nast�pny element jest wi�kszy
            max = wektor_wartosci_wlasnych_kopja(i);      % aktualizacja zmiennych
            miejsce = i;
        end
    end
    
    posortowany_wektor_wartosci_wlasnych(j) = max;  % wpisanie znalezionej warto�ci do wektora
    wektor_wartosci_wlasnych_kopja(miejsce) = [];               % usuni�cie warto�ci z wektora
    posortowana_macierz_wekorow_wlasnych = zamien_kolumny_wierszami(posortowana_macierz_wekorow_wlasnych, miejsce, j);
end

end

