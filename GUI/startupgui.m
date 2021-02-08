function handles = startupgui(handles)

% guiPath = fileparts(mfilename('fullpath'));
% folders = strfind(guiPath, filesep);
% nicaHome = guiPath(1:folders(end));
% 
% warning('off','all')
% 
% addpath(genpath([nicaHome 'Analysis_Software_fNIRS_LSL']));
% % addpath(genpath([nicaHome 'GUI']));
% % addpath(genpath([nicaHome 'User Settings']));
% 
% warning('on','all');

% --------------------------------------------------------------------------------------------------
% CREATE FOLDER STRUCTURE 

% Get current directory
guiPath = fileparts(mfilename('fullpath'));
folders = strfind(guiPath, filesep);
NICA_HOME = guiPath(1:folders(end));

% Add current directory
path(NICA_HOME,path);

% Directory with GUI files
path([NICA_HOME filesep 'GUI'],path);

% Directory with evaluation software
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL'],path);

% Directories with BioSig functions
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    'demo'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    'doc'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't200_FileAccess'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't250_ArtifactPreProcessingQualityControl'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't300_FeatureExtraction'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't400_Classification'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't450_MultipleTestStatistic'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't490_EvaluationCriteria'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't500_Visualization'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    't501_VisualizeCoupling'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    'viewer'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    'viewer' filesep 'help'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'BioSig' filesep ...
    'viewer' filesep 'utils'],path);

% Directories with EEGLab functions
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions' filesep 'adminfunc'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions' filesep 'miscfunc'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions' filesep 'popfunc'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions' filesep 'resources'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions' filesep 'sigprocfunc'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions' filesep 'studyfunc'],path);
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'EEGLab' filesep 'EEG_old' filesep ...
    'eeglab2008October01_beta' filesep 'functions' filesep 'timefreqfunc'],path);

% Directory with Matlab files
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'Matlab_files'],path);

% Directory with xdf-reader files
path([NICA_HOME filesep 'Analysis_Software_fNIRS_LSL' filesep 'xdf_reader'],path);
        

% --------------------------------------------------------------------------------------------------
% BASIC SETTINGS

handles.filenameSettings = [];
handles.DATA.analysisPathMain = [];

% Number of Channels
nrChannels = 61;

% Initialize status
handles.STATUS.hdr          = 0;
handles.STATUS.xdf          = 0;
handles.STATUS.settings     = 0;
handles.STATUS.analysisPath = 0;
handles.STATUS.grandAverage = 0;

% Initialize SETTINGS
handles.SETTINGS.channels.nr = nrChannels;                % Number of channels
handles.SETTINGS.channels.display = zeros(1,nrChannels);  % Channel-array
handles.SETTINGS.channels.exclude = zeros(1,nrChannels);  % Channel-array
handles.SETTINGS.baseline = 0;                            % Baseline removal
handles.SETTINGS.lowPass = 0;                             % Low-pass filter
handles.SETTINGS.notch = 0;                               % Notch filter
handles.SETTINGS.car = 0;                                 % Common average reference
handles.SETTINGS.excludeTrials.value = 0;
handles.SETTINGS.excludeTrials.array = [];
handles.SETTINGS.excludeChannels = 0;
handles.SETTINGS.optodeFail.value = 0;
handles.SETTINGS.optodeFail.cellArray = [];               % Optode Failure
handles.SETTINGS.generateFiguresHeartRate = 0;
handles.SETTINGS.generateFiguresBiosignals = 0;
handles.SETTINGS.generateFiguresRAW = 0;                  % Generate Figures RAW
handles.SETTINGS.generateFiguresBloodOxy = 0;
handles.SETTINGS.generateFiguresTopoplot = 0;
handles.SETTINGS.plotSTD = 0;
handles.SETTINGS.grandAverage.nrROIs = 0;
handles.SETTINGS.grandAverage.ROIs   = [];

% Directory of NIRx_GUI
filepath = fileparts(mfilename('fullpath'));
filepath = strrep(filepath,'\GUI',''); % remove the subdirectory
handles.NIRxGUIDirectory = filepath;

set(handles.textAnalysisStatus, 'String', 'Select an Analysis Path and Load your Data-Files');

end
