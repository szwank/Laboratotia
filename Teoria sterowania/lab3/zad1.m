clc;
clear;
%macierze uk³adu
A=[-100 0 0;
   1 -15 0;
   0 1 0];
B=[1000;
   0;
   0];
C=[0 0 0.4];
%pomocny syf
%{
sys_ss=ss(A,B,C,0);
sys_tf=tf(sys_ss)

syms s l1 l2 l3;
L=[l1 l2 l3];
charpoly(A-B*L)

det(s*eye(3)-A+B*L)
%syf
%}

%% pierwszy uk³ad
t=0:0.01:10;
syms s;
%{
L=[-0.038 1.9 13.72];
Acl=(A-B*L);
Bcl=B;
sys_ulokowaneBieguny1=ss(Acl,Bcl,C,0);
%[y1,t1,x1]=lsim(sys_ulokowaneBieguny1,zeros(1,length(t)),t,[0.2 0.2 0.2]);
%wyliczenie macierzy tranzycij i odpowiedzi sfobodnych uk³adu
mac_tran1=ilaplace((s*ones(3)-Acl)^-1);
x1=mac_tran1*[0.2;0.2;0.2];
y1=C*mac_tran1*[0.2;0.2;0.2];
%dopowiedzi sfobodne pierwszego uk³adu (x1,x2,x2,y)
x1_1=matlabFunction(x1(1,1));
x1_2=matlabFunction(x1(2,1));
x1_3=matlabFunction(x1(3,1));
y1=matlabFunction(y1);
figure('Name','Wykres stanów1','NumberTitle','off');
hold on;
plot(t,x1_1(t))
plot(t,x1_2(t))
plot(t,x1_3(t))

figure('Name','Odpowiedz1','NumberTitle','off');
plot(t,y1(t))

%% drugi uk³ad(podpunkt b)
L=[-0.005 -1.485 -0.6];
Acl1=(A-B*L);
Bcl=B;
sys_ulokowaneBieguny2=ss(Acl1,Bcl,C,0);
%wyliczenie macierzy tranzycij i odpowiedzi sfobodnych uk³adu
mac_tran1=ilaplace((ones(3)*s-Acl1)^-1);
x1=mac_tran1*[0.2;0.2;0.2];
y1=C*mac_tran1*[0.2;0.2;0.2];
%dopowiedzi sfobodne pierwszego uk³adu (x1,x2,x2,y)
x1_1=matlabFunction(x1(1,1));
x1_2=matlabFunction(x1(2,1));
x1_3=matlabFunction(x1(3,1));
y1=matlabFunction(y1);
figure('Name','Wykres stanów2','NumberTitle','off');
hold on;
plot(t,x1_1(t))
plot(t,x1_2(t))
plot(t,x1_3(t))

figure('Name','Odpowiedz2','NumberTitle','off');
plot(t,y1(t))

%}
L=[-0.038 1.9 13.72];
Acl=(A-B*L);
Bcl=B;
sys_ulokowaneBieguny1=ss(Acl,Bcl,C,0);
[y1,t1,x1]=lsim(sys_ulokowaneBieguny1,zeros(1,length(t)),t,[0.2 0.2 0.2]);



figure('Name','Wykres stanów1','NumberTitle','off');
hold on;
plot(t,x1(1))
plot(t,x1(2))
plot(t,x1(3))

figure('Name','Odpowiedz1','NumberTitle','off');
plot(t,y1)

L=[-0.005 -1.485 -0.6];
Acl1=(A-B*L);
Bcl=B;
sys_ulokowaneBieguny2=ss(Acl1,Bcl,C,0);
[y2,t2,x2]=lsim(sys_ulokowaneBieguny2,zeros(1,length(t)),t,[0.2 0.2 0.2]);

figure('Name','Wykres stanów2','NumberTitle','off');
hold on;
plot(t,x2(1))
plot(t,x2(2))
plot(t,x2(3))

figure('Name','Odpowiedz1','NumberTitle','off');
plot(t,y2)
