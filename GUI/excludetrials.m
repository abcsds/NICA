function [excludeTrialsArray,status] = excludetrials(hObject,nrTrials)

    excludeTrialsArray = zeros(1,nrTrials);
    status = 0;
    
    prompt = {'Select single Trials (Input Example: 1,3,7)', ...
              'Select a group of Trials (Input Example: 9-13)'};
    dlg_title = 'Exclude Trials';
    num_lines = 1;
    answer = inputdlg(prompt,dlg_title,num_lines);

    if isempty(answer)
        value = 0;
        set(hObject, 'Value', value);
        return
    else
        selected1 = answer{1};
        selected2 = answer{2};

        if isempty(selected1) && isempty(selected2)
            value = 0;
            set(hObject, 'Value', value);
            return
        end
        
        try
            if ~isempty(selected1)
                findComma = strfind(selected1,',');
                if ~isempty(findComma)
                    str = '%f';
                    for i = 1:length(findComma)
                        str = [str ',%f'];
                    end
                    numbers1 = sscanf(selected1,str,[1,inf]);
                else
                    numbers1 = str2double(selected1);
                end
                if max(numbers1) > nrTrials
                    errordlg('Your Input is bigger than the Number of Trials');
                    return
                end
            else
                numbers1 = [];
            end

            if ~isempty(selected2)
                str = '%f-%f';
                numbers2 = sscanf(selected2,str,[1,inf]);
                numbers2 = numbers2(1):numbers2(2);
                if max(numbers2) > nrTrials
                    errordlg('Your Input is bigger than the Number of Trials');
                    return
                end
            else
                numbers2 = [];
            end

            numbers = [numbers1 numbers2];
            for i = 1:length(numbers)
                excludeTrialsArray(numbers(i)) = 1;
            end
            
            status = 1;
        catch ME
            errordlg([' Consider the Input Example! ' ME.message]);
            return
        end
    end