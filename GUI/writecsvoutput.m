function status = writecsvoutput(oxy,deoxy,evalPath,evalFilename)

    status = 0;
    oxy   = oxy';
    deoxy = deoxy';
    
    filenameOxy   = [evalPath filesep evalFilename '_signal_oxy.xlsx'];
    filenameDeoxy = [evalPath filesep evalFilename '_signal_deoxy.xlsx'];

    oxyOutput   = zeros(size(oxy)+1);
    deoxyOutput = zeros(size(deoxy)+1);
    
    oxyOutput(2:end,2:end)   = oxy;
    deoxyOutput(2:end,2:end) = deoxy;

    oxyCell   = num2cell(oxyOutput);
    deoxyCell = num2cell(deoxyOutput);
    
    oxyCell{1,1}   = 'time (s)';
    deoxyCell{1,1} = 'time (s)';

    for i = 2:size(oxyCell,1)
        oxyCell{i,1}   = ['Ch' num2str(i-1)];
        deoxyCell{i,1} = ['Ch' num2str(i-1)];
    end

    for i = 2:size(oxyCell,2)
        oxyCell{1,i}   = i-1;
        deoxyCell{1,i} = i-1;
    end    

    try
        if ~exist(filenameOxy,'file')
            xlswrite(filenameOxy, oxyCell);
        end
        if ~exist(filenameDeoxy,'file')
            xlswrite(filenameDeoxy, deoxyCell);
        end
        status = 1;
        disp('Generating XLSX-Output successful!');
    catch ME
        disp(['Could not write xlsx-file! ' ME.message]);
    end
    
end


