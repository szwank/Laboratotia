function [ SPE_limit ] = policz_SPE_limit( wektor_wartosci_wlasnych )
%Obliczenie SPE limit

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
% Pierwszy cz³on
W = norminv(0.95) * sqrt(2 * omega2 * h0 ^ 2)/ omega1;
% drugi cz³on
Z = (omega2 * h0 * (h0 -1)) / omega1^2;

SPE_limit = omega1 * (W + Z + 1) ^ (1/h0);

end

