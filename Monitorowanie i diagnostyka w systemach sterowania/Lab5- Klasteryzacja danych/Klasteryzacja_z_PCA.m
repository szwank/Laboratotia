close all;

% klasteryzacja
lidzba_klastrow = 2;
i = 1;
X = [Iw_out.signals.values(i:end,:), It_out.signals.values(i:end,:), Omega_out.signals.values(i:end,:), Ut_in.signals.values(i:end,:), Uw_in.signals.values(i:end,:), M_in.signals.values(i:end,:)];

[idx4,centroids,sumdist] = kmeans(X, lidzba_klastrow, 'dist', 'sqeuclidean',...
'display', 'final', 'replicates', 5);
[silh3,h] = silhouette(X,idx4,'city','display','iter');
srednia = mean(silh3)

XT = [Iw_out1.signals.values(i:end,:), It_out1.signals.values(i:end,:), Omega_out1.signals.values(i:end,:), Ut_in.signals.values(i:end,:), Uw_in.signals.values(i:end,:), M_in.signals.values(i:end,:)];

Y = pdist(XT, 'euclidean');
dist_matrix1 = squareform(Y);
Z = linkage(Y);


%% podzielenie danych testowych
klaster1 = [];
klaster2 = [];

for i = 1:length(XT)        %pêtla jad¹ca po wierszach w macierzy
    
    for j = 1:lidzba_klastrow           % petla sprawdzaj¹ca przynaleznoœæ do klastrów    
        dystans(j) = (XT(1,i) - centroids(1,j)) * (XT(1,i) - centroids(1,j))';  
    end
    
    if dystans(1) < dystans (2)     %sprawdzanie przynale¿noœci
        klaster1()
    else
        
    end
end

% %load 'dane_zad4';
% [ X_PCA, X_PCAL_1, X_PCAL_pro, wektor_wartosci_wlasnych, macierz_wektorow_wlasnych ] = stworzPCA(X, XT, 0.01, 0.9999, 0.95);