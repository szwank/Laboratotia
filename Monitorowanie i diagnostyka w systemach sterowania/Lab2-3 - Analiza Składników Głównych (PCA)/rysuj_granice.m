function rysuj_granice( wartosc_granicy, wektor_dlugosci_granicy )
%rysuj_granice rysuje granice w plocie o warto�ci +/- wartosc_granicy i
%d�ugo�ci wektor_dlugosci_granicy. funkcja nanoci granice na istniej�cy
%plot.

if nargout > 2  % sprawdzenie lidzby argument�w podanych do funkcij    
   error('rysuj_granice: do funkcij podano za du�a ilo�� argument�w')
end

hold on
plot(wektor_dlugosci_granicy, wartosc_granicy * ones(length(wektor_dlugosci_granicy)))   % wykre�lenie granicy dodatniej
plot(wektor_dlugosci_granicy, - wartosc_granicy * ones(length(wektor_dlugosci_granicy))) % wykre�lenie granicy ujemnej
hold off
end

