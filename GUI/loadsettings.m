function [settings,filename] = loadsettings(directory)

    settings = [];
    pathUserSetting = [directory filesep 'User Settings'];

    if exist(pathUserSetting,'dir')
        pathTemp = pathUserSetting;
    else
        pathTemp = directory;
    end

    [filename,pathname] = uigetfile('*.mat','Please select your user setting file',pathTemp);   

    if ~pathname % Selection: Cancel
        return
    elseif isempty(strfind(filename,'.mat')) % Type of file is not mat
        warndlg('The file extension of the user settings must be ".mat"!', 'Wrong file type');
        return
    else % Selection was OK
        try
            input = load([pathname filename]);
        catch ME
            errordlg(ME.message,'Loading User Settings Error!');
            return
        end
        settings = input.settings;
    end

end