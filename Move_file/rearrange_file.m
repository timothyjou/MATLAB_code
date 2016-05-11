%% Rearrange the file in the selected folder by the specification givne in tests.
%% note that this code changes the selected folder directly, no copy is made.
directory = uigetdir('C:\', 'please select the folder for moving');
d1 = dir(directory);
runs = 0;

for i = 1: max(size(d1))
    for j = 1:max(size(d1))
        if(strcmp(d1(j).name, num2str(i)))
            runs = runs + 1;
        end
    end
end

subDir.r = fullfile(directory,'red'); 
mkdir(subDir.r);
subDir.g = fullfile(directory,'green'); 
mkdir(subDir.g);

for i = 1 : runs
     %list of tracking files
     trackingList = dir(fullfile(directory, num2str(i), 'Tracking_7508'));
     
     % make i th folder under "red", and move the corresponding data in 
     subDir.runR = fullfile(subDir.r, num2str(i));  
     mkdir(subDir.runR);
     redList = dir(fullfile(directory, num2str(i), 'Alexa647_7140'));
    
     for j = 3: max(size(redList))
     movefile(fullfile(directory,num2str(i),'Alexa647_7140', redList(j).name), subDir.runR);
     end
     
     % make i th folder under "Green", and move the corresponding data in 
     subDir.runG = fullfile(subDir.g, num2str(i)); 
     mkdir(subDir.runG);
     greenList = dir(fullfile(directory, num2str(i), 'Alexa532_6816'));
     
     for k = 3: max(size(greenList))
     movefile(fullfile(directory,num2str(i),'Alexa532_6816', greenList(k).name), subDir.runG);
     end
     
     %move tracking files into each i th folder in green and red
     for l = 3: max(size(trackingList))
     copyfile(fullfile(directory,num2str(i),'Tracking_7508', trackingList(l).name), subDir.runR);
     copyfile(fullfile(directory,num2str(i),'Tracking_7508', trackingList(l).name), subDir.runG);
     end
     movefile(fullfile(directory,num2str(i),'Tracking_7508'), subDir.runR);
     rmdir(fullfile(directory,num2str(i)),'s');
end


