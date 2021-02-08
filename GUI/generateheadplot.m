function NIRx = generateheadplot(NIRx,settings,data,status)

    %%%%%%%%%%%%%%%%%%%%%%%
    %%%%%DARSTELLUNG%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%        
    
    switch settings.signal.value
        case 1  % Averaging
            head_oxy       = NIRx.Data.AVGOxy;
            head_deoxy     = NIRx.Data.AVGDeoxy;
            t_trial        = NIRx.settings.t_trial;
        case 2  % Continuously
            head_oxy       = NIRx.Data.AllTrialsOxyContinuous;
            head_deoxy     = NIRx.Data.AllTrialsDeoxyContinuous;
            t_trial        = 1:size(head_oxy,1);
            t_trial        = t_trial * length(settings.imageClass.list) / 60; % * nr. conditions / convert to minutes
    end
    
    head_oxy_std   = NIRx.Data.AVGOxySTD;
    head_deoxy_std = NIRx.Data.AVGDeoxySTD;
    fs             = NIRx.settings.fs;
%     oxy_signal     = NIRx.Data.oxy_Hb;
%     deoxy_signal   = NIRx.Data.deoxy_Hb;
    
    %Darstellung mittel neu (optodenfehler)
    if settings.generateFiguresBloodOxy
        for c=1:1:size(head_oxy,2)
            ni=figure(100);
            orient landscape;
            darstellungNIRxsigma(c,head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,settings,t_trial,fs, data, status,head_oxy(:,c),head_deoxy(:,c));
            set(ni,'Name','Average of Channels 1-61 ','NumberTitle','off');
            set(ni,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        end
        clear c;
        
        if status.grandAverage
            saveas(ni, [data.analysisPath filesep data.analysisFilename '_Channels_Average'],'fig');
        else
            if settings.correctionMode.value == 1
        %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Mittelung_der_Kanaele',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
                saveas(ni, [data.analysisPath filesep data.analysisFilename '_Channels_Average',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
            else
        %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Mittelung_der_Kanaele',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
                saveas(ni, [data.analysisPath filesep data.analysisFilename '_Channels_Average',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
            end
        end
        
        try
            jFrame = get(handle(ni),'JavaFrame');
            pause(0.1)  %//This is important
            jFrame.setMinimized(true);
        catch
            set(ni, 'Visible', 'off');
        end
        
    end
    
    if ~status.grandAverage 
        %%%sichern für classifikation
%         NIRx.Data.oxy_Hb=oxy_signal;
%         NIRx.Data.deoxy_Hb=deoxy_signal;

        NIRx.Data.UserSettings = settings;

        %Daten sichern
        if settings.correctionMode.value == 1
            save ([data.analysisPath filesep data.analysisFilename '_NIRx_Data', NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode, '.mat'],'NIRx')
        else
            save ([data.analysisPath filesep data.analysisFilename '_NIRx_Data', NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode, '.mat'],'NIRx')
        end
    end
    
    
    %TopoPlot
    if settings.generateFiguresTopoplot
        topoplotsSingle = 0; % 0: one figure for all topoplots 
        NIRxplothead
    end

    disp('Calculation finished');
end