A = [2 4];
b = 2;
Aeq = [2 2];
beq = 2;
x0 = [-1 2];

xCon = fmincon(@funkcja,x0,A,b,Aeq,beq)