function [status,filename] = savesettings(settings,directory,mode,filename)

    status = 2;
    filepath = [directory filesep 'User Settings'];

    if ~exist(filepath,'dir')
        mkdir(filepath);
    else
        if isempty(filename)
            mode = 1;
        end
    end

    if mode
        falseInput = 1;
        
        while falseInput
            input = inputdlg('Please enter a name for your settings-file:', 'Save Settings');
            if isempty(input)
                status = 0;
                return
            elseif isempty(input{1})
                errordlg('You have to enter a valid filename!', 'Filename Error');
                uiwait;
            elseif exist([filepath filesep input{1} '.mat'],'file')
                response = questdlg('Filename already exists. Do you want to overwrite it?','Save Settings','Yes','No','No');
                if strcmp(response,'Yes')
                    falseInput = 0;
                end
            else
                falseInput = 0;
            end
        end

        filename = input{1};
    else
        filename = strrep(filename,'.mat','');
    end
    
    try
        save([filepath filesep filename '.mat'], 'settings');
        status = 1;
    catch ME
        errordlg(ME.message,'Saving User Settings Error');
    end

end