clc, clear, close all
addpath('baza danych')
%% INICJALIZACJA
rng(12345)
% randperm - nie powtarzarzajacy siê rand
% parametry sta³e:
lidzba_osob = 7;
zdjecia_na_osobe = 150;
szerokosc_zdjecia = 120;
dlugosc_zdjecia = 100;
ilosc_zdjec = lidzba_osob * zdjecia_na_osobe;
% parametry zmienne:
ilosc_twarzy_wlasnych = 10;
ilosc_twarzy_treningowych_na_osobe = 20;
ilosc_twarzy_walidacyjnych_na_osobe = 10;
ilosc_twarzy_testowych_na_osobe = zdjecia_na_osobe - ilosc_twarzy_treningowych_na_osobe - ilosc_twarzy_walidacyjnych_na_osobe;
imiona = {'£ukasz', 'Mateusz', 'Krzysiek', 'Bartek', 'Daniel', 'Paulina', 'Alicja'};
%% WCZYTANIE I PODZIA£ ZDJÊÆ
for i = 1:lidzba_osob
    kolejnosc_zdjec_na_osobe = randperm(150,150);
    for j = 1:zdjecia_na_osobe
        numer_zdjecia = (i-1)*zdjecia_na_osobe + kolejnosc_zdjec_na_osobe(j);  % wybranie zdjêcia
        
        if idivide(int32(numer_zdjecia),int32(10)) < 1
            lidzba = strcat('000',num2str(numer_zdjecia));
        elseif idivide(int32(numer_zdjecia),int32(100)) < 1
            lidzba = strcat('00',num2str(numer_zdjecia));
        elseif idivide(int32(numer_zdjecia),int32(1000)) < 1
            lidzba = strcat('0',num2str(numer_zdjecia));
        elseif idivide(int32(numer_zdjecia),int32(10000)) < 1
            lidzba = num2str(numer_zdjecia);    
        end
        
        [X,map] = imread(strcat('im_',lidzba,'.png'));
        I = double(rgb2gray(X));
%          imshow(uint8(I));
        if j <= ilosc_twarzy_treningowych_na_osobe
            index = (i-1) * ilosc_twarzy_treningowych_na_osobe + j;
            zdjecia_treningowe{index} = I;
        elseif j<= ilosc_twarzy_treningowych_na_osobe + ilosc_twarzy_walidacyjnych_na_osobe
            index = j - ilosc_twarzy_treningowych_na_osobe;
            zdjecia_walidacyjne{i,index} = I;
        else
            index = j - ilosc_twarzy_treningowych_na_osobe - ilosc_twarzy_walidacyjnych_na_osobe;
            zdjecia_testowe{i,index} = I;
        end
    end
end
%% TWORZENIE PCA
% for i = 1:lidzba_osob
%     [X_PCA{i}, wektor_wartosci_wlasnych{i}, macierz_wektorow_wlasnych{i},...
%         zdjecie_srednie{i}, X_PCA_red{i},zredukowany_wektor_wartosci_wlasnych_pro{i},...
%         zredukowana_macierz_wektorow_wlasnych_pro{i}] = eigenface(zdjecia_treningowe(i,:),ilosc_twarzy_wlasnych);
% end
[twarze_wlasne, wektor_wag, wektor_wartosci_wlasnych, macierz_wektorow_wlasnych, zdjecie_srednie, twarze_wlasne_red,...
    wektor_wag_red, zredukowany_wektor_wartosci_wlasnych_pro, zredukowana_macierz_wektorow_wlasnych_pro]...
    = eigenface(zdjecia_treningowe,ilosc_twarzy_wlasnych);
% wyœwietlenie zdjêæ eigen faces
% for i = 1:ilosc_twarzy_wlasnych
% for i = 1:3
%     figure
%     imshow(uint8(rescale(reshape(X_PCA_red(:,i),szerokosc_zdjecia ,dlugosc_zdjecia),0,255)))
% end

%% KONWERSJA SPOWROTEM DO ORGINALNEGO ZDJÊCIA

%     for i = 1:length(zdjecia_treningowe)
%         zdjecia_odtworzone{i} = 0;
%         for j = 1:length(zdjecia_treningowe)
%             zdjecia_odtworzone{i} = zdjecia_odtworzone{i} + twarze_wlasne{j} * wektor_wag(i,j);
%         end
%         zdjecia_odtworzone{i} = zdjecia_odtworzone{i} + reshape(zdjecie_srednie,[],1);
%     end

for i = 1:length(zdjecia_treningowe)
        zdjecia_odtworzone{i} = 0;
        for j = 1:ilosc_twarzy_wlasnych
            zdjecia_odtworzone{i} = zdjecia_odtworzone{i} + twarze_wlasne_red{j} * zredukowana_macierz_wektorow_wlasnych_pro(i,j);
        end
        zdjecia_odtworzone{i} = zdjecia_odtworzone{i} + reshape(zdjecie_srednie,[],1);
end

imshow(uint8(reshape(zdjecia_odtworzone{1}, szerokosc_zdjecia, dlugosc_zdjecia)))

%% STWORZENIE PCA DLA DANYCH TESTOWYCH I WALIDACYJNYCH
for i = 1:lidzba_osob
    for j = 1:ilosc_twarzy_walidacyjnych_na_osobe
        [wektor_wag_wal{i,j}]...
             = eigenface_testowe(zdjecia_walidacyjne(i,j), zdjecie_srednie, twarze_wlasne_red);
    end
end

% for k = 1:lidzba_osob
%      for i = 1:length(zdjecia_walidacyjne)
%             zdjecia_odtworzone_wal{k,i} = 0;
%             for j = 1:ilosc_twarzy_wlasnych
% %                 zdjecia_odtworzone_wal{k,i} = zdjecia_odtworzone_wal{k,i} + X_PCA_red(:,j) * macierz_wektorow_wlasnych_walidacyjnych{k,i}(j);
%                   zdjecia_odtworzone_wal{k,i} = zdjecia_odtworzone_wal{k,i} + twarze_wlasne_red(:,j) * wektor_wag_wal{k,i}(j);
%             end
%             zdjecia_odtworzone_wal{k,i} = zdjecia_odtworzone_wal{k,i} + reshape(zdjecie_srednie,[],1);
%       end
% end


%  imshow(uint8(reshape(rescale(zdjecia_odtworzone_wal{1,1},0,255), szerokosc_zdjecia, dlugosc_zdjecia)))

for i = 1:lidzba_osob
    for j = 1:ilosc_twarzy_testowych_na_osobe
        [wektor_wag_test{i,j}]...
             = eigenface_testowe(zdjecia_testowe(i,j), zdjecie_srednie, twarze_wlasne_red);
    end
end

%% KLASYFIKATOR EUKLIDESOWY
for i = 1:lidzba_osob
   for j = 1:length(zdjecia_walidacyjne)
       
       for k = 1:length(wektor_wag_red(:,1))
            wartosc(k) = pdist2(wektor_wag_red(k,:), wektor_wag_wal{i,j});
       end
       [dystans_wal(i,j), ktore_zdjecie_wal(i,j)] = min(wartosc);
       index = ceil(ktore_zdjecie_wal(i,j) / ilosc_twarzy_treningowych_na_osobe);
       czyje_zdjecie_wal{i,j} = imiona{index}; % celi- zaokr¹glenie do góry
   end
   
end

skutecznosc_wal = 0;
for i = 1:lidzba_osob
    for j = 1:length(zdjecia_walidacyjne)
        if strcmp(czyje_zdjecie_wal{i,j}, imiona{i})
            
            skutecznosc_wal = skutecznosc_wal + 1;
            
        end
    end
end
skutecznosc_wal = 100*skutecznosc_wal / (lidzba_osob * ilosc_twarzy_walidacyjnych_na_osobe)


for i = 1:lidzba_osob
   for j = 1:length(zdjecia_testowe)
       
       for k = 1:length(wektor_wag_red(:,1))
            wartosc(k) = pdist2(wektor_wag_red(k,:), wektor_wag_test{i,j});
       end
       [dystans_test(i,j), ktore_zdjecie_test(i,j)] = min(wartosc);
       index = ceil(ktore_zdjecie_test(i,j) / ilosc_twarzy_treningowych_na_osobe);
       czyje_zdjecie_test{i,j} = imiona{index}; % celi- zaokr¹glenie do góry
   end
   
end

skutecznosc_test = 0;
for i = 1:lidzba_osob
    for j = 1:length(zdjecia_testowe)
        if strcmp(czyje_zdjecie_test{i,j}, imiona{i})
            
            skutecznosc_test = skutecznosc_test + 1;
            
        end
    end
end
skutecznosc_test = 100*skutecznosc_test / (lidzba_osob * ilosc_twarzy_testowych_na_osobe)


%% PRZYGOTOWANIE DANYCH DLA SIECI NEURONOWEJ
% % zdjecia_treningowe = zdjecia_treningowe';
% for i = 1:length(zdjecia_treningowe)
%     zdjecia_treningowe{i} = reshape(zdjecia_treningowe{i}, [], 1);
% end
% 
% zdjecia_walidacyjne = reshape(zdjecia_walidacyjne', 1, []);
% for i = 1:length(zdjecia_walidacyjne)
%     zdjecia_walidacyjne{i} = reshape(zdjecia_walidacyjne{i}, [], 1);
% end
% 
% zdjecia_testowe = reshape(zdjecia_testowe', 1, []);
% for i = 1:length(zdjecia_testowe)
%     zdjecia_testowe{i} = reshape(zdjecia_testowe{i}, [], 1);
% end

wektor_wag_wal = reshape(wektor_wag_wal', 1, []);
for i = 1:length(wektor_wag_wal)
    wektor_wag_wal{i} = wektor_wag_wal{i}';
end

wektor_wag_test = reshape(wektor_wag_test', 1, []);
for i = 1:length(wektor_wag_test)
    wektor_wag_test{i} = wektor_wag_test{i}';
end
X = [wektor_wag_red', cell2mat(wektor_wag_wal), cell2mat(wektor_wag_test)];
X = mat2cell(X,[ilosc_twarzy_wlasnych],[ones(1,1050)]);
T1 = zeros(lidzba_osob, ilosc_twarzy_treningowych_na_osobe * lidzba_osob);
T2 = zeros(lidzba_osob, ilosc_twarzy_walidacyjnych_na_osobe);
T3 = zeros(lidzba_osob, ilosc_twarzy_testowych_na_osobe);

for i = 1:lidzba_osob
    T1(i,(i-1)*ilosc_twarzy_treningowych_na_osobe + 1:i*ilosc_twarzy_treningowych_na_osobe) = ones(1, ilosc_twarzy_treningowych_na_osobe);
    T2(i,(i-1)*ilosc_twarzy_walidacyjnych_na_osobe + 1:i*ilosc_twarzy_walidacyjnych_na_osobe) = ones(1, ilosc_twarzy_walidacyjnych_na_osobe);
    T3(i,(i-1)*ilosc_twarzy_testowych_na_osobe + 1:i*ilosc_twarzy_testowych_na_osobe) = ones(1, ilosc_twarzy_testowych_na_osobe);
end

T = [T1,T2,T3];
T = mat2cell(T, [7], [ones(1,1050)]);

siec_neuronowa_skrypt

load net
y = net(X);
[wynik_zdjecia_siec, ktore_zdjecie_siec] = max(cell2mat(y));
skutecznosc_siec = 0;
for i = 1:length(y)
    
   if T{i}(ktore_zdjecie_siec(i)) == 1
       skutecznosc_siec = skutecznosc_siec + 1;
   end
end