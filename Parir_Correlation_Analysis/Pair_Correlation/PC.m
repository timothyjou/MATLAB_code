%% Main function to call Pair Correlation. 
%allow the selection of Pearson,overlap, k-overlap, Mander's, or Li's
%correlation

%%input for red and covnert to binary
[redFName, redFFolder] = uigetfile('G:\.tif', 'Select a red tiff file for correlation analysis');
redFPath = fullfile(redFFolder, redFName);
redRaw = importdata(redFPath);
red = reshape(redRaw,1,[]);
fprintf('Loaded: red tiff file. \n');

%% input for green and convert to binary
[greenFName, greenFFolder] = uigetfile('G:\.tif', 'Select a green tiff file for correlation analysis');
greenFPath = fullfile(greenFFolder, greenFName);
greenRaw = importdata(greenFPath);
green = reshape(greenRaw, 1, []);
fprintf('Loaded: green tiff file. \n');

%%which Correlation method to use
x = input('Which Correlation method would you like to use?\n [p] for Pearson , [l] for Lis method, [o] for overlap,[k] for k-overlap, or [m] for Manders Correlation:\n:','s');
switch x
    case 'p'
        redBin = tiffToBinary(red);
        greenBin = tiffToBinary(green);
        pairCorr = pearsonCorr(redBin,greenBin);
        fprintf('The Pearson Correlation of red and green images is %3.4f\n',pairCorr);
    case 'o'
        redBin = tiffToBinary(red);
        greenBin = tiffToBinary(green);
        pairCorr = overlapCorr(redBin,greenBin);
        fprintf('The Overlap Correlation of red and green images is %3.4f\n',pairCorr);
        
    case 'k'
        redBin = tiffToBinary(red);
        greenBin = tiffToBinary(green);
        pairCorr = koverlapCorr(redBin,greenBin);
        fprintf('The k-Overlap Correlation of red and green images is %3.4f\n',pairCorr);
    case 'm'
        [pairCorrRed, pairCorrGreen] = mandersCorr(red,green);
        fprintf('The Manders Correlation of red and green images is %3.4f, %3.4f\n',pairCorrRed, pairCorrGreen);
    case 'l'
        pairCorr = liCorr(red,green);
        fprintf('The Lis Method Correlation of red and green image is %3.4f\n',pairCorr);
    otherwise 
        fprintf('ERROR occurred!!!!');
end

        
        
        
        
        