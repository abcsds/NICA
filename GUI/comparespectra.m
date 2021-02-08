function NIRx = comparespectra(NIRx,settings,data) 
    %%%%%%%%%%%%%%%%%%%%%
    %%%Spectra Compare%%%
    %%%%%%%%%%%%%%%%%%%%%    
    disp('Spectra compare start');
    
    fs = NIRx.hdr.SamplingRate{1};
    Task = settings.taskName;
    ImageClass = settings.imageClass.string;
    trig = NIRx.trigger;
    oxy_signal = NIRx.Data.Concentration.clean.oxy;
    deoxy_signal = NIRx.Data.Concentration.clean.deoxy;
    
    font_size = 16;

    if settings.generateFiguresRAW 
        % Comparison raw and cleaned
        hSpectraCompare = figure;
        % [oxy-Hb] raw
        p1 = NIRx.Data.Spectra.raw(:,1);
        f1 = NIRx.Data.Spectra.Base;
        Color=[1 0.6 0.6];
        idx = find(f1<=settings.displayFrequency);
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',2);
        hold on
        % [deoxy-Hb] raw
        p1 = NIRx.Data.Spectra.raw(:,2);
        Color=[0.8 0.8 1];
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',2);
        % [oxy-Hb] clean
        p1 = NIRx.Data.Spectra.cleaned(:,1);
        Color='r';
        idx = find(f1<=settings.displayFrequency);
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',2);
        % [deoxy-Hb] clean
        p1 = NIRx.Data.Spectra.cleaned(:,2);
        Color='b';
        grid on;
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',2);        
        ylabel('Power spectrum (dB)','FontSize',16,'FontWeight','bold')
        xlabel('f (Hz)','FontSize',16,'FontWeight','bold')
        try
            xticks(0:0.1:settings.displayFrequency);
        catch
            set(gca,'xtick',0:0.1:settings.displayFrequency);
        end
        title('Avg. Spectrum [(de)oxy-Hb] before and after physiological influence removal' ,'FontSize',12,'FontWeight','bold','Interpreter','none')
        legend('[oxy-Hb]_r_a_w','[deoxy-Hb]_r_a_w','[oxy-Hb]_c_l_e_a_n','[deoxy-Hb]_c_l_e_a_n')
        set(gca,'FontSize',font_size);
        
        if settings.correctionMode.value == 1
    %         print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_CLEAN_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(hSpectraCompare, [data.analysisPath filesep data.analysisFilename '_Spectra_Compared',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        else
    %         print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_CLEAN_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
            saveas(hSpectraCompare, [data.analysisPath filesep data.analysisFilename '_Spectra_Compared',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
        end
    end

    %Kanalschleife
    head_oxy=[];
    head_deoxy=[];

    t=1/fs:1/fs:length(deoxy_signal)/fs;

    SollAktivierung = zeros(size(deoxy_signal,1),1)*0;
    for i = 1 : length(trig)
        [idx idx] = min(abs(NIRx.Time.NIRS - trig(i)));
        
        if idx + round(settings.timing.signal*fs) <= length(t)
            SollAktivierung(idx+[round(0*fs):round(settings.timing.signal*fs)])=1;
        end
    end
    clear i;

    NIRx.Data.AllTrialsOxyContinuous = [];
    NIRx.Data.AllTrialsDeoxyContinuous = [];

    for i=1:1:size(oxy_signal,2)
        %Verlaufplot
        verlaufNIRx(oxy_signal(:,i), deoxy_signal(:,i),NIRx, settings, t, SollAktivierung, fs, i, data, Task, ImageClass);

        %Mittelung
        [dat_avg, dat_std, t_trial, data_all_trials]=mittelungNIRx([oxy_signal(:,i) deoxy_signal(:,i)],NIRx, settings, trig, fs);

        head_oxy(:,i)=dat_avg(:,1);
        head_deoxy(:,i)=dat_avg(:,2); 
        head_oxy_std(:,i)=dat_std(:,1);
        head_deoxy_std(:,i)=dat_std(:,2); 

        NIRx.Data.AllTrialsOxy{i}(:,:)= data_all_trials(:,1,:);
        NIRx.Data.AllTrialsDeoxy{i}(:,:)= data_all_trials(:,2,:);
        
        for j = 0:size(data_all_trials,3)-1
            dataOxy = data_all_trials(:,1,j+1)';
            dataDeoxy = data_all_trials(:,2,j+1)';
            stepsize = floor(size(data_all_trials,1)/10);
            for k = 0:9
                dataOxyAv(k+1) = mean(dataOxy(k*stepsize+1:k*stepsize+stepsize));
                dataDeoxyAv(k+1) = mean(dataDeoxy(k*stepsize+1:k*stepsize+stepsize));
            end
            
            NIRx.Data.AllTrialsOxyContinuous(j*size(dataOxyAv,2)+1:j*size(dataOxyAv,2)+size(dataOxyAv,2),i) = dataOxyAv;
            NIRx.Data.AllTrialsDeoxyContinuous(j*size(dataDeoxyAv,2)+1:j*size(dataDeoxyAv,2)+size(dataDeoxyAv,2),i) = dataDeoxyAv;
        end
        
        NIRx.Data.AllTrialsOxyContinuous(:,i) = smooth(NIRx.Data.AllTrialsOxyContinuous(:,i));
        NIRx.Data.AllTrialsDeoxyContinuous(:,i) = smooth(NIRx.Data.AllTrialsDeoxyContinuous(:,i));
        
        i=i+1;
    end
    clear i;


    %Optodenfehler eliminieren
    [head_oxy, head_deoxy, head_oxy_std, head_deoxy_std]=OptodenfehlerNIRx(head_oxy, head_deoxy, head_oxy_std, head_deoxy_std, NIRx, settings);

    % Exclude Channels
    if settings.excludeChannels
        channels = find(settings.channels.exclude == 1);
        for ch = 1:length(channels)
            head_oxy(:,channels(ch)) = 0;
            head_deoxy(:,channels(ch)) = 0;
            head_oxy_std(:,channels(ch)) = 0;
            head_deoxy_std(:,channels(ch)) = 0;
        end
    end
    
    NIRx.Data.AVGOxy=head_oxy;
    NIRx.Data.AVGDeoxy=head_deoxy;
    NIRx.Data.AVGOxySTD=head_oxy_std;
    NIRx.Data.AVGDeoxySTD=head_deoxy_std;
    NIRx.settings.t_trial=t_trial;
    NIRx.settings.fs=fs;
    NIRx.Data.oxy_Hb = oxy_signal;
    NIRx.Data.deoxy_Hb = deoxy_signal;

    disp('Spectra compare finished')
    
