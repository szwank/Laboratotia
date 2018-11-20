function limit = SPElimit(M, D, alfa, poziom_redukcji)
nalfa = norminv(alfa, 0, 1);
index = M - poziom_redukcji;
www = diag(D);      %wartosci wlasne wektor

for i = 1:3
    for j = 1:index
        www_uciete (j,1) = www (poziom_redukcji + j);
        www_potegi (j,i) = www_uciete(j,1)^i;
    end
    teta(i) = sum(www_potegi(:,i));
end

h0 = 1 - (2*teta(1)*teta(3))/(3*teta(2)^2);

a = (nalfa * sqrt(2*teta(2)*h0^2)) / teta(1);
b = (teta(2)*h0*(h0-1)) / (teta(1)^2);
limit = teta(1)*(a+b+1).^(1/h0);

end