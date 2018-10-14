L=0.0006;
R=1.40; 
kb=0.00867; 
Jm=0.00095; 
bm=0.000015;
kt=0.49428; 
n=200; 
Jl=0.11298; 
bl=0.05649;

J=Jm+Jl/(n^2);
b=bm+bl/(n^2);
k=L*J;

A=[1 0 ;
   -(R*b+kt*kb)/k -(L*b+R*J)/k];
B=[0;
   kt/(n*k)];
C=[1 0];
syms s c1 c2;

det(s*eye(2)-(A-B*[c1 c2]))

