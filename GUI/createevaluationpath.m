function [analysisPath,filename] = createevaluationpath(settings,data)

    filepath = [data.analysisPathMain filesep 'Analysis'];
    
    if length(data.xdf.selected) == 1
        if iscell(data.xdf.name)
            filename = data.xdf.name{data.xdf.selected};
        else
            filename = data.xdf.name;
        end
        filename = strrep(filename,'.xdf','');
    else
        filename = data.xdf.name{data.xdf.selected(1)};
        filename = strrep(filename, '.xdf','');
        for i = 2:length(data.xdf.selected)
            filename2 = data.xdf.name{data.xdf.selected(i)};
            filename2 = strrep(filename2, '.xdf','');
            filename = [filename '_' filename2(end)];
        end
        
    end
    
    xdfPath = data.xdf.path;
    folderIndex = strfind(xdfPath,'\');
    folderStart = xdfPath(folderIndex(end-1)+1:folderIndex(end)-1);
    foldername = [folderStart filesep filename];
    task = settings.taskName;
    condition = settings.imageClass.string;

    if strcmp(condition,'Default')
        filename = [filename '_' task];
        analysisPath = [filepath filesep foldername];
    else
        filename = [filename '_' task '_' condition];
        analysisPath = [filepath filesep foldername filesep condition];
    end
    
    % Erzeuge Analysefolder
    if ~exist(analysisPath,'dir')
        try
            mkdir(analysisPath);
        catch ME
            errordlg(ME.message,'Analysis Path Error');
            analysisPath = [];
        end
    end

end