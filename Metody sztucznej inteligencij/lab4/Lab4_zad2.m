%-------------------------------------------------------------------------
% Jaros�aw G�owacki, Krzysztof Mazur, Micha� Grochowski, Gda�sk 2010
% Katedra In�ynierii System�w Sterowania
% Wydzia� Elektrotechniki i Automatyki
% Politechnika Gda�ska
%
% Materia� na potrzeby Laboratorium:
%
%                Metody Sztucznej Inteligencji 
%                         Termin T4
%                         Zadanie 2
%-------------------------------------------------------------------------
%%

%---- Sprz�tanie:
clear all;          % pami�ci
close all;          % wykres�w
clc;                % okna polece�


%---- Symulacja
t_sym = 2;          % czas symulacji [s] (okres pr�bkowania Ts = 0.001 s)
Ug = 0.1;           % wp�yw napi�cia zasilania U_sk = 230 V na pomiary EKG:
                    %                 - wzmocnienie amplitudy napi�cia [-]
Ud = 5;             % wp�yw napi�cia zasilania f = 50 Hz na pomiary EKG:
                    %                 - op�nienie [pr�bek]
                    % (przesuni�cie fazowe [rad] = 2*pi*f*Ts * Ud)
                    
t = sim('Lab4_zad2_ekg'); % symulacja modelu
                                     % (dane wraz z wektorem czasu t [s])

                                      
%---- Macierz danych wej�ciowych z:
%           z = [ [p(d);...; p(0)],..., [p(N);...; p(N-d)] ]
%     (dla potrzeb wyznaczenia maksymalnego wsp�lczynnika uczenia 'LR')



p = 0.1*sin(t+pi/2);           % dane wej�ciowe do sieci neuronowej 
                    % (WYBIERZ Z DOST�PNYCH DANYCH NA PODSTAWIE TRE�CI 
                    %  ZADANIA)

                    
                    
                    
N = length(t);      % szeroko�c okna pomiarowego [pr�bek]
d = 0;              % maksymalna warto�� op�znienia przesuwnej linii 
                    % op�niaj�cej
ID = [0 : d];       % wektor op�nie� (argument funkcji 'newlin')

z = opoznij_i_zloz(p, d, N);         % odwo�anie do funkcji niestandardowej
                                     

%% *************************************************************************                                     
%                                      
%---- Rozwi�zanie Zadania 
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
title('por�wnanie sygna��w-szum')
legend('rzeczywisty sygna�', 'estymowany sygna�')
%xlim([0 0.7])
figure
plot(t, EKG_RZ', t, Y)
title('por�wnanie sygna��w-rzeczywisty')
legend('rzeczywisty sygna�', 'estymowany sygna�')
figure
blad = ((EKG_RZ'-Y).^2);
plot(t,blad );
title('B��d �rednio kwadratowy');





