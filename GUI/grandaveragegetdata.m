function [nirxAll,nirx,fileCell,status] = grandaveragegetdata(evalPath)

status = 0;
nirxAll = [];
nirx = [];

FileName = 1;
counterVar = 0;
fileCell = cell(1,2);
fileCellTemp = cell(1,2);

selectString1 = 'Select the Data-Files (finish Selection with Cancel). ';
selectString2 = 'First File';

while FileName ~= 0
    counterVar = counterVar + 1;
        
    [FileName,PathName] = uigetfile('*.mat',[selectString1 selectString2],evalPath);
    
    selectString2 = ['Last File: ' FileName];
    if FileName ~= 0
        if counterVar == 1
            fileCell{1,2} = FileName;
            fileCell{1,1} = PathName;
        else
            fileCellTemp{1,2} = FileName;
            fileCellTemp{1,1} = PathName;
            fileCell = [fileCell; fileCellTemp];
        end
    end  
end

if counterVar == 1
    return
elseif counterVar == 2
    errordlg('You need to select at least 2 Data-Files!');
    return
else
    nirxAll = cell(size(fileCell,1),1);
    
    for i = 1:size(fileCell,1)
        
        load([fileCell{i,1} fileCell{i,2}]);
        
        nirxAll{i}.head_oxy       = NIRx.Data.AVGOxy;
        nirxAll{i}.head_deoxy     = NIRx.Data.AVGDeoxy;
        nirxAll{i}.head_oxy_std   = NIRx.Data.AVGOxySTD;
        nirxAll{i}.head_deoxy_std = NIRx.Data.AVGDeoxySTD;
        nirxAll{i}.head_oxy_con   = NIRx.Data.AllTrialsOxyContinuous;
        nirxAll{i}.head_deoxy_con = NIRx.Data.AllTrialsDeoxyContinuous;
        nirxAll{i}.oxy_Hb         = NIRx.Data.oxy_Hb;
        nirxAll{i}.deoxy_Hb       = NIRx.Data.deoxy_Hb;
        nirxAll{i}.fs             = NIRx.settings.fs;
        
        clear NIRx;
    end
    
    AVGOxy                   = zeros(size(nirxAll{1}.head_oxy));
    AVGDeoxy                 = zeros(size(nirxAll{1}.head_deoxy));
    AVGOxySTD                = zeros(size(nirxAll{1}.head_oxy_std));
    AVGDeoxySTD              = zeros(size(nirxAll{1}.head_deoxy_std));
    AllTrialsOxyContinuous   = zeros(size(nirxAll{1}.head_oxy_con));
    AllTrialsDeoxyContinuous = zeros(size(nirxAll{1}.head_deoxy_con));
    
    for ch = 1:size(AVGOxy,2)
        head_oxy_all       = [];
        head_deoxy_all     = [];
        head_oxy_std_all   = [];
        head_deoxy_std_all = [];
        head_oxy_con_all     = [];
        head_deoxy_con_all   = [];
        
        for i = 1:size(fileCell,1)
            head_oxy       = nirxAll{i}.head_oxy(:,ch);
            head_deoxy     = nirxAll{i}.head_deoxy(:,ch);
            head_oxy_std   = nirxAll{i}.head_oxy_std(:,ch);
            head_deoxy_std = nirxAll{i}.head_deoxy_std(:,ch);
            head_oxy_con   = nirxAll{i}.head_oxy_con(:,ch);
            head_deoxy_con = nirxAll{i}.head_deoxy_con(:,ch);
            
            head_oxy_all       = [head_oxy_all; head_oxy'];
            head_deoxy_all     = [head_deoxy_all; head_deoxy'];
            head_oxy_std_all   = [head_oxy_std_all; head_oxy_std'];
            head_deoxy_std_all = [head_deoxy_std_all; head_deoxy_std'];
            head_oxy_con_all   = [head_oxy_con_all; head_oxy_con']; 
            head_deoxy_con_all = [head_deoxy_con_all; head_deoxy_con']; 
        end
        
        AVGOxy(:,ch)                   = mean(head_oxy_all);
        AVGDeoxy(:,ch)                 = mean(head_deoxy_all);
        AVGOxySTD(:,ch)                = mean(head_oxy_std_all);
        AVGDeoxySTD(:,ch)              = mean(head_deoxy_std_all);
        AllTrialsOxyContinuous(:,ch)   = mean(head_oxy_con_all);
        AllTrialsDeoxyContinuous(:,ch) = mean(head_deoxy_con_all);
    end
    
    nirx.Data.AVGOxy                   = AVGOxy;
    nirx.Data.AVGDeoxy                 = AVGDeoxy;
    nirx.Data.AVGOxySTD                = AVGOxySTD;
    nirx.Data.AVGDeoxySTD              = AVGDeoxySTD;
    nirx.Data.oxy_Hb                   = nirxAll{1}.oxy_Hb;
    nirx.Data.deoxy_Hb                 = nirxAll{1}.deoxy_Hb;
    nirx.Data.AllTrialsOxyContinuous   = AllTrialsOxyContinuous;
    nirx.Data.AllTrialsDeoxyContinuous = AllTrialsDeoxyContinuous;
    
    fs_all = [];
    for i = 1:size(fileCell,1)
        fs_all = [fs_all,nirxAll{i}.fs];
    end
    nirx.settings.fs = mean(fs_all);
    
    status = 1;
end

%-----------------------------------------------------------------------------------------------------------------------
sizeMatrix = zeros(size(fileCell));

for i = 1:size(fileCell,1)
    sizeMatrix(i,1) = length(fileCell{i,1});
    sizeMatrix(i,2) = length(fileCell{i,2});
end

max1 = max(sizeMatrix(:,1));
max2 = max(sizeMatrix(:,2));

for i = 1:size(fileCell,1)
    if length(fileCell{i,1}) < max1
        diff = max1 - length(fileCell{i,1});
        for j = 1:diff
            fileCell{i,1} = [fileCell{i,1} ' '];
        end
    end
        
    if length(fileCell{i,2}) < max2
        diff = max2 - length(fileCell{i,2});
        for j = 1:diff
            fileCell{i,2} = [fileCell{i,2} ' '];
        end
    end
end

