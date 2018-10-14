function y=optymalizacja(k02)
h=1;
gamma=0.5;
set_param('model/a/Gain','Gain',num2str(k02))
set_param('model/a/Gain1','Gain',num2str(k02))
set_param('model/a/Gain2','Gain',num2str(k02))
set_param('model/a/Gain3','Gain',num2str(k02))
Co2_sat=0.3;
alfa=3.34;

sim('model')
 y = uchyb(end);