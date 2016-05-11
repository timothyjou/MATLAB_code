%%Li's method Correlation
%take in two binary images
function cor = liCorr(a, b)
    redAverage = mean(mean(a),2);
    greenAverage = mean(mean (b),2);
    sum =0;
    
    for i = 1:max(size(a))
        product = (double(a(i))-redAverage).*(double(b(i))-greenAverage);
        sum = sum + product;
    end 
    
    cor = sum;
end

