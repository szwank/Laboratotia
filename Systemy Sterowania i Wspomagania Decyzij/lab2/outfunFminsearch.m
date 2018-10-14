function stop = outfun(x,optimValues,state)
    stop = false; %optimValues.iteration iteracja zaczyna sie od 0!
    iter = optimValues.iteration
    fval(iter+1) = optimValues.fval; 
        
    %xval(iter+1,1) = x(1);
    %xval(iter+1,2) = x(2);
        
    daneId = fopen('dane.txt','a+');
    fprintf(daneId,'%.4f %.4f %.4f %.4f %.4f \n',[iter x(1) x(2) x(3) fval(end)]);
    fclose(daneId);
    
    %csvwrite('dane.txt',[iter x(1) x(2) fval],0,iter)
end