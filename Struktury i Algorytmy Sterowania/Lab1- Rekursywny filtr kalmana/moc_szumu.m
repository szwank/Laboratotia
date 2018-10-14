% signal = zeros(10000000,1);    
% noiseSignal =  awgn(signal, 10 * log10(0.1));
moc = 0;
for i = 1:length(simout.Data) - 1
    
    moc = 0.001 * simout.Data(i)^2 + moc;
    
    
end

moc/1000


