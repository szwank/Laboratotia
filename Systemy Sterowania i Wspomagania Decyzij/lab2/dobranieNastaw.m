czyszczenie = fopen('dane.txt','w');
fclose(czyszczenie);


options = optimoptions('fminunc','Display','iter','DiffMinChange',3,'OutputFcn',@outfunFminsearch)

 A=[0 0 -1]
 b=-50

fmincon(@optymalizacja,[70 98 31],A,b,[],[],[],[],[],options)