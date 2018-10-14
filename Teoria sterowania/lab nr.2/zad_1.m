clc;
clear;

y = 0;
u = 1;

for k = 1:6  
	yp(k) = 0.95 .* y(k) + 0.2 .* u;
	y(k+1) = yp(k);
end
k = 0:5
hold on
plot(k,u)
plot(k,yp)