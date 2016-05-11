%% This script is used to generate a image from the original .tiff
%image that would yield a correlation of -1 when compared with original image.
% output is naemd as "negTest_originalFileName" in the same folder as the original file

[tiffFname, tiffFFolder] = uigetfile('G:\.tif', 'Select a tiff file for correlation analysis');
tiffFPath = fullfile(tiffFFolder, tiffFname);
tiffRaw = importdata(tiffFPath);
tiff = reshape(tiffRaw,1,[]);
fprintf('Loaded: tiff file. \n');
tiffMax = max(tiff);

for n = 1:max(size(tiff))
    if tiff(n) > 0
        tiff(n) = 0;
    else tiff(n) = randi(1000);
    end
end

testFname = strcat('negTest_',tiffFname);
testFPath = fullfile(tiffFFolder,testFname);
save(testFPath, 'tiff');
disp('Finished negative test generation');
