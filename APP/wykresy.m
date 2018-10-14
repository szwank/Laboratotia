poziom = dane(:,1)/(1600*12);
zawor = dane(:,2)*100/4095;
plot(1400:1571,zawor(1400:end,1))


title('Zadany k¹t otwarcia serwozaworu')
xlabel('Czas[s]')
ylabel('Zadany k¹t otwarcia serwozaworu[%]')



plot(1400:1571,poziom(1400:end,1))


title('Poziom wody w zbiorniku')
xlabel('Czas[s]')
ylabel('Poziom wody w zbiorniku[m]')
