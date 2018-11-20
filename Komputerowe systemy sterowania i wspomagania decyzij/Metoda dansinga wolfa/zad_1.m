
load('macierze_do_linproga.mat')

[x, fval] = linprog(c,A2,b2,A1,b1,zeros(1,17))