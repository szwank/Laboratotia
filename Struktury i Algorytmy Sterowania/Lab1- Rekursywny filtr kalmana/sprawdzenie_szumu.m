noiseSignal =  wgn(100000000,1, 10 * log10(0.1));
Z = 0;
suma = 0;
for i = 1:length(noiseSignal) - 1
    
    Z = (noiseSignal(i)) * (noiseSignal(i))' + Z;
    
    
end

Z/100000000
  