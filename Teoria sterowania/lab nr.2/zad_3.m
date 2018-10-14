clc;
clear;

A=[0 1;
   1 1];
B=[0;
   1];
C=[1 -1];
D=0;



sys_ss=ss(A,B,C,D);
sys_tf=tf(sys_ss);
wielomian=cell2mat(sys_tf.de);

pierwiastki_tf=roots(wielomian);
X=lyap(A,(-1)*eye(2))