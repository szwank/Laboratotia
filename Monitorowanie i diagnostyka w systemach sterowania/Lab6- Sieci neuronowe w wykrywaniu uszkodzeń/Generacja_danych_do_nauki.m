%  Fs = 100;
%  t = 0:1/Fs:1000;
%  f_in_start = 0.01;
%  f_in_end = 1;
%  f_in = linspace(f_in_start, f_in_end, length(t));
%  phase_in = cumsum(f_in/Fs);
%  y = 100 * sin(2*pi*phase_in);
%  y = abs(y);
%  y = 200 * abs(sin(2*pi*t*0.01)) + y;
%  plot(t,y)
%  y(10000:20000) = 250 * rand(1,10000+1);
%  plot([t(1:end-1),t(1:end-1)+t(1:end-1)],y)
%  
t = 1;
parametrySilnika;
sim('Model_silnika1', 3000);
% sim('Model_silnika_mdl1', 2700);
% sim('Model_silnika_mdl2', 2700);
% load('Validation_data.mat')
% load('Training_data.mat')
% stosunek_danych_uczacych = length(IN1(t:end,:)') / ( length(IN1(t:end,:)') + length(IN2(1:end,:)'));
% X = [IN1(t:end,:)',IN2(t:end,:)'];
X = [IN1(t:end,:)];
% X = con2seq(X);
% X = tonndata(X,false,false);
% T = [OUT1(t:end,:)', OUT2(t:end,:)'] ;
T = [OUT1(t:end,:)] ;
% T = con2seq(T);
% T = tonndata(T,false,false);