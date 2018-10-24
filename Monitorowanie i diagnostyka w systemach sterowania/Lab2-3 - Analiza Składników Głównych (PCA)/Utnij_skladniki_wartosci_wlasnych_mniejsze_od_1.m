function [ zredukowany_wektor_wartosci_wlasnych, zredukowana_macierz_wektorow_wlasnych ] = Utnij_skladniki_wartosci_wlasnych_mniejsze_od_1( wektor_wartosci_wlasnych, macierz_wektorow_wlasnych )
%Funkcja ucina rzêdy wektora wartoœci wlasnych mniejsze od 1 i
%odpowiadaj¹ce mu wiersze macierzy wektorow wlasnych

if length(macierz_wektorow_wlasnych(:,1)) ~= length(wektor_wartosci_wlasnych)        % Sprawdzenie d³ugoœci wektora i macierzy
   error('D³ugoœci macierzy  wektora s¹ ró¿ne!!') 
end
zredukowany_wektor_wartosci_wlasnych = [];
zredukowana_macierz_wektorow_wlasnych = [];

for i = 1:length(wektor_wartosci_wlasnych)
    
    if wektor_wartosci_wlasnych(i) >= 1      % Sprawdzenie w którym miejscu wartoœ w³asna jest mniejsz od 1
        
        zredukowany_wektor_wartosci_wlasnych(i) = wektor_wartosci_wlasnych(i);           % Uciecie odpowiednich miejsc
        zredukowana_macierz_wektorow_wlasnych(:,i) = macierz_wektorow_wlasnych(:,i);
    end    
end

