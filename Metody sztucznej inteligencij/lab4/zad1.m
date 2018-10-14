clc; clear; close all;
dt1 = 1/15;
dt2 = dt1/2;
t1 = 1:dt1:8;
t2 = 8:dt2:15;
t = [t1 t2];

a = 1;
b = 2;
c = 3;
T1 = sin(a*pi*t1);
T2 = c*sin(b*pi*t2);

T=[T1 T2];
%{
for i = 1:length(T1)
    
    if rem(i,2) == 1
        T(i) = T1(i) + T2((i+1)/2);
    else
        T(i) = T1(i);
    end
end
%}

siec = newlin([-c c],1,1:3,0.09);
Tseq = con2seq(T);
tseq = con2seq([t1 t2]);
for i = 1:1
    [siec,Y,E,Pf] = adapt(siec,Tseq,Tseq);
end
%T = seq2con(T);

%t = seq2con(t);

%Y = sim(siec,t);
Y = cell2mat(Y);
bladKwadratowy = mse(siec,t,T); %blad srednio kwadratowy
%sim(siec,[t1 t2])

figure
plot(t, T, t, Y)
title('porównanie sygna³ów')
legend('rzeczywisty sygna³', 'estymowany sygna³')
ylim([-3 3])
figure
blad = ((T-Y).^2);
plot(t,blad );
title('B³¹d œrednio kwadratowy');

figure
plot(t, T-Y);
title('B³¹d predykcij');



