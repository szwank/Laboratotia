function y=FunkcjaCelu(K)

A = [-0.5 -2 0;
     0 -2 10;
     0 1 -2;];
B = [1 -2;
     -2 2;
     0 1];
C = [1 0 0;
     0 0.5 1];
 
 y = sort(eig(A+B*K*C));
 
end