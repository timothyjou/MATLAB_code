%% Overlap correlation
%take in two binary images
function cor = overlapCorr(redBinary, greenBinary)
    topsum = 0;
    redSum = 0;
    greenSum = 0;
    
    for i = 1:max(size(redBinary))
        topsum = topsum + redBinary(i).*greenBinary(i);
        redSum = redSum + redBinary(i)^2;
        greenSum = greenSum + greenBinary(i)^2;
    end
    cor = topsum / (double(redSum.*greenSum)).^0.5;
end
