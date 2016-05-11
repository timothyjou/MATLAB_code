%% Enable the user to select 1 3dlp file + multiple .box files(coordinates) in order to automate the cropping
%from 3dlp.
%note that the visboxmod.m should be run first to convert the .box to .txt with correct 3rd and 4th column
clear all; close all; clc;
% input  = dlp and box
% prompt user to select dlp and load dlp
[dlpFName, dlpFFolder] = uigetfile('G:\.3dlp', 'Select a 3dlp file for cropping');
% prompt user to select box files 
[listOfTxt, listOfTxtPath] = uigetfile(':\.txt', 'Select the .txt file(s) corresponding to the 3dlp', 'MultiSelect', 'on');  

% Load dlp
fprintf('Loading:  3dlp file. \n');
dlpFPath = fullfile(dlpFFolder, dlpFName);
dlp = load(dlpFPath);
fprintf('Loaded:   3dlp file. \n');


% Load box
if ~iscell(listOfTxt)
    listOfTxt = cellstr(listOfTxt);
end
sizeOfLOT = max(size(listOfTxt));
fprintf('Loaded:   .txt file(s). \n');

% assign x_dlp as the entire 1st column of the dlp file
x_dlp = dlp(:,1);    
% assign y_dlp as the enitre 2nd column of the dlp file
y_dlp = dlp(:,2);

% for each .txt file, generate a 3dlp file
for i = 1:sizeOfLOT
    fprintf('started %d txt file\n', i);
    % load each box file assign box file values to x1, x2, y1, y2
    txtFPath = fullfile(listOfTxtPath, listOfTxt{i});   
    box = load(txtFPath);                     
    %make sure x2 and y2 are upper bound(max), and x1 and y1 are lower
    %bound(min, and convert to correct units. (in nm)
    txt_x1 = min(box(1,1),box(1,2))*1e3;           txt_x2 = max(box(1,1),box(1,2))*1e3;   
    txt_y1 = min(box(1,3),box(1,4))*1e3;           txt_y2 = max(box(1,3),box(1,4))*1e3;
           
    % create a size(x) by 1 matrix consisting of False - box_x
    box_x = false(size(x_dlp));   
    % create a size(y) by 1 matrix consisting of False - box_y
    box_y = false(size(y_dlp));
    % create a size(x) by 1 matrix consisting of False - box_xy
    box_xy = box_x; %false(size(x_dlp));
    % if x_dlp is within x1,x2, then assign true to the particular
    %element in box_x
    box_x(x_dlp > txt_x1 & x_dlp < txt_x2) = true;
    % if y_dlp is within y1,y2, then assign true to the particular
    %element in box_y
    box_y(y_dlp > txt_y1 & y_dlp < txt_y2) = true;
    % compare box_x and box_y and store the AND result in box_xy
    box_xy = box_x & box_y;
    % make a new file called dlpname_txtname.3dlp
    cropDlpFName = [dlpFName(1:6),'_',listOfTxt{i}(1:end-4),'.3dlp'];
    cropDlpFPath = fullfile(dlpFFolder, cropDlpFName);
    % write to the dlp file by fetching the rows that are within the
    %x1,x2,y1,y2 boundary(with 8 elements)
    dlp_out = dlp(box_xy, 1:end); 
    %save the cropped dlp as OriginalName_TxtName.3dlp in ascii
    save(cropDlpFPath, 'dlp_out', '-ascii');
    fprintf('Finished %d txt file\n', i);
    %figure;
    %plot(dlp_out(:,1), dlp_out(:,2), '.r');
end




