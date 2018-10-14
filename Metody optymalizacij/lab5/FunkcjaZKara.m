function [y] = FunkcjaZKara( x )
r1=100;
r2=100;
y = 100*(x(2)-x(1)^2)^2+(1-x(1)).^2 + r2*max(0,2*x(1)+4*x(2)-2 )+r1*((x(1)+x(2)-2))^2;

end

