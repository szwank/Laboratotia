czyszczenie = fopen('dane.txt','w');
fclose(czyszczenie);


options = optimoptions('fminunc','Display','iter','DiffMinChange',0.0001)

 A=[0 0 -1]
 b=-50

fmincon(@optymalizacja,[0.1],[],[],[],[],[],[],[],options)