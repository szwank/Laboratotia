%% usuniêcie wartoœci w³asnych mniejszych od 1
if red == 1
    index = 1;
    for i = 1:M
        if D(i,i) > 1        %tutaj zmiana warunku, nie bêdzie pêtli w sumie
            wartosci(:,index) = D(:,i);
            wektory(:,index) = V(:,i);
            index = index + 1;
        end
    end

    for j = 1:M
        for i = index:M
            wartosci(j,i) = 0;
            wektory(j,i) = 0;
        end
    end
    poziom_redukcji = index - 1;
end

%% redukcja do konkretnego wymiaru
if red == 2
    for i = 1:poziom_redukcji
        wartosci(:,i) = D(:,i);
        wektory(:,i) = V(:,i);
    end

    for j = 1:M
        for i = (poziom_redukcji+1):M
            wartosci(j,i) = 0;
            wektory(j,i) = 0;
        end
    end
end

%% po¿¹dana iloœæ niesionej informacji
if red == 3
    wart_wl = diag(D);
    index = 1;
    for i = 1:M
        wartosci(:,i) = D(:,i);
        wektory(:,i) = V(:,i);
        procent_inf(i) = sum(sum(wartosci))/sum(sum(D))*100
        index = index + 1
        if procent_inf(1,i) >= k
            break
        end
    end
    for j = 1:M
        for i = index:M
            wartosci(j,i) = 0;
            wektory(j,i) = 0;
        end
    end
    poziom_redukcji = index - 1;
end

%% procent niesionej informacji po redukcji
procent = sum(sum(wartosci))/sum(sum(D))*100;
