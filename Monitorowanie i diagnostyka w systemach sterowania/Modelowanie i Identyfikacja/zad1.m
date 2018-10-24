clear, clc, close all
load('mii_lab_T1.mat')
%% œciagniêcie danych
wejscie = u.signals.values;
yw1 = y_cz1.signals.values;
yw2 = y_cz2.signals.values;
%% podzia³ danych- pierwsza czêœæ
iloscDanychWCzesciObliczeniowej=1500;
wejscie_cz1 = wejscie(1:iloscDanychWCzesciObliczeniowej);
y1_cz1 = yw1(1:iloscDanychWCzesciObliczeniowej);
y1p_cz1 = [0;yw1(1:iloscDanychWCzesciObliczeniowej-1)];
%% wyodrêbnienie poprawnych pomiarów
ymin1 = 2;
ymax1 = 5;
j=1;
k=1;
w1=1;
w2=100;
w3=10000000;
diag_W1=ones(1,iloscDanychWCzesciObliczeniowej);
diag_W2=ones(1,iloscDanychWCzesciObliczeniowej);
diag_W3=ones(1,iloscDanychWCzesciObliczeniowej);
for i=1:iloscDanychWCzesciObliczeniowej
    if(yw1(i)>=ymin1 && yw1(i)<=ymax1)
        diag_W1(i) = w1;
        diag_W2(i) = w2;
        diag_W3(i) = w3;
    end
end
%% Tworzenie macierzy H
H = [y1p_cz1,wejscie_cz1];
%% tworzenie macierzy W
W1 = diag(diag_W1);
W2 = diag(diag_W2);
W3 = diag(diag_W3);
%% estymacja
%{
xKreska = inv(H1'*W1*H1)*H1'*W1*nieDokladnyY1;
K = inv(H1'*W1*H1)*H2'*inv(H2*inv(H1'*W1*H1)*H2');
xDaszek = xKreska+K*(dokladnyY1-H2*xKreska);
%}
%% estymacja
xEst1=inv(H'*W1*H)*H'*W1*y1_cz1
xEst2=inv(H'*W2*H)*H'*W2*y1_cz1
xEst3=inv(H'*W3*H)*H'*W3*y1_cz1

%% symulacja
y1(1)=0;
y2(1)=0;
y2(1)=0;
y3(1)=0;
T=0.001;
for i = 1:1499
   ypoch1(i) = -1/xEst1(1,1)*(-y1(i)+xEst1(2,1)*wejscie(i));
   y1(i+1)=ypoch1(i); 
end
for i = 1:1499
   ypoch2(i) = -1/xEst2(1,1)*(-y2(i)+xEst2(2,1)*wejscie(i));
   y2(i+1)=ypoch2(i); 
end
for i = 1:1499
   ypoch3(i) = -1/xEst3(1,1)*(-y3(i)+xEst3(2,1)*wejscie(i));
   y3(i+1)=ypoch3(i); 
end
%% wspolczynniki
a=(-1/(xEst3(1)*T))*(1-xEst3(1))
b=xEst3(2)*(1/T-1)
%%
%{
T = 0.01;

H = [T*y1,wejscie];
W = diag(ones(1,3001));
xHat = inv(H'*H)*H'*y2
y(1)=0;
for i = 1:3001
    yPoch(i)= y(i) + T * y(i) * xHat(1) - T * xHat(2)*wejscie(i);
    y(i+1)=yPoch(i);
end


xHat = inv(H'*W*H)* H'*W*y1 
%}