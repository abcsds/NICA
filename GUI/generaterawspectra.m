function NIRx = generaterawspectra(NIRx, settings, data)

    %%%%%%%%%%%%%%%%%
    %%%RAW Spectra%%%
    %%%%%%%%%%%%%%%%%
    disp('RAW Spectra start');
    spect=[];
    count=1;
    fs = NIRx.hdr.SamplingRate{1};
    Task = settings.taskName;
    ImageClass = settings.imageClass.string;
    ExCh = settings.channels.exclude;
    oxy_signal = NIRx.Data.Concentration.raw.oxy;
    deoxy_signal = NIRx.Data.Concentration.raw.deoxy;
    
    hRAW = figure;
    
    for ChNr=1:1:size(oxy_signal,2) 

        [rOxy, rDeoxy] = ...
            illustrationmultichannelspectra(ChNr, oxy_signal(:,ChNr), deoxy_signal(:,ChNr), fs, ...
                                            settings.displayFrequency, NIRx, settings, ExCh);

        if ~isempty(rOxy)
            spect(:,1,count)=rOxy{1}.p;
            spect(:,2,count)=rDeoxy{1}.p;
            count=count+1;
            NIRx.Data.Spectra.Base=rOxy{1}.f;
        end
    end
    clear ChNr;

    
%         gcf;
%         orient landscape;
    if settings.correctionMode.value == 1
%             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(hRAW, [data.analysisPath filesep data.analysisFilename '_Spectra_Raw',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    elseif settings.correctionMode.value == 8
%             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(hRAW, [data.analysisPath filesep data.analysisFilename '_Spectra_Raw',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    else
%             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
        saveas(hRAW, [data.analysisPath filesep data.analysisFilename '_Spectra_Raw',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
    end


    %Average [(de)oxy-Hb] spectra over all used channels
    NIRx.Data.Spectra.allChraw=spect;
    NIRx.Data.Spectra.raw=[];

    for k = 1 : size(spect,2)
        NIRx.Data.Spectra.raw(:,k)=mean(spect(:,k,:),3); 
    end
    clear k;
    disp('RAW spectra finished');

end
