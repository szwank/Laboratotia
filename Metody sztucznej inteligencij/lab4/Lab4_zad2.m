%-------------------------------------------------------------------------
% Jaros³aw G³owacki, Krzysztof Mazur, Micha³ Grochowski, Gdañsk 2010
% Katedra In¿ynierii Systemów Sterowania
% Wydzia³ Elektrotechniki i Automatyki
% Politechnika Gdañska
%
% Materia³ na potrzeby Laboratorium:
%
%                Metody Sztucznej Inteligencji 
%                         Termin T4
%                         Zadanie 2
%-------------------------------------------------------------------------
%%

%---- Sprz¹tanie:
clear all;          % pamiêci
close all;          % wykresów
clc;                % okna poleceñ


%---- Symulacja
t_sym = 2;          % czas symulacji [s] (okres próbkowania Ts = 0.001 s)
Ug = 0.1;           % wp³yw napiêcia zasilania U_sk = 230 V na pomiary EKG:
                    %                 - wzmocnienie amplitudy napiêcia [-]
Ud = 5;             % wp³yw napiêcia zasilania f = 50 Hz na pomiary EKG:
                    %                 - opóŸnienie [próbek]
                    % (przesuniêcie fazowe [rad] = 2*pi*f*Ts * Ud)
                    
t = sim('Lab4_zad2_ekg'); % symulacja modelu
                                     % (dane wraz z wektorem czasu t [s])

                                      
%---- Macierz danych wejœciowych z:
%           z = [ [p(d);...; p(0)],..., [p(N);...; p(N-d)] ]
%     (dla potrzeb wyznaczenia maksymalnego wspólczynnika uczenia 'LR')



p = 0.1*sin(t+pi/2);           % dane wejœciowe do sieci neuronowej 
                    % (WYBIERZ Z DOSTÊPNYCH DANYCH NA PODSTAWIE TREŒCI 
                    %  ZADANIA)

                    
                    
                    
N = length(t);      % szerokoœc okna pomiarowego [próbek]
d = 0;              % maksymalna wartoœæ opóznienia przesuwnej linii 
                    % opóŸniaj¹cej
ID = [0 : d];       % wektor opóŸnieñ (argument funkcji 'newlin')

z = opoznij_i_zloz(p, d, N);         % odwo³anie do funkcji niestandardowej
                                     

%% *************************************************************************                                     
%                                      
%---- Rozwi¹zanie Zadania 
%     (POWODZENIA!)

%% podpunkt I
lr = maxlinlr(EKG_RZ')
%% podpunkt II
siec = newlin([-26.3997 37.0151],1,1:15,lr);
EKG_RZseq = con2seq(EKG_RZ');
EKG_POMseq = con2seq(EKG_POM');

[siec,Y,E,Pf] = adapt(siec,EKG_POMseq,EKG_RZseq);
Y = cell2mat(Y);




figure
plot(t, EKG_POM', t, Y)
title('porównanie sygna³ów-szum')
legend('rzeczywisty sygna³', 'estymowany sygna³')
%xlim([0 0.7])
figure
plot(t, EKG_RZ', t, Y)
title('porównanie sygna³ów-rzeczywisty')
legend('rzeczywisty sygna³', 'estymowany sygna³')
figure
blad = ((EKG_RZ'-Y).^2);
plot(t,blad );
title('B³¹d œrednio kwadratowy');





