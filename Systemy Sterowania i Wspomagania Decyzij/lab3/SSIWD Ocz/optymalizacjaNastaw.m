function y=optymalizacja(x)
h=1;
gamma=0.5;
set_param('modelPI/P','Gain',num2str(x(1)))
set_param('modelPI/I','Gain',num2str(x(2)))
Co2_sat=0.3;
alfa=3.34;

sim('modelPI')
 y = uchyb(end);