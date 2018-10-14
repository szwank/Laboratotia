function stop = outfun(x,optimValues,state)
    stop = false; %optimValues.iteration iteracja zaczyna sie od 0!
    iter = optimValues.iteration
     fval = optimValues.fval; 
            daneId = fopen('dane.txt','a+');
            fprintf(daneId,'%.4f %.4f %.4f %.4f %.4f %.4f %.4f %.4f\n',[iter x(1) x(2) x(3) x(4) fval(1) fval(2) fval(3)]);
            fclose(daneId);
   
    %csvwrite('dane.txt',[iter x(1) x(2) fval],0,iter)
end