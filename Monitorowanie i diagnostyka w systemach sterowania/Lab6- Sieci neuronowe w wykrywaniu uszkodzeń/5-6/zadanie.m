clear all;
close all;
clc;

Ts = 0.25;

parametry;
sim('Model_silnika_szumy.slx');
% sim('costamszumymodel.slx');
tworzenie_X;

%%
% red = 1;   %1 - D>1, 2 - okreœlone R, 3 - okreœlony %
% poziom_redukcji = 3;
% k = 90; % ró¿ne od 100
% 
% X = X_praca;        % praca albo rozruch
% XT = XT_praca;      % ale rozruch nie skacze, bo odchylenie(6,6) = 0
% wiêc inv(odchylenie) = inf, wiêc Xnorm = NaN
% 
% zad4;

%% wykresy
%wykresy;
%wykresy_inne;
%plotmatrixy;
% procent;
% poziom_redukcji;
load residua;
% residua_wektor = [residua(:,1:3);residua(:,4:6);residua(:,7:9);residua(:,10:12);residua(:,13:15);residua(:,16:18)];
macierz = eye(6);

%% konsultant: Krzychu L.
wektor = zeros(size(residua_wektor,1),6);
for i = 1:6
    for j = 1:size(residua,1)
        wektor(j+(i-1)*size(residua,1),:) = macierz(i,:);
    end
end


