% Modified 16.02.2016 
% Bachmaier Dominik 
% Changes: Adapted to new version of NIRS setup including LSL recorder


function [oxy_signal, deoxy_signal,NIRx]=Corr_NIRx(oxy_signal, deoxy_signal, NIRx, D)
    %%%%neu für OF
    if NIRx.settings.OptodeFailure
        try
            OptodeFailure=D{1,1}.OptodeFailure;
            OFInk=1;
        catch MEOF
            OFInk=0;
        end

        if OFInk
            OFChSpectra=[];
            if ~isempty(OptodeFailure)
                for k = 1 : length(OptodeFailure)
                    OFChSpectra = [OFChSpectra OptodeFailure{k}{1}];
                end
            end
            oldExCh = NIRx.settings.ExCh
            NIRx.settings.ExCh=unique([NIRx.settings.ExCh OFChSpectra]);
        end
    end

    % temporary variables
    fs = round(NIRx.hdr.SamplingRate{1});
    BPfs = round(NIRx.hdr.BPSamplingRate);
    
    if NIRx.hdr.Bool.gUSBamp
        gUSBampfs = round(NIRx.hdr.gUSBampSamplingRate);
    end
    
    %%%%%%%%%%%%%%
    %Trigger_line% 
    %%%%%%%%%%%%%%
    no_upsample = 0;
    old = fs; % sampling rate NIRS
    if fs == 3
        no_upsample = 1;
        old = 3;
        fs = 6;
    end
    
    %%%%%%%%%%%%%
    %Puls signal%
    %%%%%%%%%%%%%
    puls_down = resample(NIRx.Data.BP,fs,BPfs);           %Downsampling

    %%%%%%%%%
    %Spectra%
    %%%%%%%%%
    rPuls=calcNIRSspectra(puls_down,fs);
    %display Puls spectra
    p1 = rPuls{1}.p;
    f1 = rPuls{1}.f;
    Color ='k';
    idx1 = find(f1 <= NIRx.settings.Puls(2));
    idx2 = find(f1 >= NIRx.settings.Puls(1));
    idx=intersect(idx1,idx2);
    figure
    plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
    hold on
    one_Pw_LF = diff(p1(idx));
    two_Pw_LF = diff(one_Pw_LF);
    [peakidx_puls] = findpeak(p1(idx), one_Pw_LF, two_Pw_LF);

    disp(' ')
    disp('Peak Puls (EF)[Hz]: ')
    FPeakPuls = f1(idx2(1)+peakidx_puls-1)
    NIRx.Data.Spectra.FPeakPuls=FPeakPuls;
    plot(f1(idx2(1)+peakidx_puls-1),10*log10(p1(idx2(1)+peakidx_puls-1)),'ro');
    close

    temppeak=round(FPeakPuls*100)/100;

    if NIRx.settings.Spectrasearch==1
        Wnlow=temppeak-NIRx.settings.Puls(3);
        Wnhigh=temppeak+NIRx.settings.Puls(3);
        if Wnhigh>NIRx.settings.Puls(2)
            Wnhigh=NIRx.settings.Puls(2);
        end
    else
        Wnlow=NIRx.settings.gPuls(1);
        Wnhigh=NIRx.settings.gPuls(2);
    end
    
    %%%%%%%%%
    %Spectra%
    %%%%%%%%%
    Wnpuls=[Wnlow Wnhigh];                    %Bandpassgrenzen 
    NIRx.Data.Spectra.FWindowPuls=Wnpuls;
    N=200;
    b = fir1(N,Wnpuls/(fs/2),'bandpass');
    puls_down=filtfilt(b,1,puls_down);

    if no_upsample
        puls_down = resample(puls_down,3,fs);           %Downsampling 
    end

    if length(puls_down)<length(oxy_signal)
        puls_down=[puls_down; zeros((length(oxy_signal(:,1))-length(puls_down)),1) ];
    end

    puls_down=puls_down-mean(puls_down);
    NIRx.Data.downsampled.puls=puls_down(1:length(oxy_signal(:,1)));

    
    
    %%%%%%%%%%%%%
    %Resp signal%
    %%%%%%%%%%%%%
    if NIRx.hdr.Bool.gUSBamp
        resp_down = resample(NIRx.Data.Resp,fs,gUSBampfs);           %Downsampling

        %%%%%%%%%
        %Spectra%
        %%%%%%%%%
        rResp=calcNIRSspectra(resp_down,fs);
        %display Puls spectra
        p1 = rResp{1}.p;
        f1 = rResp{1}.f;
        Color='k';
        idx1 = find(f1<=NIRx.settings.Resp(2));
        idx2 = find(f1 >= NIRx.settings.Resp(1));
        idx=intersect(idx1,idx2);
        figure
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
        hold on
        one_Pw_LF=diff(p1(idx));
        two_Pw_LF=diff(one_Pw_LF);
        [peakidx_Resp]=findpeak(p1(idx), one_Pw_LF, two_Pw_LF);

        disp(' ')
        disp('Peak Resp (EF): ')
        FPeakResp=f1(idx2(1)+peakidx_Resp-1)
        NIRx.Data.Spectra.FPeakResp=FPeakResp;
        plot(f1(idx2(1)+peakidx_Resp-1),10*log10(p1(idx2(1)+peakidx_Resp-1)),'ro');
        close

        temppeak=round(FPeakResp*100)/100;

        if NIRx.settings.Spectrasearch==1
            Wnlow=temppeak-NIRx.settings.Resp(3);
            Wnhigh=temppeak+NIRx.settings.Resp(3);
            if Wnhigh>NIRx.settings.Resp(2)
                Wnhigh=NIRx.settings.Resp(2);
            end
        else
            Wnlow=NIRx.settings.gResp(1);
            Wnhigh=NIRx.settings.gResp(2);
        end

        %%%%%%%%%
        %Spectra%
        %%%%%%%%%
        Wnresp=[Wnlow Wnhigh];                    %Bandpassgrenzen 
        NIRx.Data.Spectra.FWindowResp=Wnresp;
        N=200;
        b = fir1(N,Wnresp/(fs/2),'bandpass');
        resp_down=filtfilt(b,1,resp_down); 

        if no_upsample
            resp_down = resample(resp_down,3,fs);           %Downsampling 
        end

        if length(resp_down)<length(oxy_signal)
            resp_down=[resp_down;  zeros((length(oxy_signal(:,1))-length(resp_down)),1)];
        end

        resp_down=resp_down-mean(resp_down);
        NIRx.Data.downsampled.resp=resp_down(1:length(oxy_signal(:,1)));
    end
    
    
    %%%%%%%%%%%%%
    %BPd  signal%
    %%%%%%%%%%%%%
    dia_down = resample(NIRx.Data.BPdia,fs,BPfs);           %Downsampling

    %%%%%%%%%
    %Spectra%
    %%%%%%%%%
    rDia=calcNIRSspectra(dia_down,fs);
    %display Puls spectra
    p1 = rDia{1}.p;
    f1 = rDia{1}.f;
    Color='k';
    idx1 = find(f1<=NIRx.settings.Mayer(2));
    idx2 = find(f1 >= NIRx.settings.Mayer(1));
    idx=intersect(idx1,idx2);
    figure
    plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
    hold on
    one_Pw_LF=diff(p1(idx));
    two_Pw_LF=diff(one_Pw_LF);
    [peakidx_Dia]=findpeak(p1(idx), one_Pw_LF, two_Pw_LF);

    disp(' ')
    disp('Peak BPdia (EF): ')
    FPeakDia=f1(idx2(1)+peakidx_Dia-1)
    NIRx.Data.Spectra.FPeakDia=FPeakDia;
    plot(f1(idx2(1)+peakidx_Dia-1),10*log10(p1(idx2(1)+peakidx_Dia-1)),'ro');
    close

    temppeak=round(FPeakDia*100)/100;

    if NIRx.settings.Spectrasearch==1
        Wnlow=temppeak-NIRx.settings.Mayer(3);
        Wnhigh=temppeak+NIRx.settings.Mayer(3);
        if Wnhigh>NIRx.settings.Mayer(2)
            Wnhigh=NIRx.settings.Mayer(2);
        end
    else
        Wnlow=NIRx.settings.gMayer(1);
        Wnhigh=NIRx.settings.gMayer(2);
    end
    
    %%%%%%%%%
    %Spectra%
    %%%%%%%%%
    Wndia=[Wnlow Wnhigh];                    %Bandpassgrenzen 
    NIRx.Data.Spectra.FWindowDia=Wndia;
    N=200;
    b = fir1(N,Wndia/(fs/2),'bandpass');
    dia_down=filtfilt(b,1,dia_down); 

    if no_upsample
        dia_down = resample(dia_down,3,fs);           %Downsampling 
    end

    if length(dia_down)<length(oxy_signal)
        dia_down=[dia_down;  zeros((length(oxy_signal(:,1))-length(dia_down)),1)];
    end

    dia_down=dia_down-mean(dia_down);
    NIRx.Data.downsampled.BPdia=dia_down(1:length(oxy_signal(:,1)));  

    
    
    %%%%%%%%%%%%%
    %BPs  signal%
    %%%%%%%%%%%%%
    sys_down = resample(NIRx.Data.BPsys,fs,BPfs);           %Downsampling

    %%%%%%%%%
    %Spectra%
    %%%%%%%%%
    rSys=calcNIRSspectra(sys_down,fs);
    %display Puls spectra
    p1 = rSys{1}.p;
    f1 = rSys{1}.f;
    Color='k';
    idx1 = find(f1<=NIRx.settings.Mayer(2));
    idx2 = find(f1 >= NIRx.settings.Mayer(1));
    idx=intersect(idx1,idx2);
    figure
    plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
    hold on
    one_Pw_LF=diff(p1(idx));
    two_Pw_LF=diff(one_Pw_LF);
    [peakidx_Sys]=findpeak(p1(idx), one_Pw_LF, two_Pw_LF);

    disp(' ')
    disp('Peak BPsys (EF): ')
    FPeakSys=f1(idx2(1)+peakidx_Sys-1)
    NIRx.Data.Spectra.FPeakSys=FPeakSys;
    plot(f1(idx2(1)+peakidx_Sys-1),10*log10(p1(idx2(1)+peakidx_Sys-1)),'ro');
    close

    temppeak=round(FPeakSys*100)/100;

    if NIRx.settings.Spectrasearch==1
        Wnlow=temppeak-NIRx.settings.Mayer(3);
        Wnhigh=temppeak+NIRx.settings.Mayer(3);
        if Wnhigh>NIRx.settings.Mayer(2)
            Wnhigh=NIRx.settings.Mayer(2);
        end
    else
        Wnlow=NIRx.settings.gMayer(1);
        Wnhigh=NIRx.settings.gMayer(2);
    end
    
    %%%%%%%%%
    %Spectra%
    %%%%%%%%%
    Wnsys=[Wnlow Wnhigh];                    %Bandpassgrenzen 
    NIRx.Data.Spectra.FWindowSys=Wnsys;
    N=200;
    b = fir1(N,Wnsys/(fs/2),'bandpass');
    sys_down=filtfilt(b,1,sys_down); 

    if no_upsample
        sys_down = resample(sys_down,3,fs);           %Downsampling 
    end

    if length(sys_down)<length(oxy_signal)
        sys_down=[sys_down;  zeros((length(oxy_signal(:,1))-length(sys_down)),1)];
    end

    sys_down=sys_down-mean(sys_down);
    NIRx.Data.downsampled.BPsys=sys_down(1:length(oxy_signal(:,1)));  

    
    
    %%%%%%%%%%%%%
    %HR   signal%
    %%%%%%%%%%%%%
    if NIRx.hdr.Bool.gUSBamp
        HR_down = resample(NIRx.Data.HR,fs,gUSBampfs);           %Downsampling

        %%%%%%%%%
        %Spectra%
        %%%%%%%%%
        rHR=calcNIRSspectra(HR_down,fs);
        %display Puls spectra
        p1 = rHR{1}.p;
        f1 = rHR{1}.f;
        Color='k';
        idx1 = find(f1<=NIRx.settings.Mayer(2));
        idx2 = find(f1 >= NIRx.settings.Mayer(1));
        idx=intersect(idx1,idx2);
        figure
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
        hold on
        one_Pw_LF=diff(p1(idx));
        two_Pw_LF=diff(one_Pw_LF);
        [peakidx_HR]=findpeak(p1(idx), one_Pw_LF, two_Pw_LF);

        disp(' ')
        disp('Peak HR (EF): ')
        FPeakHR=f1(idx2(1)+peakidx_HR-1)
        NIRx.Data.Spectra.FPeakHR=FPeakHR;
        plot(f1(idx2(1)+peakidx_HR-1),10*log10(p1(idx2(1)+peakidx_HR-1)),'ro');
        close

        temppeak=round(FPeakHR*100)/100;

        if NIRx.settings.Spectrasearch==1
            Wnlow=temppeak-NIRx.settings.Mayer(3);
            Wnhigh=temppeak+NIRx.settings.Mayer(3);
            if Wnhigh>NIRx.settings.Mayer(2)
                Wnhigh=NIRx.settings.Mayer(2);
            end
        else
            Wnlow=NIRx.settings.gMayer(1);
            Wnhigh=NIRx.settings.gMayer(2);
        end

        %%%%%%%%%
        %Spectra%
        %%%%%%%%%
        WnHR=[Wnlow Wnhigh];                    %Bandpassgrenzen 
        NIRx.Data.Spectra.FWindowHR=WnHR;
        N=200;
        b = fir1(N,WnHR/(fs/2),'bandpass');
        HR_down=filtfilt(b,1,HR_down); 

        if no_upsample
            HR_down = resample(HR_down,3,fs);           %Downsampling 
        end

        if length(HR_down)<length(oxy_signal)
            HR_down=[HR_down;  zeros((length(oxy_signal(:,1))-length(HR_down)),1)];
        end

        HR_down=HR_down-mean(HR_down);
        NIRx.Data.downsampled.HR=HR_down(1:length(oxy_signal(:,1)));  
    end
    
    
    %%%%%%%%%%%%%%%%%%%
    %Auswahl für Mayer%
    %%%%%%%%%%%%%%%%%%%
    if NIRx.settings.MayerSorce==1
        NIRx.Data.downsampled.Mayer=NIRx.Data.downsampled.BPsys;
        NIRx.Data.Spectra.FWindowMayer=Wnsys;
    elseif NIRx.settings.MayerSorce==2
        NIRx.Data.downsampled.Mayer=NIRx.Data.downsampled.BPdia;
        NIRx.Data.Spectra.FWindowMayer=Wndia;
    elseif NIRx.hdr.Bool.gUSBamp
        disp('No HR-Data available. Mayer-Correction set to 2!');
        NIRx.Data.downsampled.Mayer=NIRx.Data.downsampled.BPdia;
        NIRx.Data.Spectra.FWindowMayer=Wndia;
    else        
        NIRx.Data.downsampled.Mayer=NIRx.Data.downsampled.HR;
        NIRx.Data.Spectra.FWindowMayer=WnHR;
    end

    fs=old;

    
    %%%%%%%%%%%%%
    %%%%%%%%%%%%%
    %%%%Clean%%%%
    %%%%%%%%%%%%%
    %%%%%%%%%%%%%

    %AdaptPuls
    for g=1:1:size(oxy_signal,2) %beginn der Kanalschleife
        NIRx.Data.clean.oxy_signals_AdaptPuls(:,g)=EHK_adaptpuls(oxy_signal(:,g),NIRx.Data.downsampled.puls,fs);
        NIRx.Data.clean.deoxy_signals_AdaptPuls(:,g)=EHK_adaptpuls(deoxy_signal(:,g),NIRx.Data.downsampled.puls,fs);
    end    

    %AdaptPulsOnline
    for g=1:1:size(oxy_signal,2) %beginn der Kanalschleife
        NIRx.Data.clean.oxy_signals_AdaptPulsOnline(:,g)=EHK_adaptpulsonline(oxy_signal(:,g),NIRx.Data.downsampled.puls,fs);
        NIRx.Data.clean.deoxy_signals_AdaptPulsOnline(:,g)=EHK_adaptpulsonline(deoxy_signal(:,g),NIRx.Data.downsampled.puls,fs);
    end

    % Resp
    if NIRx.hdr.Bool.gUSBamp
        if NIRx.settings.TFICA==1
            NIRx.Data.clean.oxy_signals_RespCorr=remNoiseICAone(oxy_signal,NIRx.Data.downsampled.resp,fs,NIRx.settings.ExCh);
            NIRx.Data.clean.deoxy_signals_RespCorr=remNoiseICAone(deoxy_signal,NIRx.Data.downsampled.resp,fs,NIRx.settings.ExCh);
        else
            for g=1:1:size(oxy_signal,2) %beginn der Kanalschleife
                NIRx.Data.clean.oxy_signals_RespCorr(:,g)=remNoiseTF(oxy_signal(:,g),NIRx.Data.downsampled.resp,fs);
                NIRx.Data.clean.deoxy_signals_RespCorr(:,g)=remNoiseTF(deoxy_signal(:,g),NIRx.Data.downsampled.resp,fs);
            end
        end
    end

    % Mayer
    if NIRx.settings.TFICA==1
        NIRx.Data.clean.oxy_signals_MayerCorr=remNoiseICAone(oxy_signal,NIRx.Data.downsampled.Mayer,fs,NIRx.settings.ExCh);
        NIRx.Data.clean.deoxy_signals_MayerCorr=remNoiseICAone(deoxy_signal,NIRx.Data.downsampled.Mayer,fs,NIRx.settings.ExCh);
    else
        for g=1:1:size(oxy_signal,2) %beginn der Kanalschleife
            NIRx.Data.clean.oxy_signals_MayerCorr(:,g)=remNoiseTF(oxy_signal(:,g),NIRx.Data.downsampled.Mayer,fs);
            NIRx.Data.clean.deoxy_signals_MayerCorr(:,g)=remNoiseTF(deoxy_signal(:,g),NIRx.Data.downsampled.Mayer,fs);
        end
    end

    % Mayer and Resp corr
    if NIRx.hdr.Bool.gUSBamp
        if NIRx.settings.TFICA==1
            NIRx.Data.clean.oxy_signals_MayerRespCorr=remNoiseICA(oxy_signal,NIRx.Data.downsampled.Mayer,NIRx.Data.downsampled.resp,fs,NIRx.settings.ExCh);
            NIRx.Data.clean.deoxy_signals_MayerRespCorr=remNoiseICA(deoxy_signal,NIRx.Data.downsampled.Mayer,NIRx.Data.downsampled.resp,fs,NIRx.settings.ExCh);
        else
            for g=1:1:size(oxy_signal,2) %beginn der Kanalschleife
                NIRx.Data.clean.oxy_signals_MayerRespCorr(:,g)=remNoiseTF(NIRx.Data.clean.oxy_signals_RespCorr(:,g),NIRx.Data.downsampled.Mayer,fs);
                NIRx.Data.clean.deoxy_signals_MayerRespCorr(:,g)=remNoiseTF(NIRx.Data.clean.deoxy_signals_RespCorr(:,g),NIRx.Data.downsampled.Mayer,fs);
            end
        end 

        % All corr
        for g=1:1:size(oxy_signal,2) %beginn der Kanalschleife
            NIRx.Data.clean.oxy_signals_MayerRespAdaptPulsCorr(:,g)=EHK_adaptpuls(NIRx.Data.clean.oxy_signals_MayerRespCorr(:,g),NIRx.Data.downsampled.puls,fs);
            NIRx.Data.clean.deoxy_signals_MayerRespAdaptPulsCorr(:,g)=EHK_adaptpuls(NIRx.Data.clean.deoxy_signals_MayerRespCorr(:,g),NIRx.Data.downsampled.puls,fs);
        end
    end

    %%%%TP zhang

    %Remove et Zhang
    % 
    %          [N,Wn]=buttord(0.125/(NIRx.hdr.SamplingRate{1}/2),0.5/(NIRx.hdr.SamplingRate{1}/2),3,30); %neu
    %          [b,a]=butter(N,Wn,'low');
    %     for g=1:1:size(oxy_signal,2) 
    %          NIRx.Data.clean.oxy_signals_TP_Zhang(:,g)=filtfilt(b,a,oxy_signal(:,g));
    %          NIRx.Data.clean.deoxy_signals_TP_Zhang(:,g)=filtfilt(b,a,deoxy_signal(:,g)); 
    %     end
    if OFInk     
        NIRx.settings.ExCh=oldExCh;
    end

    %%%%%%%%%%%%
    %Which typ?%
    %%%%%%%%%%%%
    %0 ... uncorrected, 1 ... resp corrected, 2 ... mayer corrected, 3 ...
    %mayer+resp corrected, 4 ... 3+puls, 5 ... onlyadaptivepuls, 6...onlinepuls

    if NIRx.settings.corrmode == 1 
        oxy_signal=NIRx.Data.clean.oxy_signals_RespCorr;
        deoxy_signal=NIRx.Data.clean.deoxy_signals_RespCorr;
    elseif NIRx.settings.corrmode == 2 
        oxy_signal=NIRx.Data.clean.oxy_signals_MayerCorr;
        deoxy_signal=NIRx.Data.clean.deoxy_signals_MayerCorr;
    elseif NIRx.settings.corrmode == 3 && NIRx.hdr.Bool.gUSBamp
        oxy_signal=NIRx.Data.clean.oxy_signals_MayerRespCorr;
        deoxy_signal=NIRx.Data.clean.deoxy_signals_MayerRespCorr; 
    elseif NIRx.settings.corrmode == 4 && NIRx.hdr.Bool.gUSBamp
        oxy_signal=NIRx.Data.clean.oxy_signals_MayerRespAdaptPulsCorr;
        deoxy_signal=NIRx.Data.clean.deoxy_signals_MayerRespAdaptPulsCorr; 
    elseif NIRx.settings.corrmode == 5 
        oxy_signal=NIRx.Data.clean.oxy_signals_AdaptPuls;
        deoxy_signal=NIRx.Data.clean.deoxy_signals_AdaptPuls;     
    elseif NIRx.settings.corrmode == 6 
        oxy_signal=NIRx.Data.clean.oxy_signals_AdaptPulsOnline;
        deoxy_signal=NIRx.Data.clean.deoxy_signals_AdaptPulsOnline;
    elseif NIRx.settings.corrmode == 7 
        oxy_signal= NIRx.Data.clean.oxy_signals_TP_Zhang;
        deoxy_signal=NIRx.Data.clean.deoxy_signals_TP_Zhang;    
    else
        oxy_signal=oxy_signal;
        deoxy_signal=deoxy_signal;
    end
end