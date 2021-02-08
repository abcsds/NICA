function [optodeFailureCell,status] = consideroptodefailure(nrChannels)

    optodeFailureCell = [];
    status = 0;
    
    msgbox(['Each failed Channel must have a set of Channels to interpolate the failed Channel. ' ...
            'E.g.: Failed Channels = "3,5"; Channels to interpolate = "1-17,17-21". Channel 3 will be interpolated ' ...
            'with the Channels 1-17, Channel 5 with 17-21.'], 'Help Consider Optode Failure'); 
    uiwait;
    prompt = {'Failed Channels (e.g.: 3,5)', ...
              'Channels to interpolate (e.g.: 1-17,17-21)'};
    dlg_title = 'Consider Optode Failure';
    num_lines = 1;
    answer = inputdlg(prompt,dlg_title,num_lines);

    if isempty(answer)
        return
    else
        selected1 = answer{1};
        selected2 = answer{2};  

        if isempty(selected1) && isempty(selected2)
            return
        elseif isempty(selected1) && ~isempty(selected2)
            errordlg('You also have to enter the failed Channel(s)!');
            return
        elseif isempty(selected2) && ~isempty(selected1)
            errordlg('You also have to enter the Channels to interpolate!');
            return
        end
        
        try
            findComma1 = strfind(selected1,',');
            if ~isempty(findComma1)
                str = '%f';
                for i = 1:length(findComma1)
                    str = [str ',%f'];
                end
                numbers1 = sscanf(selected1,str,[1,inf]);
            else
                numbers1 = str2double(selected1);
            end
            if max(numbers1) > nrChannels
                errordlg('Your Input is bigger than the Number of Channels');
                return
            end
            
            findComma2 = strfind(selected2,',');
            if ~isempty(findComma2)
                str = '%f-%f';
                for i = 1:length(findComma2)
                    str = [str ',%f-%f'];
                end
                numbers2 = sscanf(selected2,str,[1,inf]);
            else
                str = '%f-%f';
                numbers2 = sscanf(selected2,str,[1,inf]);
            end
            if max(numbers2) > nrChannels
                errordlg('Your Input is bigger than the Number of Channels');
                return
            end

            if length(numbers1)*2 ~= length(numbers2)
                errordlg('Number of failed Channels is not equal to Number of Sets to interpolate with!');
                return
            end
            
            optodeFailureCell = cell(1,length(numbers1));
            for i = 1:length(numbers1)
                optodeFailureCell{i} = {numbers1(i); [numbers2(i*2-1), numbers2(i*2)]};
            end
            
            status = 1;
        catch ME
            errordlg(['Consider the Input Example! ' ME.message]);
            return
        end
    end