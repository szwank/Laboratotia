close all;
clear
clc
parametrySilnika;
sim('Model_silnika_mdl', 1000);
% klasteryzacja
lidzba_klastrow = 3;
i = 1;
proc_stop_redukcij = [0.4, 0.0001, 0.00001];
lim_T2 = [0.9999999999999999, 0.999, 0.999999];
lim_SPE = [0.99999999999999, 0.99, 0.9999];


X = [Iw_out.signals.values(i:end,:), It_out.signals.values(i:end,:), Omega_out.signals.values(i:end,:), Ut_in.signals.values(i:end,:), Uw_in.signals.values(i:end,:), M_in.signals.values(i:end,:)];

[idx4,centroids,sumdist] = kmeans(X, lidzba_klastrow, 'dist', 'sqeuclidean',...
'display', 'final', 'replicates', 5);
[silh3,h] = silhouette(X, idx4, 'sqeuclidean', 'display', 'iter');
srednia = mean(silh3)

XT = [Iw_out1.signals.values(i:end,:), It_out1.signals.values(i:end,:), Omega_out1.signals.values(i:end,:), Ut_in.signals.values(i:end,:), Uw_in.signals.values(i:end,:), M_in.signals.values(i:end,:)];

%Y = pdist(XT, 'euclidean');
%dist_matrix1 = squareform(Y);
%Z = linkage(Y);
%% posortowanie dystansu
[sumdist, centroids]=posortuj_wektor_przesuwajac_elementy_w_macierzy(sumdist', centroids');
sumdist = sumdist'; % odwrucenie spowrotem danych
centroids = centroids';
%% podzielenie danych testowych
%pogrupowaneXT    % trzy wymiarowa macierz: 1- numer klastra 2,3- macierz danych

l = ones(1,lidzba_klastrow);    % licznik po macierzy 3 wymiarowej
for i = 1:lidzba_klastrow       % utworznie sputych komurek
     XT_podzielone{i} = [];
     X_podzielone{i} = [];
end

% zsumowanie dystansu centroidów


% Podzia³ danych testowych
for i = 1:length(XT)        %pêtla jad¹ca po wierszach w macierzy
     dystans = zeros(1,lidzba_klastrow);
    for j = 1:lidzba_klastrow           % petla sprawdzaj¹ca przynaleznoœæ do klastrów
        dystans(j) = (XT(i,:) - centroids(j,:)) * (XT(i,:) - centroids(j,:))';  
    end
    
    
     k = 1;                                      % numer klastra do którego zostan¹ zapisane dane
    
    for j = 2:lidzba_klastrow                   % sprawdzanie przynale¿noœci
        if dystans(k) > dystans (j)
            k = j;
        end
    end
    XT_podzielone{k}(end+1,:) = XT(i,:);        % przypisanie wiersza macierzy 
    X_podzielone{k}(end+1,:) = X(i,:);  
%     varname = genvarname(join(['XT_', num2str(k)]));
%     eval([varname join(['=[XT_', num2str(k), '; XT(i,:)];'])]);
    
%     switch k
%         case 1
%             XT_1(end+1, :) = XT(i,:);
%         case 1
%             XT_1(end+1, :) = XT(i,:);
%         case 1
%             XT_1(end+1, :) = XT(i,:);
%     end
    
%     if dystans(1) < dystans (2)
%         XT_1(end+1, :) = XT(i,:);        % przypisanie danych do danego klastra
%     else
%         XT_2(end+1, :) = XT(i,:);
%     end
end

for i = 1:lidzba_klastrow

    [ X_PCA1, X_PCAL_11, X_PCAL_pro1, wektor_wartosci_wlasnych1, macierz_wektorow_wlasnych1 ]...
     = stworzPCA(X_podzielone{i}, XT_podzielone{i}, proc_stop_redukcij(i), lim_T2(i), lim_SPE(i));
    
    
    
end

%     [ X_PCA1, X_PCAL_11, X_PCAL_pro1, wektor_wartosci_wlasnych1, macierz_wektorow_wlasnych1 ]...
%        = stworzPCA(X((1==idx4),:), XT_1, 0.1, 0.9999999999999999, 0.99999999999999);
%    
%     [ X_PCA1, X_PCAL_11, X_PCAL_pro1, wektor_wartosci_wlasnych1, macierz_wektorow_wlasnych1 ]...
%        = stworzPCA(X((2==idx4),:), XT_2, 0.0000001, 0.999, 0.9999);
% %    
%        [ X_PCA1, X_PCAL_11, X_PCAL_pro1, wektor_wartosci_wlasnych1, macierz_wektorow_wlasnych1 ]...
%        = stworzPCA(X((3==idx4),:), XT_3, 0.0000001, 0.999, 0.9999);
 
% 
% figure();
% plotmatrix(X((1==idx4),:));
% %load 'dane_zad4';
% 