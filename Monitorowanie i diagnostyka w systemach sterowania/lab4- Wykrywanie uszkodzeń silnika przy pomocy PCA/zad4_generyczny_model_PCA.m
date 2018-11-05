close all;

i = 100*4;
X = [Iw_out.signals.values(i:end,:), It_out.signals.values(i:end,:), Ut_in.signals.values(i:end,:), Uw_in.signals.values(i:end,:), M_in.signals.values(i:end,:)];
XT = [Iw_out1.signals.values(i:end,:), It_out1.signals.values(i:end,:), Ut_in.signals.values(i:end,:), Uw_in.signals.values(i:end,:), M_in.signals.values(i:end,:)];
%load 'dane_zad4';
[ X_PCA, X_PCAL_1, X_PCAL_pro, wektor_wartosci_wlasnych, macierz_wektorow_wlasnych ] = stworzPCA(X, XT, 0.01, 0.9999, 0.95);

% figure(10);
% plotmatrix(X);
% 
% figure(11);
% plotmatrix(XT);

% 
% X = [Iw_out.signals.values(1:i,:), It_out.signals.values(1:i,:), Omega_out.signals.values(1:i,:), Ut_in.signals.values(1:i,:), Uw_in.signals.values(1:i,:), M_in.signals.values(1:i,:)];
% XT = [Iw_out1.signals.values(1:i,:), It_out1.signals.values(1:i,:), Omega_out1.signals.values(1:i,:), Ut_in.signals.values(1:i,:), Uw_in.signals.values(1:i,:), M_in.signals.values(1:i,:)];
% %load 'dane_zad4';
% [ X_PCA, X_PCAL_1, X_PCAL_pro, wektor_wartosci_wlasnych, macierz_wektorow_wlasnych ] = stworzPCA(X, XT, 0.3, 0.9999, 0.97);