function [ SPE_limit ] = policz_SPE_limit( wektor_wartosci_wlasnych, procent )
%Obliczenie SPE limit

if(sum(wektor_wartosci_wlasnych) == 0 || isempty(wektor_wartosci_wlasnych) == 1)
    SPE_limit = 0;
else

    omega1 = 0;            % Policzenie sumy wartosci wlasnych
    omega2 = 0; 
    omega3 = 0; 
    for i = 1:length(wektor_wartosci_wlasnych)

        omega1 = omega1 + wektor_wartosci_wlasnych(i);
        omega2 = omega2 + wektor_wartosci_wlasnych(i)^2;
        omega3 = omega3 + wektor_wartosci_wlasnych(i)^3;
    end
    % Wyznaczenie h0
    h0 = 1 - (2 * omega1 * omega3)/(3 * omega2^2);
    % Pierwszy cz�on
    W = norminv(procent) * sqrt(2 * omega2 * h0 ^ 2)/ omega1;
    % drugi cz�on
    Z = (omega2 * h0 * (h0 -1)) / omega1^2;


    SPE_limit = omega1 * (W + Z + 1) ^ (1/h0);
end
end

