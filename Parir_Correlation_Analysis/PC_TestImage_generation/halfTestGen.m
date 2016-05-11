%% This script is used to generate a image from the original .tiff
%image that would yield a correlation of ~0.5 when compared to the original image
% output is naemd as "halfTest_originalFileName" in the same folder as the original file
[tiffFname, tiffFFolder] = uigetfile('G:\.tif', 'Select a tiff file for correlation analysis');
tiffFPath = fullfile(tiffFFolder, tiffFname);
tiffRaw = importdata(tiffFPath);
tiff = reshape(tiffRaw,1,[]);
fprintf('Loaded: tiff file. \n');
steps = max(size(tiff))/9.17;

for n = 1:steps
        if tiff(n) > 0
            tiff(n) = 0;
        else tiff(n) = randi(1000);
        end
end

testFname = strcat('halfTest_',tiffFname);
testFPath = fullfile(tiffFFolder,testFname);
save(testFPath, 'tiff');
fprintf('Finished half test generation\n');

