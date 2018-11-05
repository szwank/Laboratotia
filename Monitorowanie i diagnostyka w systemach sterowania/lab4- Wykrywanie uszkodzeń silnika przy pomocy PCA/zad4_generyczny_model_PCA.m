close all;
i = 150*4;
X = [Iw_out.signals.values(i:end,:), It_out.signals.values(i:end,:), Ut_in.signals.values(i:end,:)];
XT = [Iw_out1.signals.values(i:end,:), It_out1.signals.values(i:end,:), Ut_in.signals.values(i:end,:)];
[ X_PCA, X_PCAL_1, X_PCAL_pro, wektor_wartosci_wlasnych, macierz_wektorow_wlasnych ] = stworzPCA(X, XT, 0.5, 0.95);