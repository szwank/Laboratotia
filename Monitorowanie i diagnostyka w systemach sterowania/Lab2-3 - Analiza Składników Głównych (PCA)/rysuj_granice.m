function rysuj_granice( wartosc_granicy, wektor_dlugosci_granicy )
%rysuj_granice rysuje granice w plocie o wartoœci +/- wartosc_granicy i
%d³ugoœci wektor_dlugosci_granicy. funkcja nanoci granice na istniej¹cy
%plot.

if nargout > 2  % sprawdzenie lidzby argumentów podanych do funkcij    
   error('rysuj_granice: do funkcij podano za du¿a iloœæ argumentów')
end

hold on
plot([1,wektor_dlugosci_granicy(end)], wartosc_granicy * ones(2))   % wykreœlenie granicy dodatniej
plot([1,wektor_dlugosci_granicy(end)], -wartosc_granicy * ones(2)) % wykreœlenie granicy ujemnej
hold off
end

