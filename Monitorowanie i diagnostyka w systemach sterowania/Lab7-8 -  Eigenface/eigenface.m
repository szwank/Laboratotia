function [twarze_wlasne, wektor_wag, wektor_wartosci_wlasnych, macierz_wektorow_wlasnych, zdjecie_srednie, twarze_wlasne_red,...
    wektor_wag_red, zredukowany_wektor_wartosci_wlasnych_pro, zredukowana_macierz_wektorow_wlasnych_pro]...
    = eigenface(zdjecia, ilosc_zdjec_po_redukcij, zdjecie_srednie)

if nargin <= 2          
   zdjecie_srednie = []; 
end
%Stworzenie modelu eigenfacee
szerokosc_zdjecia = length(zdjecia{1}(:,1));
dlugosc_zdjecia = length(zdjecia{1}(1,:));
ilosc_zdjec = length(zdjecia);

if isempty(zdjecie_srednie) == true
    for i = 1:szerokosc_zdjecia
        for j = 1:dlugosc_zdjecia
            zdjecie_srednie(i,j) = double(0);
            for k = 1:ilosc_zdjec
                zdjecie_srednie(i,j) = double(zdjecie_srednie(i,j) + double(zdjecia{k}(i,j)));
            end
            zdjecie_srednie(i,j) = round(zdjecie_srednie(i,j)/ilosc_zdjec);
        end
    end
end
% imshow(uint8(zdjecie_srednie));

for i = 1:ilosc_zdjec
        
    znormalizowane_zdjecia{i} = double(zdjecia{i}) - zdjecie_srednie;           
%     imshow(uint8(znormalizowane_zdjecia{i}));
    wektory_znormalizowanych_zdjec{i} = reshape(znormalizowane_zdjecia{i},[],1);
end

L = cell2mat(wektory_znormalizowanych_zdjec)' * cell2mat(wektory_znormalizowanych_zdjec);
% wyzaczenie wektorów i wartoœci w³asnych
[macierz_wektorow_wlasnych, D] = eig(L);
wektor_wartosci_wlasnych = eig(L)';

% sortowanie wektorów
[wektor_wartosci_wlasnych, macierz_wektorow_wlasnych] = posortuj_wektor_przesuwajac_elementy_w_macierzy(wektor_wartosci_wlasnych, macierz_wektorow_wlasnych);  % sortu, sortu, abra kadabra

% utworzenie nie zredukowanego PCA
for i = 1:ilosc_zdjec
    twarze_wlasne{i} = cell2mat(wektory_znormalizowanych_zdjec) * macierz_wektorow_wlasnych(:,i);     %utworzenie danych w PCA
end
% redukcija wektorów
zredukowany_wektor_wartosci_wlasnych_pro = wektor_wartosci_wlasnych(1:ilosc_zdjec_po_redukcij);
zredukowana_macierz_wektorow_wlasnych_pro = macierz_wektorow_wlasnych(:,1:ilosc_zdjec_po_redukcij);

% zredukowany_PCA
for i = 1:ilosc_zdjec_po_redukcij
    twarze_wlasne_red{i} = cell2mat(wektory_znormalizowanych_zdjec) * zredukowana_macierz_wektorow_wlasnych_pro(:,i);
end
%% sprawdzenie teorii

for i = 1:ilosc_zdjec
    for j = 1:ilosc_zdjec_po_redukcij
        wektor_wag_red(i,j) = twarze_wlasne_red{j}' * wektory_znormalizowanych_zdjec{i};
    end
end

for i = 1:ilosc_zdjec
    for j = 1:ilosc_zdjec
        wektor_wag(i,j) = twarze_wlasne{j}' * wektory_znormalizowanych_zdjec{i};
    end
end

end

