%%tiff to Binary image helper function
%if !0, change it to 1.
function bin = tiffToBinary(tiffImg)
    bin = tiffImg;
    for i=1:max(size(tiffImg))
        if bin(i)>0
            bin(i) = 1;
        end
    end
end
