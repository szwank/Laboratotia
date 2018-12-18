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
load('Dane/Dzialajacy_r_out.mat');
load('Dane/Rw1_r_out');
load('Dane/G1_r_out.mat');
load('Dane/Rt1_r_out');
load('Dane/Odpowiedzi');
t = 1;
% sim('Model_silnika_mdl1', 2700);
% sim('Model_silnika_mdl2', 2700);
% load('Validation_data.mat')
% load('Training_data.mat')
% stosunek_danych_uczacych = length(IN1(t:end,:)') / ( length(IN1(t:end,:)') + length(IN2(1:end,:)'));
% X = [IN1(t:end,:)',IN2(t:end,:)'];
X = [Dzialajacy_r_OUT1(t:end,:)',Rw1_r_OUT1(t:end,:)',G1_r_OUT1(t:end,:)',Rt1_r_OUT1(t:end,:)'];
% X = con2seq(X);
% X = tonndata(X,false,false);
% T = [OUT1(t:end,:)', OUT2(t:end,:)'] ;
% T = [Odpowiedzi(t:end,:)];
one = ones(1,30001);
T = Odpowiedzi';
% T = {[one, zeros(1,3*30001)],[zeros(1,30001),one, zeros(1,2*30001)],[zeros(1,2*30001),one,zeros(1,1*30001)],[zeros(1,3*30001),one]};
% T = [[one;zeros(1,30001);zeros(1,30001);zeros(1,30001)],
%      [zeros(1,30001);one;zeros(1,30001);zeros(1,30001)],
%      [zeros(1,30001);zeros(1,30001);one;zeros(1,30001)],
%      [zeros(1,30001);zeros(1,30001);zeros(1,30001);one]];

% T = con2seq(T);
% T = tonndata(T,false,false);