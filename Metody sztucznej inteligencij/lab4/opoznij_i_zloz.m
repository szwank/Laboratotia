function z = opoznij_i_zloz(p, d, N)
%-------------------------------------------------------------------------
% Jaros³aw G³owacki, Krzysztof Mazur, Micha³ Grochowski Gdañsk 2010
% Katedra In¿ynierii Systemów Sterowania
% Wydzia³ Elektrotechniki i Automatyki
% Politechnika Gdañska
%-------------------------------------------------------------------------
%
% z = opoznij_i_zloz(p, d, N)
%
% gdzie:
%   p   - wektor wejœciowy;
%   z   - opóŸnione i z³o¿one w macierz dane wejœciowe p:
%           z = [ [p(d);...; p(0)],..., [p(N);...; p(N-d)] ]
% oraz:
%   d   - maksymalne opóŸnienie elementu wektora wejœciowego p:
%                           size(z, 1) = d+1
%   N   - liczba z³o¿eñ opóŸnionych wektorów wejœciowych;
%                           size(z, 2) = N-d

%---- Treœc funkcji
for i = 1 : N-d
    for j = 1 : d+1
        z(j, i) = p(i+j-1);
    end
end
z = flipud(z);