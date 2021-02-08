function status = grandaverageoutputfile(nirxAll,nirx,settings,data)

Timing = [-settings.timing.pre (settings.timing.signal+settings.timing.post)];

timingSteps = round(Timing(2)/4); 
TimePointList = cell(5,1);

TimePointList{1} = [Timing(1) 0];
TimePointList{2} = [0 timingSteps];
TimePointList{3} = [timingSteps timingSteps*2];
TimePointList{4} = [timingSteps*2 timingSteps*3];
TimePointList{5} = [timingSteps*3 Timing(2)];

% # 8,15,18,28
% #17,18,19,20
% #12,19,22,32
% #28,29,30,31
% #32,33,34,35

% ROI = cell(4,1);
% 
% ROI{1}.channels = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 17, 21];
% ROI{2}.channels = [14, 15, 16, 18, 19, 22, 23, 25, 28, 20, 32, 24, 36, 26, 29, 30, 33, 34, 37];
% ROI{3}.channels = [27, 39, 31, 43, 35, 47, 38, 40, 41, 44, 45, 48, 49, 42, 51, 46, 55, 50];
% ROI{4}.channels = [52, 53, 56, 57, 54, 59, 58, 60, 61];

nrROIs = settings.grandAverage.nrROIs;
ROI = cell(nrROIs,1);

for i = 1:nrROIs
    [m,n] = size(settings.grandAverage.ROIs{i});
    if m > n
        ROI{i}.channels = settings.grandAverage.ROIs{i}';
    else
        ROI{i}.channels = settings.grandAverage.ROIs{i};
    end
end

% ROI{1}.channels = [2, 5, 6, 7, 8, 13];
% ROI{2}.channels = [14, 15, 18, 25, 16, 28, 26, 29, 30];
% ROI{3}.channels = [27, 39, 31, 40, 41, 44, 42, 51, 52, 53, 54];
% ROI{4}.channels = [3, 9, 10, 11, 12, 21];
% ROI{5}.channels = [19, 22, 23, 32, 24, 36, 33, 34, 37];
% ROI{6}.channels = [35, 47, 38, 45, 48, 49, 55, 57, 58];

TIME_POINTS = cell(length(TimePointList),1);
    
VPN = cell(length(nirxAll),1);

for proband = 1:length(nirxAll)
    
    head_oxy   = nirxAll{proband}.head_oxy;
    head_deoxy = nirxAll{proband}.head_deoxy;

    % Timing=NIRx.settings.Timing;
    T = (Timing(1):1/nirx.settings.fs:Timing(2)); % Time vector
    % Check if Time vector fits
    if length(T) > size(head_oxy,1)
        T = T(1:size(head_oxy,1));
    end
    
    for k = 1 : length(TimePointList)
        TimePoint=TimePointList{k};
        % Extract data for head
        MatValOxy   = zeros(size(head_oxy,2), 1);
        MatValDeOxy = zeros(size(head_deoxy,2), 1);
        if length(TimePoint)==2
            tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
        else
            tpidx = [min(find(T>TimePoint(1)))];
        end

        % hier berechnet er für jeden Channel für die Zeit, die betrachtet
        % wird, den Mittelwert für HbO
        for ch=1:size(head_oxy,2)
            MatValOxy(ch)=mean(head_oxy(tpidx,ch));
            MatValDeOxy(ch)=mean(head_deoxy(tpidx,ch));
        end

        MatValOxy(find(settings.channels.exclude == 1))=0;
        MatValDeOxy(find(settings.channels.exclude == 1))=0;

        TIME_POINTS{k}.oxy   = MatValOxy;
        TIME_POINTS{k}.deoxy = MatValDeOxy; 
    end

    for i = 1:length(ROI)
        channels = ROI{i}.channels;
        for k = 1:length(TIME_POINTS)
            ROI{i}.oxy{k}   = mean(TIME_POINTS{k}.oxy(channels));
            ROI{i}.deoxy{k} = mean(TIME_POINTS{k}.deoxy(channels));
        end
    end
    
    VPN{proband} = ROI;
end

outputOxy   = cell(length(VPN)+1,length(ROI)*length(TIME_POINTS)+1);
outputDeOxy = cell(length(VPN)+1,length(ROI)*length(TIME_POINTS)+1);

c = settings.imageClass.value;

for vpn = 1:length(VPN)
    col = 1;
    for roi = 1:length(VPN{vpn})
        for t = 1:length(VPN{vpn}{roi}.oxy)
            if col == 1
                outputOxy{vpn+1,col}   = ['VPN' num2str(vpn)]; 
                outputDeOxy{vpn+1,col} = ['VPN' num2str(vpn)]; 
            end
            col = col+1;
            if vpn == 1
                outputOxy{vpn,col}   = ['ROI' num2str(roi) '_C' num2str(c) '_t' num2str(t)]; 
                outputDeOxy{vpn,col} = ['ROI' num2str(roi) '_C' num2str(c) '_t' num2str(t)]; 
            end
            outputOxy{vpn+1,col}   = VPN{vpn}{roi}.oxy{t};
            outputDeOxy{vpn+1,col} = VPN{vpn}{roi}.deoxy{t};
        end
    end
end

filenameOxy   = [data.analysisPath filesep data.analysisFilename '_oxy.xlsx'];
filenameDeoxy = [data.analysisPath filesep data.analysisFilename  '_deoxy.xlsx'];

try
    if ~exist(filenameOxy,'file')
        xlswrite(filenameOxy, outputOxy);
    end
    if ~exist(filenameDeoxy,'file')
        xlswrite(filenameDeoxy, outputDeOxy);
    end
    status = 1;
    disp('Generating XLSX-Output successful!');
catch ME
    disp(['Could not write xlsx-file! ' ME.message]);
end

