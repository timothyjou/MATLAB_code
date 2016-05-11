%%incomplete
%%Corelation calcualted usingCoste's method
%take in two binary images
function cor = costesCorr(redBinary, greenBinary)
    redthreshold = 0;
    greenthreshold = 0;
    %calculate average for green and red using the threshold
    %%redAverage = ;
    %%greenAverage = ;
    for i = 1:max(size(redBinary))
            topsum = 0;
            redSum = 0;
            greenSum = 0;
        if redBinary(i) < redthreshold && greenBinary < greenthreshold
            sum1 = (double(redBinary(i))-redAverage).*(double(greenBinary(i))-greenAverage);
            topsum = topsum + sum1;
            sum2 = (double(redBinary(i))-redAverage).^2;
            redSum = redSum + sum2;
            sum3 = (double(greenBinary(i))-greenAverage).^2;
            greenSum = greenSum + sum3; 
        end
    end
    tempcor = topsum /(redSum.*greenSum).^(0.5);
    if tempcorr ==0
        %%then calculate the correlation above red / green threshold, else
        %%continue the loop to decrement red/green theshold
    end
end

    
 