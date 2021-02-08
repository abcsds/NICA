%%%%Hauptprogramm zur Auswertung der mittels NIRx_systems gemessenen
%%%%Datensätzen (v.0.2)
%%%%
%%%%Angepasst von Dominik Bachmaier
%%%%Änderungen: -Laden der Daten aus XDF-File

clear all
close all
warning off

global Ts TS mu n_koeff M
% File & Path
j=1;
i=1;
current_path=pwd; 
current_drive=current_path(1);        
%DataPath=['C:\Recordings\CurrentStudy\']; % Directory of all subject
DataPath=['D:\Geschäftlich\UNI\Masterarbeit\Messungen\'];      
%%
%%%%%%%%%%%%%%
%%%subjects%%%
%%%%%%%%%%%%%%

% Predefs.: Define the location of xdf-file and data stored from NIRStar
Group='20160413'; % Directory of subject 
Task='MA'; % Name of the task given by you
D{j}.ImageClass{1}= 'MA'; % 2=TS, 3=FS, 4=OQ % Name of condition for this run, must be changed according to the paradigma. Also change in "AUSWERTUNG".
D{j}.NIRxVers = 'new'; % NIRScout = new
%D{j}.ParaVers = 'long'; % 10 trials pro run
    
% Run 1: %%
% Def. XDF, NIRx ID and Image Class under investigation for run 1
D{j}.xdfID = ['Messung20160413_1']; % XDF-ID of run
D{j}.MeasurementID = ['2016-04-13_001']; % NIRStar ID of run

% Build Path
D{j}.FileDir = [DataPath, Group, '\'];

% Build FileNames
% Setting
D{j}.hdr{i}=[D{j}.MeasurementID, '\NIRS-', D{j}.MeasurementID,'.hdr'];
% XDF
D{j}.XDF{i}.FileName=[D{j}.xdfID,'.xdf']; 

i = i + 1;

% Run 1: %%
% Def. XDF, NIRx ID and Image Class under investigation for run 1
D{j}.xdfID = ['Messung20160413_2']; % XDF-ID of run
D{j}.MeasurementID = ['2016-04-13_002']; % NIRStar ID of run

% Build Path
D{j}.FileDir = [DataPath, Group, '\'];

% Build FileNames
% Setting
D{j}.hdr{i}=[D{j}.MeasurementID, '\NIRS-', D{j}.MeasurementID,'.hdr'];
% XDF
D{j}.XDF{i}.FileName=[D{j}.xdfID,'.xdf']; 

i = i + 1;

% Run 3: %%
% Def. XDF, NIRx ID and Image Class under investigation for run 1
D{j}.xdfID = ['Messung20160413_3']; % XDF-ID of run
D{j}.MeasurementID = ['2016-04-13_002']; % NIRStar ID of run

% Build Path
D{j}.FileDir = [DataPath, Group, '\'];

% Build FileNames
% Setting
D{j}.hdr{i}=[D{j}.MeasurementID, '\NIRS-', D{j}.MeasurementID,'.hdr'];
% XDF
D{j}.XDF{i}.FileName=[D{j}.xdfID,'.xdf']; 

i = i + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%% Artefakt und Optodenfehler definieren %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define possible Optode Failure
% D{j}.OptodeFailure{$iteration of failure$}={$failed Channel$;[$channels to interpolate failed channel$]};
% Example: D{j}.OptodeFailure{1}={ 3 ;[ 1,17]}; 
% D{j}.OptodeFailure{1}={ 3 ;[ 1,17 ]}; 
% D{j}.OptodeFailure{2}={ 5 ;[ 17, 21 ]};
% D{j}.OptodeFailure{3}={ 4 ;[ 6, 21 ]};
% D{j}.OptodeFailure{4}={  ;[ ]};
% D{j}.OptodeFailure{5}={  ;[ ]};
% D{j}.OptodeFailure{6}={  ;[ ]}; 
% D{j}.OptodeFailure{7}={  ;[ ]};   

% Define Artifact Trials (excl. == 1) Exclude Trials containing artefacts
D{j}.MA =[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
          0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
% D{j}.FS =[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
%           0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];


%%
%%Known Setting for Analysis
D{j}.Timing = [-5 20];  % a few seconds before sentence starts till xx seconds after sentens ends (0sec)
D{j}.KnownNrofTrials=14;  %Total number of Trials per run

%%%%%%%%%%%%%%%%%%%%
%%%Laden d. Daten%%%
%%%%%%%%%%%%%%%%%%%%
[NIRx]=load_NIRx_XDF(D);

disp('Files loaded.'); disp('--------------------------------------------');
% return
%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%settings%%%%%%
%%%%%%%%%%%%%%%%%%%%
NIRx.settings.Subj=Group;                  % Subj Name
NIRx.settings.Timing = D{1}.Timing;         % Zeitfenster in sec vor und nach dem Triggersignal 
NIRx.settings.Anfang=0;                     % festlegen beginn Task
NIRx.settings.Ende=12;                      % festlegen Ende Task 
NIRx.settings.baseline=1;                   % Baseline remove?
NIRx.settings.TPAnfang=1;                   % TP?
NIRx.settings.gUSBampNotch=true;               % Filter 50Hz from gUSBamp data (notch-Filter)
NIRx.settings.CAR=1;                        % CAR?
NIRx.settings.TFICA=0;                      % 0 ... TF, 1 ... ICA
NIRx.settings.MayerSorce=2;                      % 1 ... BPsys, 2 ... BPdia, 3 ... HR
NIRx.settings.corrmode= 3;                 % 0 ... uncorrected, 1 ... resp corrected, 2 ... mayer corrected, 3 ... mayer+resp corrected, 4 ... 3+puls, 5 ... onlyadaptivepuls, 6...onlinepuls 7 ... TP 0.125Hz
NIRx.settings.OptodeFailure=1;              % Consider OptodeFailure?
NIRx.settings.STD=1;
NIRx.settings.createFigures=true;           % determines if figures were created or not
NIRx.settings.kanal=1;                      % Channel to plot, 0 = all
NIRx.settings.probeset=47;                  % probeset 50 ; 12 ; 38; 24; 47 99(neu für labor), 777 old sportsfNIRS Kanal, 888 fNIRS sports
if NIRx.settings.probeset==777
    NIRx.settings.AFChnUse=0;           % 0... keine AF kanäle laden, 1 ... AF kanäle inkludieren
end
NIRx.settings.ExCh=[];     % Channels not used for analysis
NIRx.settings.DisplaySteps=1;               % Anzeigen des ausgewï¿½hlten etg_kanals
NIRx.settings.dispFreq=1.5;                 % Display frequency for spectra calculation 
NIRx.settings.Spectrasearch=0;              % 0 ... Global Window, 1 ... Individual Window
%%%global
NIRx.settings.gMayer=[0.07 0.13];
NIRx.settings.gResp=[0.2 0.4];
NIRx.settings.gPuls=[0.8 NIRx.settings.dispFreq];
%%%individual
NIRx.settings.Mayer=[[0.07 0.17],[0.03]];   % Searchwindow to find Resppeak and Removal plus/minus window around peak
NIRx.settings.Resp=[[0.20 0.5],[0.1]];      % Searchwindow to find Resppeak and Removal plus/minus window around peak
NIRx.settings.Puls=[[0.5 NIRx.settings.dispFreq],[0.5]];                    % Searchwindow to find Pulspeak and Removal plus/minus window around peak

%Dateibenennung:
if NIRx.settings.CAR==1
    NIRx.settings.Usage.CAR='_CAR_on_';
else
    NIRx.settings.Usage.CAR='_CAR_off_';
end

if NIRx.settings.corrmode==0
    NIRx.settings.Usage.corrmode='uncorr';
    PathCorrmode = 'uncorr';
elseif NIRx.settings.corrmode==1
    NIRx.settings.Usage.corrmode='_resp_corr';
    PathCorrmode = 'resp_corr';
elseif NIRx.settings.corrmode==2
    NIRx.settings.Usage.corrmode='_mayer_corr';
    PathCorrmode = 'mayer_corr';
elseif NIRx.settings.corrmode==3
    NIRx.settings.Usage.corrmode='_mayer_and_resp_corr';
    PathCorrmode = 'mayer_resp_corr';
elseif NIRx.settings.corrmode==4
    NIRx.settings.Usage.corrmode='_mayer_resp_and_puls_corr';
    PathCorrmode = 'mayer_resp_puls_corr';
elseif NIRx.settings.corrmode==5
    NIRx.settings.Usage.corrmode='_adap_puls';    
    PathCorrmode = 'adap_puls';
elseif NIRx.settings.corrmode==6
    NIRx.settings.Usage.corrmode='_online_puls';  
    PathCorrmode = 'online_puls';
elseif NIRx.settings.corrmode==7
    NIRx.settings.Usage.corrmode='TP_Zhang'; 
    PathCorrmode = 'TP_Zhang';
end

if NIRx.settings.TFICA==0
    NIRx.settings.Usage.TFICA='TF';
else
    NIRx.settings.Usage.TFICA='ICA';
end

AnalysePath = ['Analyse\', PathCorrmode, '\', Task];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Überprüfung ob alle Kanäle verwendet werden%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if NIRx.settings.probeset==50
elseif NIRx.settings.probeset==12
    NIRx.hdr.Sources=5;
    NIRx.hdr.Detectors=4;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:NIRx.settings.probeset);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:NIRx.settings.probeset);
elseif NIRx.settings.probeset==38
    NIRx.hdr.Sources=9;
    NIRx.hdr.Detectors=24;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:NIRx.settings.probeset);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:NIRx.settings.probeset);
elseif NIRx.settings.probeset==24 %reduktion des 38er adapt filt
    NIRx.hdr.Sources=9;
    NIRx.hdr.Detectors=24;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:NIRx.settings.probeset);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:NIRx.settings.probeset);
elseif NIRx.settings.probeset==47 
    NIRx.hdr.Sources=16;
    NIRx.hdr.Detectors=15;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:NIRx.settings.probeset);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:NIRx.settings.probeset);
    
elseif NIRx.settings.probeset==99 %neu labor
    NIRx.hdr.Sources=9;
    NIRx.hdr.Detectors=8;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:24);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:24);
elseif NIRx.settings.probeset==777 %sportsfNIRS_old
    if NIRx.settings.AFChnUse
    NIRx.hdr.Sources=14;
    NIRx.hdr.Detectors=23;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:52);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:52);    
    else
    NIRx.hdr.Sources=14;
    NIRx.hdr.Detectors=13;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:42);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:42); 
    end
elseif NIRx.settings.probeset==888 %neu fNIRS_sports
    NIRx.hdr.Sources=16;
    NIRx.hdr.Detectors=22;
    NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    NIRx.Data.wl760=NIRx.Data.wl760(:,1:61);
    NIRx.Data.wl830=NIRx.Data.wl830(:,1:61);
end
disp('Settings made.');

%%
% Erzeuge Analysefolder
mkdir([DataPath, Group,'\', AnalysePath]);
disp('Analyse folder created');

%%
%%%%%%%%%%%%%%%%
%%%AUSWERTUNG%%%
%%%%%%%%%%%%%%%%
try
disp('Auswertung start');
ImageClass=D{1}.ImageClass{1};
fs=NIRx.hdr.SamplingRate{1}; % Sampling rate of NIRS
BPfs = NIRx.hdr.BPSamplingRate; % Sampling rate of CNAP
ClassLabels=NIRx.hdr.Markers.Class; % Conditions of markers
Trigger=NIRx.hdr.Markers.Time; % Time while marker was received

if NIRx.hdr.Bool.gUSBamp
    gUSBampfs = NIRx.hdr.gUSBampSamplingRate; % Sampling rate of gUSBamp
else
    gUSBampfs = 0;
end
    
%Auswahl der Trigger
if strcmp(ImageClass,'MA')
    ClassLabels(D{1}.MA==1)=0;

    trig = Trigger(ClassLabels==2);
end
if strcmp(ImageClass,'FS')
    ClassLabels(D{1}.FS==1)=0;

    trig = Trigger(ClassLabels==3);
end
if strcmp(ImageClass,'OQ')
    ClassLabels(D{1}.OQ==1)=0;

    trig = Trigger(ClassLabels==4);
end

% Falls keine Trigger fuer condition gefunden werden
if isempty(trig)
    disp(['No triggers for condition ' ImageClass ' found. Execution stopped!']);
    return;
end

%%%% selbes gsatzl ist auch um Zeile 558 nocheinmal, jedoch mit NIRS fs und
SollAktivierung = zeros(size(NIRx.Data.BPdia,1),1)*0;  %% *0 um sicher auf 0 zu sein????
if NIRx.hdr.Bool.gUSBamp
    SollAktivierung2 = zeros(size(NIRx.Data.Resp,1),1)*0;  %% *0 um sicher auf 0 zu sein????
    
    % notch-Filter data at 50Hz (see help for iirnotch)
    if NIRx.settings.gUSBampNotch
        Wo = 50/(round(gUSBampfs)/2);
        BW = Wo/35; 
        [b,a] = iirnotch(Wo,BW);
        NIRx.Data.ecg = filter(b,a,NIRx.Data.ecg);
        NIRx.Data.Resp = filter(b,a,NIRx.Data.Resp);
    end
else
    SollAktivierung2 = 0;
end

%%%% SollAktivierung überall eins wo signal aktiv
for i = 1:length(trig)
    [idx idx] = min(abs(NIRx.Time.BP - trig(i)));
    SollAktivierung(idx + [round(NIRx.settings.Anfang*BPfs):round(NIRx.settings.Ende*BPfs)]) = 1;
    
    if NIRx.hdr.Bool.gUSBamp
        [idx idx] = min(abs(NIRx.Time.gUSBamp - trig(i)));
        SollAktivierung2(idx + [round(NIRx.settings.Anfang*gUSBampfs):round(NIRx.settings.Ende*gUSBampfs)]) = 1;
    end
end    
clear i idx

if NIRx.settings.createFigures
    %Verlaufplot
    verlauf_physio(NIRx, SollAktivierung, SollAktivierung2, Group, DataPath, AnalysePath, Task, ImageClass, BPfs, gUSBampfs);

    %Mittelung
    mittelung_Physio(NIRx, Group, DataPath, AnalysePath, Task, ImageClass, trig, BPfs, gUSBampfs); 
end

%Konzentrationsberechnung
[deoxy_signal, oxy_signal]=Konzentrationsberechnung_NIRx(NIRx); % Wird nach baseline removal und tp-filterung einfach überschrieben

disp('Auswertung finished');

catch AE
    disp(['Error message: ' AE.message]);
    
    if ~NIRx.hdr.Bool.BP
        disp('Error "Auswertung": No blood pressure data available.');
    end

    if ~NIRx.hdr.Bool.gUSBamp
        disp('Error "Auswertung": No gUSBamp data available.');
    end 
end %try

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Removal Baseline and TP Filtering%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[oxy_signal, deoxy_signal,NIRx]=doblno_NIRx(oxy_signal(:,:),deoxy_signal(:,:),NIRx, fs); 
disp('Baseline removal and TP filtering done');

%%
%%%%%%%%%%%%%%%%%
%%%RAW Spectra%%%
%%%%%%%%%%%%%%%%%
disp('RAW Spectra start');
spect=[];
count=1;

for ChNr=1:1:size(oxy_signal,2) 
    if NIRx.settings.createFigures
        figure(3);
        orient landscape
    end
    
    [rOxy, rDeoxy]=Illustration_multichannel_spectra(ChNr, oxy_signal(:,ChNr), ...
        deoxy_signal(:,ChNr), fs, NIRx.settings.dispFreq, NIRx.settings.ExCh, NIRx,D);

    if ~isempty(rOxy)
        spect(:,1,count)=rOxy{1}.p;
        spect(:,2,count)=rDeoxy{1}.p;
        count=count+1;
        NIRx.Data.Spectra.Base=rOxy{1}.f;
    end
end
clear ChNr;

if NIRx.settings.createFigures
    gcf;
    orient landscape;
    if NIRx.settings.corrmode==0
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    elseif NIRx.settings.corrmode==7
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    else
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_RAW_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
    end
end

%Average [(de)oxy-Hb] spectra over all used channels
NIRx.Data.Spectra.allChraw=spect;
NIRx.Data.Spectra.raw=[];

for k = 1 : size(spect,2)
    NIRx.Data.Spectra.raw(:,k)=mean(spect(:,k,:),3); 
end
clear k;
disp('RAW spectra finished');

%%
%%%%%%%%%%%%%%%%%%%%
%%%Removal Physio%%%
%%%%%%%%%%%%%%%%%%%%

%Corr Mayer, Resp, ... 
[oxy_signal, deoxy_signal,NIRx]=Corr_NIRx(oxy_signal, deoxy_signal, NIRx, D);

%CAR
[oxy_signal, deoxy_signal]=CAR_NIRx(oxy_signal, deoxy_signal, NIRx, D);

disp('physio artefacts removed');
%%
%%%%%%%%%%%%%%%%%%%%%
%%%Cleaned Spectra%%%
%%%%%%%%%%%%%%%%%%%%%
disp('Cleaned spectra start');
spect=[];
count=1;

for ChNr=1:1:size(oxy_signal,2) 
    if NIRx.settings.createFigures
        figure(4);
        orient landscape
    end
    
    [rOxy, rDeoxy]=Illustration_multichannel_spectra(ChNr, oxy_signal(:,ChNr), ...
        deoxy_signal(:,ChNr),NIRx.hdr.SamplingRate{1}, NIRx.settings.dispFreq, NIRx.settings.ExCh, NIRx,D);
    
    if ~isempty(rOxy)
        spect(:,1,count)=rOxy{1}.p;
        spect(:,2,count)=rDeoxy{1}.p;
        count=count+1;
        NIRx.Data.Spectra.Base=rOxy{1}.f;
    end
    
end
clear ChNr;

if NIRx.settings.createFigures
    gcf;
    orient landscape;
    if NIRx.settings.corrmode==0
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_CLEAN_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_CLEAN_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    else
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_CLEAN_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_CLEAN_Spectra',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
    end
end

%Average [(de)oxy-Hb] spectra over all used channels
NIRx.Data.Spectra.allChcleaned=spect;
NIRx.Data.Spectra.cleaned=[];

for k = 1 : size(spect,2)
    NIRx.Data.Spectra.cleaned(:,k)=mean(spect(:,k,:),3); 
end
clear k;

disp('Cleaned spectra finished');
% return 
%%    
%%%%%%%%%%%%%%%%%%%%%
%%%Spectra Compare%%%
%%%%%%%%%%%%%%%%%%%%%    
disp('Spectra compare start');

if NIRx.settings.createFigures
    % Comparison raw and cleaned
    figure(5)
    % [oxy-Hb] raw
    p1 = NIRx.Data.Spectra.raw(:,1);
    f1 = NIRx.Data.Spectra.Base;
    Color=[1 0.6 0.6];
    idx = find(f1<=NIRx.settings.dispFreq);
    plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
    hold on
    % [deoxy-Hb] raw
    p1 = NIRx.Data.Spectra.raw(:,2);
    Color=[0.8 0.8 1];
    plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
    % [oxy-Hb] clean
    p1 = NIRx.Data.Spectra.cleaned(:,1);
    Color='r';
    idx = find(f1<=NIRx.settings.dispFreq);
    plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
    % [deoxy-Hb] clean
    p1 = NIRx.Data.Spectra.cleaned(:,2);
    Color='b';
    plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);        
    ylabel('Power spectrum ','FontSize',16,'FontWeight','bold')
    xlabel('f (Hz)','FontSize',16,'FontWeight','bold')
    title('Avg. Spectrum [(de)oxy-Hb] before and after physiological influence removal' ,'FontSize',12,'FontWeight','demi','Interpreter','none')
    legend('[oxy-Hb]_r_a_w','[deoxy-Hb]_r_a_w','[oxy-Hb]_c_l_e_a_n','[deoxy-Hb]_c_l_e_a_n')
end

%Kanalschleife
head_oxy=[];
head_deoxy=[];

t=1/fs:1/fs:length(deoxy_signal)/fs;

SollAktivierung = zeros(size(deoxy_signal,1),1)*0;
for i = 1 : length(trig)
    [idx idx] = min(abs(NIRx.Time.NIRS - trig(i)));
    
    SollAktivierung(idx+[round(NIRx.settings.Anfang*fs):round(NIRx.settings.Ende*fs)])=1;
end
clear i;


for i=1:1:size(oxy_signal,2)
    %Verlaufplot
    verlauf_NIRx(oxy_signal(:,i), deoxy_signal(:,i),NIRx, t, SollAktivierung, fs, i, Group, DataPath, AnalysePath, Task,ImageClass);

    %Mittelung
    [dat_avg, dat_std, t_trial, data_all_trials]=mittelung_NIRx([oxy_signal(:,i) deoxy_signal(:,i)],NIRx, trig, fs);
    
    head_oxy(:,i)=dat_avg(:,1);
    head_deoxy(:,i)=dat_avg(:,2); 
    head_oxy_std(:,i)=dat_std(:,1);
    head_deoxy_std(:,i)=dat_std(:,2); 
        
    NIRx.Data.AllTrialsOxy{i}(:,:)= data_all_trials(:,1,:);
    NIRx.Data.AllTrialsDeoxy{i}(:,:)= data_all_trials(:,2,:);  

    i=i+1;
end
clear i;


%Optodenfehler eliminieren
[head_oxy, head_deoxy, head_oxy_std, head_deoxy_std]=Optodenfehler_NIRx(head_oxy, head_deoxy, head_oxy_std, head_deoxy_std, NIRx, D);

NIRx.Data.AVGOxy=head_oxy;
NIRx.Data.AVGDeoxy=head_deoxy;
NIRx.Data.AVGOxySTD=head_oxy_std;
NIRx.Data.AVGDeoxySTD=head_deoxy_std;
NIRx.settings.t_trial=t_trial;
NIRx.settings.fs=fs;                          

disp('Spectra compare finished')
%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%DARSTELLUNG%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%        

if NIRx.settings.createFigures
    %Darstellung mittel neu (optodenfehler)
    for c=1:1:size(oxy_signal,2)
         ni=figure(100);
         orient landscape
         darstellung_NIRx_sigma(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Group, DataPath, AnalysePath, Task,ImageClass)
         set(ni,'Name','Average of Channels 1-61 ','NumberTitle','off')
    end
    clear c;

    gcf;
    orient landscape;

    gcf;
    orient landscape;
    if NIRx.settings.corrmode==0
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Mittelung_der_Kanaele',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Mittelung_der_Kanaele',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    else
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Mittelung_der_Kanaele',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Mittelung_der_Kanaele',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
    end
end

%%%sichern für classifikation
NIRx.Data.oxy_Hb=oxy_signal;
NIRx.Data.deoxy_Hb=deoxy_signal;

if NIRx.settings.CAR==1
    save ([DataPath, Group,'\', AnalysePath, '\',Group '_cleaned_Data_CAR_on','.mat'],'NIRx')
else
    save ([DataPath, Group,'\', AnalysePath, '\',Group '_cleaned_Data_CAR_off','.mat'],'NIRx')
end
%NIRxPlotHead

%Daten sichern
if NIRx.settings.corrmode==0
    save ([DataPath, Group,'\', AnalysePath, '\',Group,'_',Task,'_',ImageClass, '_','Processed_Data', NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode, '.mat'],'NIRx')
else
    save ([DataPath, Group,'\', AnalysePath, '\',Group,'_',Task,'_',ImageClass, '_','Processed_Data',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode, '.mat'],'NIRx')
end

if NIRx.settings.createFigures
    %TopoPlot
    topoplotsSingle = 0; % 0: one figure for all topoplots 
    NIRxPlotHead
end

disp('Calculation finished');
