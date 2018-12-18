u = [0,0,0,0,0,ones(1,33)];
y = zeros(1,10);
for i = 4:33

   y(i) = 0.5*y(i-1) + 0.2*u(i-3);
 
end
figure
hold on
plot(y)
plot(u)

