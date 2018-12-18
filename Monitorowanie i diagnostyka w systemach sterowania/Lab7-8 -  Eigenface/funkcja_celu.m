function [wartosc]=funkcja_celu(f)
load('T.mat')
load('X.mat')
trainFcn = 'trainbr';

wartosc = 0;
inputDelays = 0:3;
feedbackDelays = 1:3;
hiddenLayerSize = 10;
x = [];
save('x-dane','x')
for i = 1:length(f)
    
    if f(i) > 0
        x(end+1) = f(i);
    end

end

if isempty(x) == true
    
    wartosc = 0
else
    net = feedforwardnet(x,trainFcn);

    net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};

     net.divideFcn = 'divideblock';  
     net.divideMode = 'time';  % Divide up every sample
     net.divideParam.trainRatio = 20/150;
     net.divideParam.valRatio = 10/150;
     net.divideParam.testRatio = 120/150;

    % Moje ustawienia
     net.trainParam.max_fail = 100;      % Maximum validation failures
     net.trainParam.lr = 0.0001;         % Learning rate
     net.trainParam.epochs = 10^20;
     net.trainParam.min_grad = 1e-20;
     net.trainParam.time = 40;


    net.performFcn = 'crossentropy';  % Mean Squared Error

    net.plotFcns = {'plotperform','plottrainstate', 'ploterrhist', ...
        'plotregression', 'plotresponse', 'ploterrcorr', 'plotinerrcorr'};
    net.sampleTime=0.1;     
    net = train(net,X,T);

    y = net(X);
    e = gsubtract(T,y);
    performance = perform(net,T,y)




    [wynik_zdjecia_siec, ktore_zdjecie_siec] = max(cell2mat(y));
    skutecznosc_siec = 0;
    for i = 1:length(y)

       if T{i}(ktore_zdjecie_siec(i)) == 1
           skutecznosc_siec = skutecznosc_siec + 1;
       end
    end

    skutecznosc_siec = skutecznosc_siec / length(y)
    wartosc = -skutecznosc_siec
end
end