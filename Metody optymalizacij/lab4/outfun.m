function stop = outfun(x,optimValues,state)
    stop = false; %optimValues.iteration iteracja zaczyna sie od 0!
    iter = optimValues.iteration
    fval(iter+1) = optimValues.fval; 
        gradient = optimValues.gradient;
        %xval(iter+1,1) = x(1);
        %xval(iter+1,2) = x(2);
        if isempty(gradient) == 0
            daneId = fopen('dane.txt','a+');
            fprintf(daneId,'%.4f %.4f %.4f %.4f %.4f %.4f \n',[iter x(1) x(2) fval(end) gradient(1,1) gradient(2,1)]);
            fclose(daneId);
        end
   
    %csvwrite('dane.txt',[iter x(1) x(2) fval],0,iter)
end