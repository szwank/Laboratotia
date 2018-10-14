function [y,g,H] = funkcja(x)

y = 100*(x(2)-x(1)^2)^2+(1-x(1)).^2; %funkcja do optymalizacij

    if nargout > 1
        g = [(-400*x(1)*x(2))+400*x(1)^3+2*x(1)-2;
             200*x(2)-200*x(1)^2];
        if nargout > 2
            H = [(-400*x(2))+1200*x(1)^2+2, -400*x(1) ;
                  -400*x(1), 200];
        end
    end
end