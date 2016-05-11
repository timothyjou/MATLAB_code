%%Scipt by Timothy Jou January 26, 2016.
%%Conversion of .3dlp file to a format that can be recognized by SR_Tessler software
%% Get multiple .3dlp file from the folder and store as list of 3dlp files.
%%the path for the list of box is stored in listofboxpath
EMCCD_px = 106; % nm/px
[listOf3dlp, listOf3dlpFolder] = uigetfile(':\.3dlp', 'Select multiple 3dlp files for conversion', 'MultiSelect', 'on');
fprintf('Running.... please wait\n');
if ~iscell(listOf3dlp)
    listOf3dlp = cellstr(listOf3dlp);
end
sizeOfLO3 = max(size(listOf3dlp));

%% loop through the list of 3dlp files to copnvert to voronii
for i = 1 :sizeOfLO3
    %% get the path to 3dlp file and load it
    dlpFPath = fullfile(listOf3dlpFolder, listOf3dlp{i});
    dlp = load(dlpFPath);
    fprintf('Loaded: 3dlp file. \n');
    
    %% conversion and writing to new txt file
    visguiVarName = ['x' 'y' 'z' 'dx' 'dy' 'dz' 'A' 't'];
    visguiFName = [listOf3dlp{i}(1:end-5),'_vor','.txt'];
    visguiFPath = fullfile(listOf3dlpFolder, visguiFName); 
    visguiFID = fopen(visguiFPath, 'w');
    dlp_nRows = size(dlp,1);
    t_max = max(dlp(1:dlp_nRows,8)) + 10000;

    fprintf('Writing: ASCII file. \n');
    fprintf(visguiFID,'%d \t %d \n', t_max, dlp_nRows);

    for j = 1:dlp_nRows
         fprintf(visguiFID, '%7.4f \t %7.4f \t %6.1f \t %d \n', ...
         dlp(j,1)/EMCCD_px, dlp(j,2)/EMCCD_px, dlp(j,7), dlp(j,8));
    end 
    fclose(visguiFID);
    fprintf(strcat(visguiFName, ' is finished\n'));
end
fprintf('Conversion complete!! \n');
