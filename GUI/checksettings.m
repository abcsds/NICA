function status = checksettings(settings)

    % Set status by default to 1
    status = 1;

    % Get the names and the number of settings
    fieldNames = fieldnames(settings);
    nSettings  = numel(fieldNames);

    for i = 1:nSettings
        
        if strcmp(fieldNames{i},'mayerWavesRemoval') || strcmp(fieldNames{i},'respirationRemoval') || ...
                strcmp(fieldNames{i},'pulseRemoval')
            if isempty(settings.(fieldNames{i}).start) || isempty(settings.(fieldNames{i}).end) || ...
                    isempty(settings.(fieldNames{i}).interval)
                status = 0;
            end
        elseif strcmp(fieldNames{i},'timing')
            if isempty(settings.(fieldNames{i}).post) || isempty(settings.(fieldNames{i}).pre) || ...
                    isempty(settings.(fieldNames{i}).signal)
                status = 0;
            end        
        elseif isempty(settings.(fieldNames{i}))
            % If one entry is empty, set status to 0
            status = 0;
        end
    end

end
