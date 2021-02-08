function saveoutputtotxtfile(Tcell,data)

    TcellVCat = [];

    for i = 1:length(Tcell)
        TcellVCat = strvcat(TcellVCat,Tcell{i});
    end

    dlmwrite([data.analysisPath filesep data.analysisFilename '_Text_Output.txt'],TcellVCat,'delimiter','');
    
end