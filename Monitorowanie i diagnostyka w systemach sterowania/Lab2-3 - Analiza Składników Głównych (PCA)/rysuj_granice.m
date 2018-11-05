function rysuj_granice( wartosc_granicy, wektor_dlugosci_granicy )
%rysuj_granice rysuje granice w plocie o warto�ci +/- wartosc_granicy i
%d�ugo�ci wektor_dlugosci_granicy. funkcja nanoci granice na istniej�cy
%plot.

if nargout > 2  % sprawdzenie lidzby argument�w podanych do funkcij    
   error('rysuj_granice: do funkcij podano za du�a ilo�� argument�w')
end

hold on
plot([1,wektor_dlugosci_granicy(end)], wartosc_granicy * ones(2))   % wykre�lenie granicy dodatniej
plot([1,wektor_dlugosci_granicy(end)], -wartosc_granicy * ones(2)) % wykre�lenie granicy ujemnej
hold off
end

