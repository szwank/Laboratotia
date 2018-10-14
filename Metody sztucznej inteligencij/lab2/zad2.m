c = 1;
d = 2;

%zbior ucz¹cy-wejœcia(klasa druga jest dodatnia)
p=[-c -c 0 c;
   c -c 0 0];
% wyjœcia
t=[1 1 0 0];

u1=[0 1];


w1=[1,-u1(1)/u1(2)];


%!!!podstawiæ w miejsce macierzy wartoœci z przerabianego modelu!!!
b1=-w1*[-1;0];


w=[w1];

b=[b1];


warstwa=newp([-2  -2; 2 2],1);


warstwa.IW{1,1}=[w1];
warstwa.b{1}=[b1];
hold on
plotpv(p,t)

p=[-2*c c 0 -c;
   0 c c -2*c];
odpowiedz=sim(warstwa,p);



plotpv(p,t)
plotpc(warstwa.IW{1,1},warstwa.b{1})

perceptron_uczony=newp([-2  -2; 2 2],1);
p=[-c -c 0 c;
   c -c 0 0];
perceptron_uczony=train(perceptron_uczony,p,t);

figure
plotpv(p,t)
plotpc(perceptron_uczony.IW{1,1},perceptron_uczony.b{1})




