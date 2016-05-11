%% Mander's correlation calculation
%take in two binary images
function [cor1, cor2] = mandersCorr(red, green)
    threshold = mean(mean(red),2);
    rednum = 0;
    greennum = 0;
    redSum = 0;
    greenSum = 0;
    
    for i = 1:max(size(red))
        if(green(i)>threshold)
            rednum = rednum + red(i); 
        end
        if (red(i) > threshold)
            greennum = greennum +green(i);
        end
        redSum = redSum +red(i);
        greenSum = greenSum + green(i);
    end
   cor1 = rednum / redSum;
   cor2 = greennum / greenSum;
end
