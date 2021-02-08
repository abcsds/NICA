current_path=pwd;
cd ..;
sub_path=pwd;
cd (current_path);
%current_drive=current_path(1);
%addpath(genpath('P:\brunner\Toolboxes\BioSig'))
%addpath(genpath('D:\NCLI daten scripts\BioSig'))
addpath(genpath([sub_path,'\BioSig']));
disp('Toolbox loaded');
%addpath(genpath('P:\bauernfeind\EEG_old\eeglab2008October01_beta\functions'))
% addpath(genpath('D:\NCLI daten scripts\EEGlab\EEG_old\eeglab2008October01_beta\functions'))
addpath(genpath([sub_path,'\EEGlab\EEG_old\eeglab2008October01_beta\functions']));
disp('Topoplot loaded');
addpath(genpath([sub_path,'\xdf_reader']));
disp('XDF-Reader loaded');

clear sub_path;
% Call Psychtoolbox-3 specific startup function:
if exist('PsychStartup'), PsychStartup; end;

