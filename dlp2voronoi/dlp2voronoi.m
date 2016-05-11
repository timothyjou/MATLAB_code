%% dlp2visgui_SCh converts a single-channel 3dlp file into a .txt file appropriate for the input of Visgui.
%% get the path to 3dlp file and load it
%% took pixel density into account (EMCCD_px = 106;)
EMCCD_px = 106; %nm/px
[dlpFName, dlpFFolder] = uigetfile('G:\.3dlp', 'Select a 3dlp file for conversion');
dlpFPath = fullfile(dlpFFolder, dlpFName);
dlp = load(dlpFPath);
fprintf('Loaded: 3dlp file. \n');

%%  conversion and writing
visguiVarName = ['x' 'y' 'z' 'dx' 'dy' 'dz' 'A' 't'];
visguiFName = [dlpFName(1:end-5), '_vor', '.txt'];
visguiFPath = fullfile(dlpFFolder, visguiFName); 
visguiFID = fopen(visguiFPath, 'w');
dlp_nRows = size(dlp,1);
t_max = max(dlp(1:dlp_nRows,8)) + 10000;

fprintf('Writing: ASCII file. \n');
fprintf(visguiFID,'%d \t %d \n', t_max, dlp_nRows);

for i = 1:dlp_nRows
    fprintf(visguiFID, '%7.4f \t %7.4f \t %6.1f \t %d \n', ...
    dlp(i,1)/EMCCD_px, dlp(i,2)/EMCCD_px, dlp(i,7), dlp(i,8));
end 

fclose(visguiFID);
