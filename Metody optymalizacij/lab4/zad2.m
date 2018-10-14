 clear all,clc, clear;

x0 = [-2 -4];
[x_opt, f_opt, gradient, hessian, iter, x_val, f_val, grad_val] = minimalizacja(x0,'d3');
x1 = linspace(-2,4,150);
x2 = linspace(-4,13,150);

[x1,x2] = meshgrid(x1,x2);
for i = 1:length(x2(1,:))
    for j = 1:length(x2(:,1))
        y(i,j) = funkcja([x1(i,j) x2(i,j)]);
    end
end

surf(x1,x2,y);
hold on;
plot3(x_val(:,1),x_val(:,2),f_val(:,1),'m.','markersize',30);
hold off;
%ustawienia wykresu
%nadanie kolorów dla wykresu
shading interp;
%dodanie œwiat³a z prawej
camlight;

%po³o¿enie wykresu
Az = -63;
Ei = 74;
view(Az,Ei);

title('Wizualizacja dzia³ania algorytmu');
xlabel('x1');
ylabel('x2');
zlabel('Wartoœæ funkcji');


figure;
plot(1:iter,f_val);
title('Wykres wartoœci funkcji celu w danej iteracji od numeru iteracji');
xlabel('Numer iteracji');
ylabel('Wartoœæ funkcij celu w danej iteracji');