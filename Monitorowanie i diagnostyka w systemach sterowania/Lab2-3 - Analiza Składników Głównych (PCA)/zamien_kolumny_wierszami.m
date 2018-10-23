function [ zamieniona_macierz ] = zamien_kolumny_wierszami( macierz, numer_pierwszej_kolumny, numer_drugiej_kolumny )
%Funkcja zamienia dwie kolumny macierzy miejscami

if numer_pierwszej_kolumny > length(macierz(1,:))
    error('Numer pierwszej kolumny wychodzi poza rozmier macierzy')
    return;
elseif numer_drugiej_kolumny > length(macierz(1,:))
    error('Numer drugiej kolumny wychodzi poza rozmier macierzy')
    return;
end

zamieniona_macierz = macierz;        % wykonanie kopij do sortowania

zamieniona_macierz(:,numer_pierwszej_kolumny) = macierz(:,numer_drugiej_kolumny);   % zamienienie miejscami kolumn
zamieniona_macierz(:,numer_drugiej_kolumny) = macierz(:,numer_pierwszej_kolumny);

end

