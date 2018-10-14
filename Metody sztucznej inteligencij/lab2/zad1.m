c = 1;
d = 2;

%zbior ucz¹cy-wejœcia(klasa druga jest dodatnia)
p=[c c d d -c -d -c -d;
   c d -c 0 d c -c -d];
% wyjœcia
t=[1 1 1 1 0 0 0 0;
   0 0 1 1 0 0 1 1];

u1=[-2 -1];
u2=[1 -1];

w1=[1,-u1(1)/u1(2)];
w2=[1,-u2(1)/u2(2)];

%!!!podstawiæ w miejsce macierzy wartoœci z przerabianego modelu!!!
b1=-w1*[0;0];
b2=-w2*[0;1.5];

w=[w1;
   w2];
b=[b1;
   b2];

warstwa=newp([0  0; 2 2],2);


warstwa.IW{1,1}=[w1;w2];
warstwa.b{1}=[b1; 1.5];
odpowiedz=sim(warstwa,p)

plotpv(p,t)
plotpc(warstwa.IW{1,1},warstwa.b{1})

perceptron_uczony=newp([0  0; 2 2],2);

perceptron_uczony=train(perceptron_uczony,p,t);

figure
plotpv(p,t)
plotpc(perceptron_uczony.IW{1,1},perceptron_uczony.b{1})


%nowy p
p1=[c c d d -c -d -c -d;
   c d d 0 d c -c -d];

perceptron2=newp([0  0; 2 2],2);

perceptron2=train(perceptron2,p1,t);

figure
plotpv(p1,t)
plotpc(perceptron2.IW{1,1},perceptron2.b{1})



%nowy p
p2=[c c d d -c -d -c -d;
   c d, (d+c)/2, 0 d c -c -d];

perceptron3=newp([0  0; 2 2],2);

perceptron3=train(perceptron2,p2,t);

figure;
plotpv(p2,t)
plotpc(perceptron3.IW{1,1},perceptron3.b{1})
