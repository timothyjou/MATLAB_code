%%Modded the Rip_hop_test_mode.m file to allow multiple 3dlp to be cropped and print Hopkins output(mean, 25%, 50%, 75%)
%%to csv in the same folder as the original dlp.
%%Rip_hop_modification: allow multiple inputs and export mean, 25%, 50%, 75% quantile as .csv file
%% User's inputs
clear al2
clc
%select multiple 3dlp for cropping
[listOfDlp, listOfDlpPath] = uigetfile('G:\.3dlp', 'Select a 3dlp file for cropping', 'MultiSelect', 'on');
if ~iscell(listOfDlp)
    listOfDlp = cellstr(listOfDlp);
end
testptH = 5; % number of test points for each repeat for Hopkins
repeatH = 1000; % more repeats, the better
maxr = 250; % maximum radius for Ripley (the x-axis ranges from 0 to maxr)
numr = 50; % total # points per curve for Ripley
repeatR = 10;
testptR = 500; % number of test points for each repeat for Ripley
listOfxy4Hop= {}; %cell array containing the[x,y] of each .3dlp

%% Going through the list of DLP and ask User to crop all of .3dlp, and stored [x,y] of each .3dlp
% in listOfxy4Hop cell array.
sizeOfLOD = max(size(listOfDlp));
for i = 1:sizeOfLOD
    disp(strcat('Reading file', listOfDlp{i}));
    %%reading .3dlp
    path_3dlp = fullfile(listOfDlpPath, listOfDlp{i});
    input = importdata(path_3dlp);
    xy_data = input(:,1:2);
    x_min = min(xy_data(:,1))-1;
    y_min = min(xy_data(:,2))-1;
    x0 = round(xy_data(:,1) - x_min);
    y0 = round(xy_data(:,2) - y_min);
    
    %% Crop
    f1 = figure;
    m = horzcat(x0,y0);
    m1 = unique(m,'rows');
    x1 = m1(:,1);
    y1 = m1(:,2);
    scatter(x1,y1,10);
    title(['scatterplot for ',listOfDlp{i},' original'],'FontSize',20,'interpreter','none')
    %path_out = fullfile(output_folder,[label,'_scatterplot']);
    %saveas(f1,path_out,'tif');
    while true
        disp(['When you crop, keep in mind that you need at least ',num2str(testptR),' data points for Ripley.']);
        [x,y] = cutrec_2(x1,y1); % Crop a desired rectangle
        if length(x) >= testptR,break,end
        disp(['You only chose ',num2str(length(x)),' points.'])
    end
    xy4Hop = [x,y];
    listOfxy4Hop{i} = xy4Hop;
end

%% Go through the listOfxy4Hop (containing [x,y] of each 3dlp), and do Hopkins' analysis,
% and the value of Mean, 25%, 50%, 75% quantiles are stored in ...._hop.csv
sizeOfxyHop = max(size(listOfxy4Hop));
for i = 1: sizeOfxyHop
    % Hopkins
    bin = 100;
    H = Hop_2(listOfxy4Hop{i}(:,1),listOfxy4Hop{i}(:,2),min(listOfxy4Hop{i}(:,1)),max(listOfxy4Hop{i}(:,1)),min(listOfxy4Hop{i}(:,2)),max(listOfxy4Hop{i}(:,2)),testptH,repeatH);
    disp('Finished calculating Hopkins');
    Hmean = ['\fontsize{13}','mean = ',num2str(mean(H))];
    Hquant = ['\fontsize{13}','25%, 50%(median), 75% quantiles = ',num2str(quantile(H,[0.25,0.5,0.75]))];
    f2 = figure;
    [f,t] = hist(H,linspace(0,1,bin));
    bar(t,f*bin/repeatH);
    xlim([0,1])
    text(0.01,0.95,Hquant,'Units', 'normalized')
    text(0.01,0.9,Hmean,'Units', 'normalized')
    title(['Hopkins for ',listOfDlp{i},' with ',num2str(testptH),' test points, ',num2str(repeatH),' repeats'],'FontSize', 20,'interpreter','none')
    
    %%print Hopkins output to csv as mean, 25%, 50%, 75%  %MOD by tim
    summary_stat = [mean(H), quantile(H,[0.25,0.5,0.75])];
    %filename = strcat(label(1:end-5),'.csv');
    %filename = strcat (listOfDlp{i}(1:end-8),'hop.csv');
    content = strcat(listOfDlp{i}(1:end-5),',',num2str(summary_stat(1)),',',num2str(summary_stat(2)),',',num2str(summary_stat(3)),',', num2str(summary_stat(4)));
    dlmwrite(fullfile(listOfDlpPath,'Hop_file.csv'),content,'delimiter','','-append');
end




% % Ripley's
% b = zeros(repeatR,numr);
% k = linspace(0,maxr,numr);
% a = Ripknoedge_2(x,y,min(x),max(x),min(y),max(y),testptR,repeatR,maxr,numr,x1,y1);
% disp('Finished calculating Ripley');
% for i = 1:numr
%     b(:,i) = (a(:,i)./pi).^(0.5) - (i-1)*maxr/numr;
% end
% f3 = figure;
% plot(k,b','b-',k,0*k,'r-',k,mean(b),'g-')
% title(['Ripley H for ',label,' with ',num2str(testptR),' testpoints, ',num2str(repeatR),' repeats'],'FontSize', 20,'interpreter','none')
% disp('Finished!');
