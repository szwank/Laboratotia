function z = opoznij_i_zloz(p, d, N)
%-------------------------------------------------------------------------
% Jaros�aw G�owacki, Krzysztof Mazur, Micha� Grochowski Gda�sk 2010
% Katedra In�ynierii System�w Sterowania
% Wydzia� Elektrotechniki i Automatyki
% Politechnika Gda�ska
%-------------------------------------------------------------------------
%
% z = opoznij_i_zloz(p, d, N)
%
% gdzie:
%   p   - wektor wej�ciowy;
%   z   - op�nione i z�o�one w macierz dane wej�ciowe p:
%           z = [ [p(d);...; p(0)],..., [p(N);...; p(N-d)] ]
% oraz:
%   d   - maksymalne op�nienie elementu wektora wej�ciowego p:
%                           size(z, 1) = d+1
%   N   - liczba z�o�e� op�nionych wektor�w wej�ciowych;
%                           size(z, 2) = N-d

%---- Tre�c funkcji
for i = 1 : N-d
    for j = 1 : d+1
        z(j, i) = p(i+j-1);
    end
end
z = flipud(z);