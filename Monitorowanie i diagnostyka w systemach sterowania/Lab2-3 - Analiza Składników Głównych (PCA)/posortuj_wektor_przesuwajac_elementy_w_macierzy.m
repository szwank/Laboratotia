function [ posortowany_wektor_wartosci_wlasnych, posortowana_macierz_wekorow_wlasnych ] = posortuj_wektor_przesuwajac_elementy_w_macierzy( wektor_wartosci_wlasnych, macierz_wekorow_wlasnych )
%Funkcja sortuje elementy wektora wartoœci w³asnych i przestawja
%jednoczeœnie odpowiadaj¹ce mu elementy macierzy wektorów w³asnych
%   Detailed explanation goes here
if length(macierz_wekorow_wlasnych(1,:)) ~= length(wektor_wartosci_wlasnych)
   error('Posortuj wektor przesuwajac elementy w macierzy:',...
         'D³ugoœci macierzy  wektora s¹ ró¿ne!!') 
end

wektor_wartosci_wlasnych_kopja = wektor_wartosci_wlasnych;  % przekopjowanie wektora, dzia³anie na kopij
posortowana_macierz_wekorow_wlasnych = macierz_wekorow_wlasnych;          

posortowany_wektor_wartosci_wlasnych = wektor_wartosci_wlasnych;                  % zainicjowanie

for j = 1:length(wektor_wartosci_wlasnych_kopja)-1
        max = posortowany_wektor_wartosci_wlasnych(j);           % przypisanie pierwszego elementu jako najwiêkszego
        miejsce = j;                                % przypisanie 1 miejsca do usuniêcia
    for i = j:length(posortowany_wektor_wartosci_wlasnych)      % pêtla znajduje najwiekszy pozosta³y element
                
        if max < posortowany_wektor_wartosci_wlasnych(i)        % sprawdzenie czy nastêpny element jest wiêkszy
            max = posortowany_wektor_wartosci_wlasnych(i);      % aktualizacja zmiennych
            miejsce = i;
        end
    end
    
    posortowany_wektor_wartosci_wlasnych = zamien_kolumny_miejscami(posortowany_wektor_wartosci_wlasnych, miejsce, j);  % wpisanie znalezionej wartoœci do wektora
    posortowana_macierz_wekorow_wlasnych = zamien_kolumny_miejscami(posortowana_macierz_wekorow_wlasnych, miejsce, j);
end

end

