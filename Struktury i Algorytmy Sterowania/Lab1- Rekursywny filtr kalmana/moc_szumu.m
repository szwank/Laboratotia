% noiseSignal =  wgn(100000,1, 10 * log10(0.1));
moc = 0;
srednia = 0;
for i = 1:length(simout3.Data) - 1
    
    moc = 0.01 * simout3.Data(i)^2 + moc;
    srednia = simout.Data(i) + srednia;
    
    
end

moc / length(simout.Data)
srednia / length(simout.Data)


