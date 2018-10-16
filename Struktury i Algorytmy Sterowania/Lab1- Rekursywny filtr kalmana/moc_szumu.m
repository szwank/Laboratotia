% noiseSignal =  wgn(100000,1, 10 * log10(0.1));
moc = 0;
srednia = 0;
for i = 1:length(simout2.Data) - 1
    
    moc = 0.01 * simout2.Data(i)^2 + moc;
    srednia = simout2.Data(i) + srednia;
    
    
end

moc / length(simout2.Data)
srednia / length(simout2.Data)


