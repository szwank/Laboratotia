clc;
clear;

zaladowanieDanychUczacych;%%Wyjœcie: daneUczace i odpowiedz
zaladowanieDanychTestujacych;

liczbaNeuronow = 100;
for i = 1:liczbaNeuronow
    PR(i,:) = [0 1];%% tworzenie zakresu wejœc
end



%siec = newp(PR,[0 1; 0 1; 0 1],'tansig');
siec = feedforwardnet(75,'trainscg');
%siec = perceptron;
%siec.divideFcn = '';


siec = train(siec,daneUczace,odpowiedz);

%Y = sim(siec,daneTestowe)
Y = sim(siec,daneUczace)
plotroc(odpowiedz,Y)
