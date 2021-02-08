clear all
close all


%%%Comparison between all aproaches
path='C:\Users\Günther Bauernfeind\Desktop\Analyse_NIRx_AF\';

subj='test';
RelChan=22; %interessanter kanal
ShowKanal=1;
STD=0;



%raw data
load([path,subj,'\AF_',subj,'_Daten_CAR_off_uncorr.mat']);
Type=1;

head_oxy=NIRx.Data.AVGOxy;
head_deoxy=NIRx.Data.AVGDeoxy;
head_oxy_std=NIRx.Data.AVGOxySTD;
head_deoxy_std=NIRx.Data.AVGDeoxySTD;
fs=NIRx.settings.fs;
NIRx.settings.DisplaySteps=ShowKanal;
NIRx.settings.kanal=RelChan;
NIRx.settings.STD=STD;
t_trial=NIRx.settings.t_trial;

%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma_compare(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Type)
     set(ni,'Name',['Mittelung der Kanaele 1-24 '],'NumberTitle','off')
end

%CAR data
load([path,subj,'\AF_',subj,'_Daten_CAR_on_uncorr.mat']);
Type=2;

head_oxy=NIRx.Data.AVGOxy;
head_deoxy=NIRx.Data.AVGDeoxy;
head_oxy_std=NIRx.Data.AVGOxySTD;
head_deoxy_std=NIRx.Data.AVGDeoxySTD;
fs=NIRx.settings.fs;
NIRx.settings.DisplaySteps=ShowKanal;
NIRx.settings.kanal=RelChan;
NIRx.settings.STD=STD;
t_trial=NIRx.settings.t_trial;

%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma_compare(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Type)
     set(ni,'Name',['Mittelung der Kanaele 1-24 '],'NumberTitle','off')
end

%TF data
load([path,subj,'\AF_',subj,'_Daten_CAR_off_TF_mayer_resp_and_puls_corr.mat']);
Type=3;

head_oxy=NIRx.Data.AVGOxy;
head_deoxy=NIRx.Data.AVGDeoxy;
head_oxy_std=NIRx.Data.AVGOxySTD;
head_deoxy_std=NIRx.Data.AVGDeoxySTD;
fs=NIRx.settings.fs;
NIRx.settings.DisplaySteps=ShowKanal;
NIRx.settings.kanal=RelChan;
NIRx.settings.STD=STD;
t_trial=NIRx.settings.t_trial;

%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma_compare(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Type)
     set(ni,'Name',['Mittelung der Kanaele 1-24 '],'NumberTitle','off')
end

%ICA data
load([path,subj,'\AF_',subj,'_Daten_CAR_off_ICA_mayer_resp_and_puls_corr.mat']);
Type=4;

head_oxy=NIRx.Data.AVGOxy;
head_deoxy=NIRx.Data.AVGDeoxy;
head_oxy_std=NIRx.Data.AVGOxySTD;
head_deoxy_std=NIRx.Data.AVGDeoxySTD;
fs=NIRx.settings.fs;
NIRx.settings.DisplaySteps=ShowKanal;
NIRx.settings.kanal=RelChan;
NIRx.settings.STD=STD;
t_trial=NIRx.settings.t_trial;

%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma_compare(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Type)
     set(ni,'Name',['Mittelung der Kanaele 1-24 '],'NumberTitle','off')
end

%Zhang TP data
load([path,subj,'\AF_',subj,'_Daten_CAR_off_TP_Zhang.mat']);
Type=5;

head_oxy=NIRx.Data.AVGOxy;
head_deoxy=NIRx.Data.AVGDeoxy;
head_oxy_std=NIRx.Data.AVGOxySTD;
head_deoxy_std=NIRx.Data.AVGDeoxySTD;
fs=NIRx.settings.fs;
NIRx.settings.DisplaySteps=ShowKanal;
NIRx.settings.kanal=RelChan;
NIRx.settings.STD=STD;
t_trial=NIRx.settings.t_trial;

%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma_compare(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Type)
     set(ni,'Name',['Mittelung der Kanaele 1-24 '],'NumberTitle','off')
end


