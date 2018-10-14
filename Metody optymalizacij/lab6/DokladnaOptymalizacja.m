function y=DokladnaOptymalizacja(K)


czyszczenie = fopen('dane.txt','w');
fclose(czyszczenie);



wagi = [5,3,1]
lb = -4*ones(size(K));
ub = 4*ones(size(K));

options = optimset('GoalsExactAchieve',3,'Display','iter-detailed','Diagnostic','on','OutputFcn',@outfun,'PlotFcns',{'optimplotfval','optimplotx'})

[Kobl, fval, attainfactor]  = fgoalattain(@FunkcjaCelu, K, [-5,-3,-1], wagi, [],[],[],[], lb, ub,   [], options)

dane = load('dane.txt');
iteracja = 0;
 x_val(iteracja + 1, 1) = dane(1,2);
 x_val(iteracja + 1, 2) = dane(1,3);
 x_val(iteracja + 1, 3) = dane(1,4);
 x_val(iteracja + 1, 4) = dane(1,5);
 f_val(iteracja + 1, 1) = dane(1,6);   
 f_val(iteracja + 1, 2) = dane(1,7);
 f_val(iteracja + 1, 3) = dane(1,8);
 
for i = 1:length(dane)
    if iteracja ~= dane(i,1) || i == length(dane)
        
         x_val(iteracja + 1, 1) = dane(i,2);
         x_val(iteracja + 1, 2) = dane(i,3);
         x_val(iteracja + 1, 3) = dane(i,4);
         x_val(iteracja + 1, 4) = dane(i,5);
         f_val(iteracja + 1, 1) = dane(i,6);   
         f_val(iteracja + 1, 2) = dane(i,7);
         f_val(iteracja + 1, 3) = dane(i,8);

         iteracja = iteracja + 1;
    end
end
iter = iteracja+1;

figure
plot(1:iteracja,f_val(:,1),1:iteracja,f_val(:,2),1:iteracja,f_val(:,3))
title('Po³o¿enie biegunów')
xlabel('Iteracja')
ylabel('Wartoœæ')
legend('Najmniejszy biegun','Œredni biegun','Najwiêkszy biegun')

figure
plot(1:iteracja,x_val(:,1),1:iteracja,x_val(:,2),1:iteracja,x_val(:,3),1:iteracja,x_val(:,4))
title('Wartoœci macierzy k')
xlabel('Iteracja')
ylabel('Wartoœæ')
lgd = legend('1,1','1,2','2,1','2,2')
title(lgd,'Element macierzy K')

%% symulacja
A = [-0.5 -2 0;
     0 -2 10;
     0 1 -2;];
B = [1 -2;
     -2 2;
     0 1];
C = [1 0 0;
     0 0.5 1]

[times,xvd] = ode45(@(u,x)((A+B*Kobl*C)*x),[0 4],[1;1;1]);

figure
plot(times,xvd)
title('Wykres ziennych stanu')
xlabel('Wartoœæ')
ylabel('Czas')
lgd = legend('1','2','3')
y=Kobl
end

