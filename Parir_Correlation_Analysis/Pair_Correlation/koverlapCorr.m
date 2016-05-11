%%k - Over-lap Correlation calculation
%take in two binary images
function cor = koverlapCorr(redBinary, greenBinary)
    topsum = 0;
    redSum = 0;
    greenSum = 0;
    
    for i = 1:max(size(redBinary))
        topsum = topsum + redBinary(i).*greenBinary(i);
        redSum = redSum + redBinary(i)^2;
        greenSum = greenSum + greenBinary(i)^2;
    end
    
    k1 = topsum / redSum;
    k2 = topsum/greenSum;
    cor = k1*k2;         %%R^2 = k1*k2
end
