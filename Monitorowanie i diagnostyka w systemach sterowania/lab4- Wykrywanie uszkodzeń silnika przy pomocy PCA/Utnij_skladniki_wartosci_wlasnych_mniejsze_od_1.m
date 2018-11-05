function [ zredukowany_wektor_wartosci_wlasnych, zredukowana_macierz_wektorow_wlasnych ] = Utnij_skladniki_wartosci_wlasnych_mniejsze_od_1( wektor_wartosci_wlasnych, macierz_wektorow_wlasnych )
%Funkcja ucina rz�dy wektora warto�ci wlasnych mniejsze od 1 i
%odpowiadaj�ce mu wiersze macierzy wektorow wlasnych

if length(macierz_wektorow_wlasnych(:,1)) ~= length(wektor_wartosci_wlasnych)        % Sprawdzenie d�ugo�ci wektora i macierzy
   error('D�ugo�ci macierzy  wektora s� r�ne!!') 
end
zredukowany_wektor_wartosci_wlasnych = [];
zredukowana_macierz_wektorow_wlasnych = [];

for i = 1:length(wektor_wartosci_wlasnych)
    
    if wektor_wartosci_wlasnych(i) >= 1      % Sprawdzenie w kt�rym miejscu warto� w�asna jest mniejsz od 1
        
        zredukowany_wektor_wartosci_wlasnych(i) = wektor_wartosci_wlasnych(i);           % Uciecie odpowiednich miejsc
        zredukowana_macierz_wektorow_wlasnych(:,i) = macierz_wektorow_wlasnych(:,i);
    end    
end

