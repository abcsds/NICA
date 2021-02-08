function [NIRx,status] = loadNIRxXDF(data,settings)

status = 0;

% try
    NIRx = [];
    
%     version  = settings.version.string;
    version = 'NIRScout';
    nrTrials = settings.nrTrials;
    
    FileName_hdr = [data.hdr.path data.hdr.name];
    
    nrXDF = length(data.xdf.selected);
    
    if nrXDF == 1
        if iscell(data.xdf.name)
            FileName_XDF{1} = [data.xdf.path data.xdf.name{data.xdf.selected}];
        else
            FileName_XDF{1} = [data.xdf.path data.xdf.name];
        end
    else
        FileName_XDF = cell(1,nrXDF);
        for i = 1:nrXDF
            FileName_XDF{i} = [data.xdf.path data.xdf.name{data.xdf.selected(i)}];
        end
    end
    
    %Header for final NIRx variable
    %[GeneralInfo]
    hdr.FileName=[];
    hdr.Date=[];
    hdr.Time=[];
    %[ImagingParameters]
    hdr.Sources=[];
    hdr.Detectors=[];
    hdr.Wavelengths=[];
    hdr.TrigIns=[];
    hdr.TrigOuts=[];
    hdr.AnIns=[];
    hdr.SamplingRate=[];
    %[Paradigm]
    hdr.StimulusType=[];
    %[ExperimentNotes]
    hdr.Notes=[];
    %[GainSettings]
    hdr.Gains=[];
    %[Markers]
    hdr.Markers.Time=[];
    hdr.Markers.Class=[];
    hdr.Markers.Frame=[];
    %[DataStructure]
    hdr.Mask=[];
    %[AvailableDataStreams]
    hdr.Bool.BP=false;
    hdr.Bool.NIRS=false;
    hdr.Bool.Marker=false;
    hdr.Bool.gUSBamp=false;
    hdr.Bool.paradigm=false;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %%%%%%%%%%%%%%%%%%%%Variables%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    wl760_signal = [];
    wl830_signal = [];
    NIRx_time = [];

    CNAP_bp = [];
    CNAP_time = [];
    gUSBamp_resp = [];
    gUSBamp_ecg = [];
    gUSBamp_time = [];

    Markers_Time=[];
    Markers_Class=[];
    Markers_Frame=[];

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %%%%%%%%%%%%%%%%%%Do for every run%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1 : length(FileName_XDF)    %Je ein Durchlauf pro Datensatz
               
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        %%%%%%%%%%%%%Einlesen eines Datensatzes%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%hdr einlesen%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        startpunkt=[];
        k=1;
        
        text = ['Loading... ' FileName_hdr];
        disp(text);
        
        fid_in = fopen(FileName_hdr, 'r');

        while ~feof(fid_in) 
            header{k} = fgetl(fid_in);

            if strcmp('NIRScout',version)
                if strcmp('#"',header{k})
                   startpunkt=[startpunkt k];
                end
            else
                if strcmp('#',header{k})
                   startpunkt=[startpunkt k];
                end
            end


            if strcmp('NIRScout',version)
                if strcmp('Gains="#',header{k})
                   startpunkt_gains=[k];
                end
            else
                if strcmp('Gains=#',header{k})
                   startpunkt_gains=[k];
                end
            end

            k=k+1;
        end

        %[GeneralInfo]1
        FileName=header{1,2}(10:end);
        Date=header{1,3}(6:end);
        Time=header{1,4}(6:end);

        %[ImagingParameters]5
        if strcmp('NIRScout',version)
            Sources=str2num(header{1,12}(end-1:end));
            Detectors=str2num(header{1,13}(end-1:end));
            Wavelengths=2;% =str2num(header{1,15}(end))wird im neuen header anders abgespeichert
            TrigIns=str2num(header{1,16}(end));
            TrigOuts=str2num(header{1,17}(end));
            AnIns=str2num(header{1,18}(end));
            SamplingRate=str2num(header{1,19}(end-7:end));
        else
            Sources=str2num(header{1,6}(end-1:end));
            Detectors=str2num(header{1,7}(end-1:end));
            Wavelengths=str2num(header{1,8}(end));
            TrigIns=str2num(header{1,9}(end));
            TrigOuts=str2num(header{1,10}(end));
            AnIns=str2num(header{1,11}(end));
            SamplingRate=str2num(header{1,12}(end-7:end));
        end

        %[Paradigm]13
        if strcmp('NIRScout',version)
            StimulusType=header{1,16}(14:end);
        else
            StimulusType=header{1,14}(14:end);
        end

        %[ExperimentNotes]15
        if strcmp('NIRScout',version)
            Notes=header{1,19}(8:end-1);
        else
            Notes=header{1,16}(8:end-1);
        end   

        %[GainSettings]17
        Gains_txt=[];
        Gains=[];
        for k=startpunkt_gains+1:startpunkt(1)-1
            Gains_txt=[Gains_txt; header{1,k}];
        end

        Gains=str2num(Gains_txt);
        clear Gains_txt

        clear Markers_Time_txt Markers_Class_txt Markers_Frame_txt

        %[Mask]
        Mask_txt=[];
        Mask=[];
        if strcmp('NIRScout',version)
            for k=startpunkt(2)+5:1:startpunkt(3)-1
                Mask_txt=[Mask_txt; header{1,k}];
            end
        else
            for k=startpunkt(2)+4:1:startpunkt(3)-1
                Mask_txt=[Mask_txt; header{1,k}];
            end
        end

        Mask=str2num(Mask_txt);
        clear Mask_txt

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%Daten einlesen%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        text = ['Loading... ' FileName_XDF{i}];
        disp(text);
        
        [data_xdf, hdr_xdf] = load_xdf(FileName_XDF{i});%, 'HandleClockSynchronization', true, 'HandleJitterRemoval', false); %hdr_xdf contain only version of load_xdf

        % split up data from XDF file
        nirx = [];
        marker_nirx = [];
        cnap = [];
        gusbamp = [];

        disp(['Loaded ' num2str(length(data_xdf)) ' XDF-Classes.']);
        
        % Dissolve xdf data
        for j = 1 : length(data_xdf)
            dataInfoName = data_xdf{j}.info.name;
            disp(['Class ' num2str(j) ': ' dataInfoName]);
            switch dataInfoName %source_id % .name
                case 'NIRStar'%'NIRStar-TCP-Stream' %'NIRStar'
                   nirx = data_xdf{j};
                   hdr.Bool.NIRS = true;
                   
                   % how many channels are used within the mask,
                   % -3(2xWavelength, 1xZeroBased(at 344))
                   Channels = length(nirx.info.desc.channels.channel) - 3;
                   
                   text = [data_xdf{j}.info.source_id ' found in XDF. Channels: ' num2str(Channels)];
                   disp(text);


%                 case 'NIRStar-Markers'%'NIRStar-TCP-Stream_markers' %'NIRStar-Markers'      
%                    marker_nirx = data_xdf{j};
%                    hdr.Bool.Marker = true;
%                    
%                    text = [data_xdf{j}.info.source_id ' found in XDF.'];
%                    disp(text);
% 
%                    if hdr.Bool.paradigm
%                        text = 'Paradigm trigger already found!';
%                        disp(text);
%                        return
%                    end
%                    
%                    % Remove all markers without information
%                    Markers_Class = marker_nirx.time_series(marker_nirx.time_series(:) ~= 0);
%                    Markers_Time = marker_nirx.time_stamps(marker_nirx.time_series(:) ~= 0);
%                    
%                    % Get time series from run when it is active
%                    run_start_stop = Markers_Time(Markers_Class(:) == 1); % je nachdem wie die trigger gesendet werden, vielleicht immer oder nur einmalig
%               
%                    % Remove start/stop markers
%                    Markers_Class(1) = [];
%                    Markers_Class(end) = [];
%                    Markers_Time(1) = [];
%                    Markers_Time(end) = [];
%                    
%                    % Check if there are enough start/stop markers
%                    
%                    if mod(length(run_start_stop),2) ~= 0
%                        text = 'Error: Start/Stop markers uneven.';
%                        disp(text);
%                        return
%                    end
%                    
%                    if (length(Markers_Class)) ~= nrTrials
%                        text = 'Error: found triggers do not match number of known trials!';
%                        disp(text);
%                        return
%                    end

                case 'CNAP-BP'%'SerialPort_CNAP-BP' %'CNAP-BP'
                   cnap = data_xdf{j};
                   hdr.Bool.BP = true;
                   
                   text = [data_xdf{j}.info.source_id ' found in XDF.'];
                   disp(text);

                case 'g.USBamp-1'%'gUSBamp_1_UB-2010.03.28' %'g.USBamp-1'
                   gusbamp = data_xdf{j};
                   hdr.Bool.gUSBamp = true;
                   
                   text = [data_xdf{j}.info.source_id ' found in XDF.'];
                   disp(text);
                   
               case 'g.USBamp-2'%'gUSBamp_1_UB-2010.03.28' %'g.USBamp-1'
                   gusbamp = data_xdf{j};
                   hdr.Bool.gUSBamp = true;
                   
                   text = [data_xdf{j}.info.source_id ' found in XDF.'];
                   disp(text);

                case 'paradigm'
                   hdr.Bool.paradigm = true;
                   marker_nirx = data_xdf{j};
                   text = [data_xdf{j}.info.source_id ' found in XDF.'];
                   disp(text);
                   
                   if hdr.Bool.Marker
                       text = 'NIRS-Marker will be overwritten by paradigm-Marker!';
                       disp(text);
                   end
                   
                   hdr.Bool.Marker = true;
                   
                   % Remove all markers without information
                   Markers_Class = marker_nirx.time_series(marker_nirx.time_series(:) ~= 0);
                   Markers_Time = marker_nirx.time_stamps(marker_nirx.time_series(:) ~= 0);
                   
                   % Get time series from run when it is active, start/stop
                   % trigger=1
                   run_start_stop = [Markers_Time(1),Markers_Time(end)]; %1
              
                   % Remove start/stop markers
%                    Markers_Class(1) = [];
%                    Markers_Class(end) = [];
%                    Markers_Time(1) = [];
%                    Markers_Time(end) = [];
                   
%                    % Check if there are enough start/stop markers
%                    if mod(length(run_start_stop),1) ~= 0
%                        text = 'Error: Start/Stop markers uneven.';
%                        disp(text);
%                        return
%                    end

%                    if (length(Markers_Class))/2 ~= nrTrials
%                        text = ['Error: found triggers (' num2str(length(Markers_Class)/2) ') do not match number of known trials!'];
%                        disp(text);
%                        return
%                    end
            end
        end
        clear j

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%preprocess data from xdf%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
        if (~isempty(nirx)) % crop NIRS data
            crop = (nirx.time_stamps(:) >= run_start_stop(1)) & (nirx.time_stamps(:) <= run_start_stop(end)); % values inside run

            nirx.time_stamps = nirx.time_stamps(:,crop); % crop time stamps
            nirx.time_series = nirx.time_series(:,crop); % crop data
        end

        if (~isempty(cnap)) % crop CNAP data
            crop = (cnap.time_stamps(:) >= run_start_stop(1)) & (cnap.time_stamps(:) <= run_start_stop(end)); % values inside run

            cnap.time_stamps = cnap.time_stamps(:,crop); % crop time stamps
            cnap.time_series = cnap.time_series(:,crop); % crop data
        end

        if (~isempty(gusbamp)) % crop gusbamp
            crop = (gusbamp.time_stamps(:) >= run_start_stop(1)) & (gusbamp.time_stamps(:) <= run_start_stop(end)); % values inside run

            gusbamp.time_stamps = gusbamp.time_stamps(:,crop); % crop time stamps
            gusbamp.time_series = gusbamp.time_series(:,crop); % crop data
        end
        clear crop
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%sum all up%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %[GeneralInfo]
        hdr.FileName{i}=FileName;
        hdr.Date{i}=Date;
        hdr.Time{i}=Time;
        clear FileName Date Time

        %[ImagingParameters]
        hdr.Sources{i}=Sources;
        hdr.Detectors{i}=Detectors;
        hdr.Wavelengths{i}=Wavelengths;
        hdr.TrigIns{i}=TrigIns;
        hdr.TrigOuts{i}=TrigOuts;
        hdr.AnIns{i}=AnIns;
        hdr.SamplingRate{i}=SamplingRate;
        clear SamplingRate AnIns TrigOuts TrigIns Wavelengths

        %[Paradigm]
        hdr.StimulusType{i}=StimulusType;
        clear StimulusType

        %[ExperimentNotes]
        hdr.Notes{i}=Notes;
        clear Notes

        %[GainSettings]
        hdr.Gains{i}=Gains;
        clear Gains

        %[DataStructure]
        hdr.Mask{i}=Mask;
        clear Mask

        % Read wavelengths into temporary variables
        wl1_signal = nirx.time_series(1:Channels,:)';
        wl2_signal = nirx.time_series((Channels+1):(2*Channels),:)';
        nirx_time = nirx.time_stamps(:,:);
        clear  Detectors Sources Channels
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%/Preprocess to time NIrx and Physio%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %[Markers]
        hdr.Markers.Time=[hdr.Markers.Time; Markers_Time']; % sollte eigentlich nicht im main gebraucht werden.
        hdr.Markers.Class=[hdr.Markers.Class; Markers_Class'];
        hdr.Markers.Frame=[hdr.Markers.Frame; Markers_Frame+length(wl760_signal)]; 

        %Daten
        wl760_signal = [wl760_signal; wl1_signal];
        wl830_signal = [wl830_signal; wl2_signal];
        
        NIRx_time = [NIRx_time, nirx_time];

        if (~isempty(cnap))
            CNAP_bp = [CNAP_bp; double(cnap.time_series(1,:))'];
            CNAP_time = [CNAP_time; cnap.time_stamps'];
        end

        if (~isempty(gusbamp))
            gUSBamp_resp = [gUSBamp_resp; double(gusbamp.time_series(5,:))'];
            gUSBamp_ecg = [gUSBamp_ecg; double(gusbamp.time_series(1,:)*(-1))']; 
            gUSBamp_time = [gUSBamp_time; gusbamp.time_stamps'];
        end
    end % for i = 1 : length(FileNam...  
    clear i Markers_Class Markers_Frame Markers_Time

    %Physiopreprocess
    if (~isempty(CNAP_time))
        try
            NIRx.Data.BPsys = calcBPlin(CNAP_bp,cnap.info.effective_srate,1)*10; %systole neu:*10; alt:*2, nominal_srate oder effective????
            NIRx.Data.BPdia = calcBPlin(CNAP_bp,cnap.info.effective_srate,2)*10; %diastole neu:*10; alt:*2
        catch
            NIRx.Data.BPsys = CNAP_bp;
            NIRx.Data.BPdia = CNAP_bp;
        end
        
        NIRx.Data.BP = CNAP_bp;
        NIRx.Time.BP = CNAP_time;
        hdr.BPSamplingRate = cnap.info.effective_srate;
    end

    if (~isempty(gUSBamp_time))
        NIRx.Data.Resp = gUSBamp_resp;
        try
            NIRx.Data.HR = calcHRlin(gUSBamp_ecg(:,1), round(gusbamp.info.effective_srate(1)),settings.generateFiguresHeartRate,data);
        catch
            disp('Could not calculate HR-Signal');
        end
        
        NIRx.Data.ecg = gUSBamp_ecg(:,1); 
        NIRx.Time.gUSBamp = gUSBamp_time;
        hdr.gUSBampSamplingRate = round(gusbamp.info.effective_srate(1));
    end
    
    % NIRS-Data
    NIRx.hdr = hdr;
    NIRx.Data.wl760 = wl760_signal;
    NIRx.Data.wl830 = wl830_signal;
    NIRx.Time.NIRS = NIRx_time;
    
    status = 1;

% catch ME
%     errFile = ME.stack.file;
%     errLine = ME.stack.line;
%     errMess = ME.message;
%     errordlg(['Error in File ' errFile ' at line ' num2str(errLine) ': ' errMess]);
%     return
% end
