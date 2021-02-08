function [NIRx,status] = generatebiosignals(NIRx,settings,data)

status = 0;

try
    disp('Generate Biosignals start');
    ImageClassString = settings.imageClass.string;
    ImageClassValue  = settings.imageClass.value;
    ClassLabels = NIRx.hdr.Markers.Class; % Conditions of markers
    Trigger = NIRx.hdr.Markers.Time; % Time while marker was received
    Task = settings.taskName;

    if NIRx.hdr.Bool.gUSBamp
        gUSBampfs = NIRx.hdr.gUSBampSamplingRate; % Sampling rate of gUSBamp
    else
        gUSBampfs = 0;
    end

    if isfield(NIRx.hdr, 'BPSamplingRate')
        BPfs = NIRx.hdr.BPSamplingRate; % Sampling rate of CNAP
    else
        BPfs = 0;
    end

%         %Auswahl der Trigger
%         if strcmp(ImageClassString,'MA')
% %             ClassLabels(D{1}.MA==1)=0;
% 
%             trig = Trigger(ClassLabels==2);
%         elseif strcmp(ImageClassString,'FS')
% %             ClassLabels(D{1}.FS==1)=0;
% 
%             trig = Trigger(ClassLabels==3);
%         elseif strcmp(ImageClassString,'OQ')
% %             ClassLabels(D{1}.OQ==1)=0;
% 
%             trig = Trigger(ClassLabels==4);
%         end

%     nTrials = length(ClassLabels);
%     nTrials = settings.nrTrials;
%     nConds = settings.imageClass.nrCond;
%     foundTriggers = length(unique(ClassLabels));
%     
%     if foundTriggers ~= nConds
%         trigPause = mode(double(ClassLabels));
% %         ClassLabels(ClassLabels == trigPause) = 0;
%     end
%     
%     ClassLabelsRank = ClassLabels;
    
%     [val ind] = sort(ClassLabels,'descend');
    
%     for k = length(settings.imageClass.list):-1:1
%        maxVal = max(ClassLabels);
%        ClassLabelsRank(ClassLabels == maxVal) = k;
%        ClassLabels(ClassLabels == maxVal) = 0;
%     end
    
    if ~strcmp(ImageClassString,'Default')
        trig = Trigger(ClassLabels == ImageClassValue);
    else
        trig = Trigger;
    end

    condTrigger = unique(ClassLabels);
    
    % Falls keine Trigger fuer condition gefunden werden
    if isempty(trig)
        disp(['No marker for condition ' ImageClassString ' found. Execution stopped!']);
        disp(['Possible marker: ' mat2str(condTrigger)]);
        return;
    end
    
    nTrials = settings.nrTrials;
    
    % Falls keine Trigger fuer condition gefunden werden
    if length(trig) ~= nTrials
        disp(['Number of Trials does not match number of condition marker. Execution stopped!']);
        disp(['Possible marker: ' mat2str(condTrigger)]);
        return;
    end

    if settings.generateFiguresBiosignals && NIRx.hdr.Bool.BP
        %%%% selbes gsatzl ist auch um Zeile 558 nocheinmal, jedoch mit NIRS fs und
        SollAktivierung = zeros(size(NIRx.Data.BPdia,1),1)*0;  %% *0 um sicher auf 0 zu sein????
        if NIRx.hdr.Bool.gUSBamp
            SollAktivierung2 = zeros(size(NIRx.Data.Resp,1),1)*0;  %% *0 um sicher auf 0 zu sein????

            % notch-Filter data at 50Hz (see help for iirnotch)
            if settings.notch
                try
                    d = fdesign.bandstop('N,F3dB1,F3dB2', 2, 48, 52, gUSBampfs);
                    h = design(d, 'butter', 'SOSScaleNorm', 'linf');
                    SOS = h.sosMatrix;
                    G = h.ScaleValues;
                    NIRx.Data.ecg = filtfilt(SOS, G, NIRx.Data.ecg);
                    NIRx.Data.Resp = filtfilt(SOS, G, NIRx.Data.Resp);
                catch
                    Wo = 50/(round(gUSBampfs)/2);
                    BW = Wo/35; 
                    [b,a] = iirnotch(Wo,BW);
                    NIRx.Data.ecg = filter(b,a,NIRx.Data.ecg);
                    NIRx.Data.Resp = filter(b,a,NIRx.Data.Resp);
                end
            end
        else
            SollAktivierung2 = 0;
        end

        %%%% SollAktivierung ?berall eins wo signal aktiv
        for i = 1:length(trig)
            [idx idx] = min(abs(NIRx.Time.BP - trig(i)));
            SollAktivierung(idx + round(0*BPfs):round(settings.timing.signal*BPfs)) = 1;

            if NIRx.hdr.Bool.gUSBamp
                [idx idx] = min(abs(NIRx.Time.gUSBamp - trig(i)));
                SollAktivierung2(idx + round(0*gUSBampfs):round(settings.timing.signal*gUSBampfs)) = 1;
            end
        end    
        clear i idx

        settings.correct_physio_signals = 1;
        % Correction physiological signals
        if settings.correct_physio_signals
            %figure,plot(NIRx.Data.ecg(1:1000));
        	ecg_temp = (NIRx.Data.ecg-mean(NIRx.Data.ecg))*(-1);
            NIRx.Data.ecg = ecg_temp;
            %figure,plot(ecg_temp(1:1000));
            resp_temp = NIRx.Data.Resp*(-1);
            %figure,plot(resp_temp);
            NIRx.Data.Resp = resp_temp;
        end
        
        %Verlaufplot
        verlaufphysio(NIRx, SollAktivierung, SollAktivierung2, data, Task, ImageClassString, BPfs, gUSBampfs);

        %Mittelung
        mittelungphysio(NIRx, settings, data, Task, ImageClassString, trig, BPfs, gUSBampfs); 
    end
    
    if settings.generateFiguresBiosignals && ~NIRx.hdr.Bool.BP
        errordlg('No Blood Pressure data, Biosignals could not be generated!');
    end
    
    %Konzentrationsberechnung
    [deoxy_signal, oxy_signal]=calculateconcentrationchange(NIRx); % Wird nach baseline removal und tp-filterung einfach ?berschrieben

    if max(max(isnan(deoxy_signal))) || max(max(isnan(oxy_signal)))
        disp('Error with Concentration Calculation!');
        return
    end

    NIRx.Data.Concentration.raw.deoxy = deoxy_signal;
    NIRx.Data.Concentration.raw.oxy   = oxy_signal;
%     NIRx.Data.Concentration.raw.wl760 = wl760;
%     NIRx.Data.Concentration.raw.wl830 = wl830;

    disp('Generate Biosignals finished');
    status = 1;
    NIRx.trigger = trig;

catch ME
    disp(['Error message: ' ME.message]);

    if ~NIRx.hdr.Bool.BP
        errordlg('Error generating Biosignals: No Blood Pressure Data available.');
    end

    if ~NIRx.hdr.Bool.gUSBamp
        disp('Error "Auswertung": No gUSBamp data available.');
    end 
    
end %try
