c = 1;
d = 2;

%zbior ucz�cy-wej�cia(klasa druga jest dodatnia)
p=[c c d d -c -d -c -d;
   c d -c 0 d c -c -d];
% wyj�cia
t=[1 1 1 1 0 0 0 0;
   0 0 1 1 0 0 1 1];

u1=[2 1]
u2=[-1 -1]

w1=[1,-u1(1)/u1(2)];
w2=[1,-u2(1)/u2(2)];

%!!!podstawi� w miejsce macierzy warto�ci z przerabianego modelu!!!
b1=-w1*[0;0];
b2=-w2*[0;1.5];

w=[w1;
   w2];
b=[b1;
   b2];

warstwa=newlind(p,t);
y=sim(warstwa,p)

