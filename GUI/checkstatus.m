function checkstatus(status,pushbuttonStartAnalysis,textAnalysisStatus)
    
    if status.grandAverage
        if status.analysisPath
            set(textAnalysisStatus, 'String', 'Ready to start Grand Average');
            set(pushbuttonStartAnalysis, 'Enable', 'On');
        else
            set(textAnalysisStatus, 'String', 'Select an Analysis Path');
            set(pushbuttonStartAnalysis, 'Enable', 'Off');
        end
    else
        if status.xdf && status.hdr && status.analysisPath
            set(textAnalysisStatus, 'String', 'Ready to start Analysis');
            set(pushbuttonStartAnalysis, 'Enable', 'On');
        else
            set(pushbuttonStartAnalysis, 'Enable', 'Off');
            if status.xdf && status.hdr && ~status.analysisPath
                set(textAnalysisStatus, 'String', 'Select an Analysis Path');
            elseif ~status.xdf && ~status.hdr && status.analysisPath
                set(textAnalysisStatus, 'String', 'Load your Data-Files');
            elseif ~status.xdf && ~status.hdr && ~status.analysisPath
                set(textAnalysisStatus, 'String', 'Select an Analysis Path and Load your Data-Files');
            end
        end
    end
end