%% Convert the .box files into .txt files and change the sign of 3rd and 4th column to positive.
% Get multiple .box file from the folder and store as list of box
%the path for the list of box is stored in listofboxpath
[listOfBox, listOfBoxPath] = uigetfile(':\.box', 'Select multiple .box file', 'MultiSelect', 'on');
if ~iscell(listOfBox)
    listOfBox = cellstr(listOfBox);
end
sizeOfLOB = max(size(listOfBox)); 

%%loop through the list of .box file and make a new .txt file with CD
%%column * -1
for i = 1:sizeOfLOB
    
    boxFPath = fullfile(listOfBoxPath, listOfBox{i});   %load the box file
    box = load(boxFPath);
    
    txtFName = [listOfBox{i}(1:end-3), 'txt'];                
    txtFPath = fullfile(listOfBoxPath,txtFName);
    txtFID = fopen(txtFPath, 'w');
    fprintf(txtFID, '%7.6f \t %7.6f \t %7.6f \t %7.6f', box(1,[1,2]),box(1,[3,4])*-1); %% flip 3rd and 4th column
    fclose(txtFID);
    fprintf(strcat(txtFName,' is finished\n'));
end
