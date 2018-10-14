czyszczenie = fopen('dane.txt','w');
fclose(czyszczenie);


options = optimoptions('fminunc','Display','iter','DiffMinChange',0.0001)

 A=[0 1;1 0]
 b=[100;100]

fmincon(@optymalizacjaNastaw,[90,1],A,b,[],[],[],[],[],options)