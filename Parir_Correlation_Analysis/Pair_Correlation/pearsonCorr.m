%%Pearson correlation
%take in two binary images and calcualte the perason correlation
function cor = pearsonCorr(redBinary, greenBinary)
    redAverage = mean(mean(redBinary),2);
    greenAverage = mean(mean(greenBinary),2);
    topsum = 0;
    redSum = 0;
    greenSum = 0;

    steps = max(size(redBinary));
    for i = 1:steps
        sum1 = (double(redBinary(i))-redAverage).*(double(greenBinary(i))-greenAverage);
        topsum = topsum + sum1;
        sum2 = (double(redBinary(i))-redAverage).^2;
        redSum = redSum + sum2;
        sum3 = (double(greenBinary(i))-greenAverage).^2;
        greenSum = greenSum + sum3;
    end
    cor = topsum /(redSum.*greenSum).^(0.5);
end
