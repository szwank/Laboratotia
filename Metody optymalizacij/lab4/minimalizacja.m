function [x_opt, f_opt, gradient, hessian, iter, x_val, f_val, grad_val] = minimalizacja(x0,alg)
%alg: a- zaufany obszar z gradientem, b- zaufany obszar z hesjanem, 
%z gradientem-> c1- Broydena – Fletchera – Goldfarba – Shanno, c2- Davidona – Fletchera – Powella, c3- najwiêkszego spadku,
%bez gradientu-> d1- Broydena – Fletchera – Goldfarba – Shanno, d2- Davidona – Fletchera – Powella, d3- najwiêkszego spadku,
%e- Neldera-Meada
% przyk³ad: [x_opt, f_opt, gradient, hessian, iter, x_val, f_val, grad_val] = minimalizacja(x0,alg)
% x_opt – znalezione minimum,
% f_opt – wartoœæ funkcji celu w minimum,
% gradient – wartoœæ gradientu w minimum,
% hessian – wartoœæ hesjanu w minimum,
% iter – liczba iteracji(liczone od 0),
% x_val – wektor otrzymanych rozwi¹zañ w danej iteracji,
% f_val – wektor wartoœci funkcji celu w danej iteracji,
% alg – rodzaj wykorzystywanego algorytmu (wpisanie odpowiedniej litery wybiera opcjê od 3a do 3e, np. alg = 3dii – metoda quasi newtonowska, podaj¹c analityczn¹ postaæ gradientu, dfp),
% x0 – punkt startowy

%% inicjacja wartoœci które nie musz¹ byæ pe³ne
gradient =[];
hessian=[];
grad_val=[];
% wyczyszczenie pliku
czyszczenie = fopen('dane.txt','w');
fclose(czyszczenie);


%% ustawienie parametrów funkcij i optymalizacja
switch alg
   case 'a'
      options = optimoptions(@fminunc , 'Algorithm','trust-region' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',true ,...
          'HessianFcn',[],...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output,gradient] = fminunc(@funkcja,[x0(1) x0(2)],options)
	
   case 'b'
      options = optimoptions(@fminunc , 'Algorithm','trust-region' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',true ,...
          'HessianFcn','objective',...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output,gradient,hessian] = fminunc(@funkcja,[x0(1) x0(2)],options)
    case 'c1'
      options = optimoptions(@fminunc , 'Algorithm','quasi-newton' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',true ,...
          'HessUpdate','bfgs',...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output,gradient,hessian] = fminunc(@funkcja,[x0(1) x0(2)],options)
   case 'c2'
      options = optimoptions(@fminunc , 'Algorithm','quasi-newton' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',true ,...
          'HessUpdate','dfp',...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output,gradient,hessian] = fminunc(@funkcja,[x0(1) x0(2)],options)
   case 'c3'
      options = optimoptions(@fminunc , 'Algorithm','quasi-newton' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',true ,...
          'HessUpdate','steepdesc',...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output,gradient,hessian] = fminunc(@funkcja,[x0(1) x0(2)],options)
   case 'd1'
      options = optimoptions(@fminunc , 'Algorithm','quasi-newton' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',false ,...
          'HessUpdate','bfgs',...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output] = fminunc(@funkcja,[x0(1) x0(2)],options)
    case 'd2'
      options = optimoptions(@fminunc , 'Algorithm','quasi-newton' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',false ,...
          'HessUpdate','dfp',...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output] = fminunc(@funkcja,[x0(1) x0(2)],options)
   case 'd3'
      options = optimoptions(@fminunc , 'Algorithm','quasi-newton' ,...
          'Display','iter' ,...
          'SpecifyObjectiveGradient',false ,...
          'HessUpdate','steepdesc',...
          'OutputFcn',@outfun);
      [x_opt,f_opt,exitflag,output] = fminunc(@funkcja,[x0(1) x0(2)],options)
    case 'e'
      options = optimset('Display','iter' ,...
          'OutputFcn',[{@outfunFminsearch}]);
      [x_opt,f_opt]=fminsearch(@funkcja,[x0(1) x0(2)],options)
	gradient =[];
	hessian=[];
end
%% ³adowanie danych
dane = load('dane.txt');
iteracja = 0;

 x_val(iteracja + 1, 1) = dane(1,2);
 x_val(iteracja + 1, 2) = dane(1,3);
 f_val(iteracja + 1, 1) = dane(1,4);
 if alg ~= 'e'
     grad_val(iteracja + 1, 1) = dane(1,5);
     grad_val(iteracja + 1, 2) = dane(1,6);
 end       
for i = 1:length(dane)
    if iteracja ~= dane(i,1) || i == length(dane)
        x_val(iteracja + 2, 1) = dane(i,2);
        x_val(iteracja + 2, 2) = dane(i,3);
        f_val(iteracja + 2, 1) = dane(i,4);
        if alg ~= 'e'
            grad_val(iteracja + 2, 1) = dane(i,5);
            grad_val(iteracja + 2, 2) = dane(i,6);
        end
        iteracja = iteracja + 1;
    end
end
iter = iteracja+1;
%% wyliczanie
	

end
