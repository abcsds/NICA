
% Start installation...
disp('Creating folder structure...'); 

% Get current directory
NICA_HOME = fileparts(mfilename('fullpath'));

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

% Save the folder structure
try
    savepath;
    disp('Installation successful!');
catch ME
    disp(['Error message: ' ME.message]);
    disp('Could not save path permanently!');
    try
        status = savepath(NICA_HOME);
    catch ME
        status = 0;
        disp(['Error message: ' ME.message]);
    end
    % Installation finished
    if status
        disp('Installation successful!');
    else
        disp('Installation was not successful!');
    end
end
