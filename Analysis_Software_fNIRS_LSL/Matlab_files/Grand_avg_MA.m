%Grand_avg
% Modified 04.03.2016
% Bachmaier Dominik
% Changes: Adapted to new version of NIRS setup including LSL recorder

clear all
close all
warning off

current_path=pwd;
current_drive=current_path(1);
DataPath=['D:\Geschäftlich\UNI\Masterarbeit\Messungen']; % Directory of all subject                % Datenordner


%%
%%%%%%%%%%%%%%%%%
%%%%%% init %%%%%
%%%%%%%%%%%%%%%%%

i=1;

Session='Grand'; %Single %Grand
Type='mayer_resp_corr'; %uncorr, mayer_resp_corr
Add_CAR=1; %0 NO, 1 YES (in addition to Type) %not implemented in total!
modality='MA'; %attend  %control %ignor
fs=4;
Timing = [-5 20];      % Zeitfenster in sec vor und nach dem Triggersignal
Liniendicke=2;          % festlegen der Liniendicke
Anfang=0;               % festlegen beginn Task
Ende=12;                % festlegen Ende Task
t_trial = [Timing(1)*fs:1:Timing(2)*fs-3]; D=[];
Kanal=43; % Dargestellter Kanal
TimePointList={[-5 -2.5];[-2.5 0];[0 4];[4 8];[8 12];[12 14];[14 18]};%{[-5 -3];[-2.5 -0.5];[0 1.5];[2 3.5];[4 5.5];[6 7.5];[8 9.5];[10 11.5];[12 13.5];[14 15.5];[16 17.5];[18 19.5]}; % Windows für Analyse und Topo
ExCh=[];%1,2,6,7,8,12,21,35,37,47];     % Channels not used for analysis i.e.:[1 2 13 15 16 33 35 47]
OptodeFailure=1;              % Consider OptodeFailure? 1 = YES


if strcmp(Session, 'Single')
    G.FileName{i}='20160413'; %Beispiel
    %%%OptodeFailure nur in single!
%       D{i}.OptodeFailure{1}={ 6 ;[ 4, 21 ]}; 
%       D{i}.OptodeFailure{2}={ 7 ;[ 9, 25 ]};
%       D{i}.OptodeFailure{3}={ 8 ;[ 26, 23 ]};
%       D{i}.OptodeFailure{4}={ 16 ;[ 15, 35 ]};
%       D{i}.OptodeFailure{5}={ 33 ;[ 13, 15 ]};
%       D{i}.OptodeFailure{6}={ 34 ;[ 14, 45 ]};

    G.Filecontrol{i}= [0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    
 
    i=i+1;
                   
    G.FileName{i}='20160421_alex'; %Beispiel
    %%%OptodeFailure nur in single!
      D{i}.OptodeFailure{1}={ 6 ;[ 4, 21 ]}; 
      D{i}.OptodeFailure{2}={ 7 ;[ 9, 25 ]};
      D{i}.OptodeFailure{3}={ 8 ;[ 26, 23 ]};
      D{i}.OptodeFailure{4}={ 16 ;[ 15, 35 ]};
      D{i}.OptodeFailure{5}={ 33 ;[ 13, 15 ]};
      D{i}.OptodeFailure{6}={ 34 ;[ 14, 45 ]};

    G.Filecontrol{i}= [1 1 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       1 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       1 0 0 0 0 0 0 0 0 0 0 0 0 0];
                   
    i=i+1;
    
    G.FileName{i}='20160421_babs'; %Beispiel
    %%%OptodeFailure nur in single!
      D{i}.OptodeFailure{1}={ 4 ;[ 3, 5 ]}; 
      D{i}.OptodeFailure{2}={ 10 ;[ 5, 11, 29 ]};
      D{i}.OptodeFailure{3}={ 8 ;[ 26, 23, 21 ]};
      D{i}.OptodeFailure{4}={ 20 ;[ 18, 19 ]};
      D{i}.OptodeFailure{5}={ 25 ;[ 26, 9]}; 
      D{i}.OptodeFailure{6}={ 27 ;[ 11, 28, 42]};   
      D{i}.OptodeFailure{7}={ 29 ;[ 30, 31]};
      D{i}.OptodeFailure{8}={ 14 ;[ 34, 31, 13]};
      D{i}.OptodeFailure{9}={ 22 ;[ 5, 21, 24, 36]};
      D{i}.OptodeFailure{10}={ 33 ;[ 13, 15, 34]};

    G.Filecontrol{i}= [0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                         0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                         0 0 0 0 0 0 0 0 0 0 0 0 0 0];
                     
    i=i+1;

    G.FileName{i}='20160421_mario'; %Beispiel
    %% OptodeFailure nur in single!
    D{i}.OptodeFailure{1}={ 7 ;[ 9, 25 ]};
    D{i}.OptodeFailure{2}={ 8 ;[ 23, 26, 21, 25 ]};
    
    G.Filecontrol{i}= [1 0 0 0 0 0 0 0 0 0 0 0 0 1 ...
                       1 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       0 0 1 1 1 1 1 1 1 1 1 1 1 0];

   i=i+1;
    
    
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%     %%%%%%% Special breath task %%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     i=1;
% 
% Session='Single'; %Single %Grand
% Type='mayer_resp_corr'; %uncorr, mayer_resp_corr
% Add_CAR=0; %0 NO, 1 YES (in addition to Type) %not implemented in total!
% modality='MA'; %attend  %control %ignor
% fs=4;
% Timing = [-2 108];      % Zeitfenster in sec vor und nach dem Triggersignal
% Liniendicke=2;          % festlegen der Liniendicke
% Anfang=0;               % festlegen beginn Task
% Ende=60;                % festlegen Ende Task
% t_trial = [Timing(1)*fs:1:Timing(2)*fs-3]; D=[];
% Kanal=43; % Dargestellter Kanal
% TimePointList={[-2 0];[0 5];[5 15];[15 30];[30 45];[45 60];[60 70];[70 90];[90 100]};%{[-5 -3];[-2.5 -0.5];[0 1.5];[2 3.5];[4 5.5];[6 7.5];[8 9.5];[10 11.5];[12 13.5];[14 15.5];[16 17.5];[18 19.5]}; % Windows für Analyse und Topo
% ExCh=[6,7,8,21,47];     % Channels not used for analysis i.e.:[1 2 13 15 16 33 35 47]
% OptodeFailure=1;              % Consider OptodeFailure? 1 = YES


% if strcmp(Session, 'Single')
%     G.FileName{i}='20160511_breathhold'; %Beispiel
%     %%%OptodeFailure nur in single!
% %       D{i}.OptodeFailure{1}={ 6 ;[ 4, 21 ]}; 
% %       D{i}.OptodeFailure{2}={ 7 ;[ 9, 25 ]};
% %       D{i}.OptodeFailure{3}={ 8 ;[ 26, 23 ]};
% %       D{i}.OptodeFailure{4}={ 16 ;[ 15, 35 ]};
% %       D{i}.OptodeFailure{5}={ 33 ;[ 13, 15 ]};
% %       D{i}.OptodeFailure{6}={ 34 ;[ 14, 45 ]};
% 
%     G.Filecontrol{i}= [0 0 0 0 0 0];
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%% end %%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%
%     
%     i = i + 1;
      
    MeasurementID=G.FileName{1};
    
elseif strcmp(Session, 'Grand')
    
    G.FileName{i}='20160421_alex';
    G.Filecontrol{i}= [1 1 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       1 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       1 0 0 0 0 0 0 0 0 0 0 0 0 0];
    i=i+1;
    
%     G.FileName{i}='20160421_babs';
%     G.Filecontrol{i}= [0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
%                        0 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
%                        0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%     i=i+1;
    
    G.FileName{i}='20160421_mario';
    G.Filecontrol{i}= [1 0 0 0 0 0 0 0 0 0 0 0 0 1 ...
                       1 0 0 0 0 0 0 0 0 0 0 0 0 0 ...
                       0 0 1 1 1 1 1 1 1 1 1 1 1 0];
    i=i+1;
%     G.FileName{i}='DF5';
%     i=i+1;
%     G.FileName{i}='DF6';
%     i=i+1;
%     G.FileName{i}='DC7';
%     i=i+1;
%     G.FileName{i}='DB7';
%     i=i+1;
%     G.FileName{i}='DM5';
%     i=i+1;
%     G.FileName{i}='DM6';
%     i=i+1;
%     G.FileName{i}='DA9';
%     i=i+1;
    
    % %     G.Filecontrol{i}=[0 0 1 0 0 0 0 0 1 0 ... %Nur wenn Artefakt ==> 1
    % %                         0 0 1 1 0 0 1 0 1 0];
    % %
    % %     G.Fileattend{i}=[1 0 0 0 1 0 0 0 0 1 ... %Nur wenn Artefakt ==> 1
    % %                        0 0 0 0 0 1 1 0 1 0];
    % %
    % %     G.Fileignor{i}=[0 1 1 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
    % %                       1 0 0 1 1 1 1 0 0 0];
    %     i=i+1;
    
    %     G.FileName{i}='DF6';
    %     G.Filecontrol{i}=[0 0 0 0 0 0 0 0 0 1 ... %Nur wenn Artefakt ==> 1
    %                         0 0 0 0 0 0 0 0 0 0];
    %
    %     G.Fileattend{i}=[0 1 0 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
    %                        0 0 0 0 0 1 0 0 0 0];
    %
    %     G.Fileignor{i}=[0 0 0 0 1 1 0 0 0 0 ... %Nur wenn Artefakt ==> 1
    %                       0 0 1 1 0 0 1 0 1 0];
    
    %     i=i+1;
    
    
    MeasurementID='Grand';
end
disp('Settings made.');

%%
% Erzeuge Analysefolder
if mkdir([DataPath, '\Analyse'])
    disp('Analyse folder created.');
else
    disp('Analyse folder could not be created.');
end

%%
if strcmp(Session, 'Single')
    if strcmp(Type, 'uncorr')
        if Add_CAR
            mkdir([DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car']);
        else
            mkdir([DataPath, '\Analyse\', G.FileName{1},'\uncorr']);
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
            mkdir([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car']);
        else
            mkdir([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr']);
        end
    end
elseif strcmp(Session, 'Grand')
    if strcmp(Type, 'uncorr')
        if Add_CAR
            mkdir([DataPath, '\Analyse\Grand\uncorr\add_car']);
        else
            mkdir([DataPath, '\Analyse\Grand\uncorr']);
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
            mkdir([DataPath, '\Analyse\Grand\mayer_resp_corr\add_car']);
        else
            mkdir([DataPath, '\Analyse\Grand\mayer_resp_corr']);
        end
    end
end


for ii=1:1:i-1
    if strcmp(Session, 'Single')
        pfad=([DataPath, '\', G.FileName{ii}, '\Analyse\', Type, '\',  modality,'\']);
        if strcmp(Type, 'uncorr')
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);

        elseif strcmp(Type, 'mayer_resp_corr')
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
        end
        Gruppe=G.FileName{ii};
        
        for nr_trials=1:1:size(NIRx.Data.AllTrialsOxy{1,1},2)
            for nr_ch=1:1:size(NIRx.Data.AllTrialsOxy,2)
                ges_head_oxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsOxy{1,nr_ch}(:,nr_trials);
                ges_head_deoxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsDeoxy{1,nr_ch}(:,nr_trials);
            end
        end
        
        if strcmp(modality, 'control')
            excluded=find(G.Filecontrol{1}==1);
            ges_head_oxy(:,:,excluded)=[];
            ges_head_deoxy(:,:,excluded)=[];
        elseif strcmp(modality, 'attend')
            excluded=find(G.Fileattend{1}==1);
            ges_head_oxy(:,:,excluded)=[];
            ges_head_deoxy(:,:,excluded)=[];
        elseif strcmp(modality, 'ignor')
            excluded=find(G.Fileignor{1}==1);
            ges_head_oxy(:,:,excluded)=[];
            ges_head_deoxy(:,:,excluded)=[];
        end
        
    elseif strcmp(Session, 'Grand')
        pfad=([DataPath, '\', G.FileName{ii}, '\Analyse\',Type,'\',  modality,'\']);
        if strcmp(Type, 'uncorr')
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
        elseif strcmp(Type, 'mayer_resp_corr')
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
        end
        if Add_CAR
            load([DataPath, '\Analyse\', G.FileName{ii},'\',Type,'\add_car\',G.FileName{ii},'_',modality,'.mat']);
        else
            load([DataPath, '\Analyse\', G.FileName{ii},'\',Type,'\',G.FileName{ii},'_',modality,'.mat']);
        end
        Gruppe='Grand';
        ges_head_oxy(:,:,ii)=Grand.Data.AVGOxy(:,:);
        ges_head_deoxy(:,:,ii)=Grand.Data.AVGDeoxy(:,:);
    end
end


NIRx.settings.ExCh=ExCh;
NIRx.settings.OptodeFailure=OptodeFailure;              % Consider OptodeFailure?
if strcmp(Session, 'Single')
    if Add_CAR
        [ges_head_oxy, ges_head_deoxy]=Add_CAR_NIRx(ges_head_oxy, ges_head_deoxy, NIRx,D);
    end
end

head_oxy=mean(ges_head_oxy,3);
head_deoxy=mean(ges_head_deoxy,3);
head_oxy_std=std(ges_head_oxy,0,3)/sqrt(size(ges_head_oxy,3));
head_deoxy_std=std(ges_head_deoxy,0,3)/sqrt(size(ges_head_oxy,3));

%Optodenfehler eliminieren
if strcmp(Session, 'Single')
    [head_oxy, head_deoxy, head_oxy_std, head_deoxy_std]=Optodenfehler_NIRx(head_oxy, head_deoxy, head_oxy_std, head_deoxy_std, NIRx, D);
end

Grand.Data.AVGOxy=head_oxy;
Grand.Data.AVGDeoxy=head_deoxy;

%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%DARSTELLUNG%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
NIRx.settings.kanal=Kanal;
%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
    ni=figure(100);
    orient landscape;
    darstellung_NIRx_sigma(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Gruppe)
    set(ni,'Name',['Mittelung der Kanaele 1-47 '],'NumberTitle','off')
end


gcf;
orient landscape;
if strcmp(Session, 'Single')
    if strcmp(Type, 'uncorr')
        if Add_CAR
            print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
            save ([DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'.mat'],'Grand')
        else
            print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
            save ([DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'.mat'],'Grand')
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
            print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
            save ([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'.mat'],'Grand')
        else
            print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
            save ([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'.mat'],'Grand')
        end
    end
elseif strcmp(Session, 'Grand')
    if strcmp(Type, 'uncorr')
        if Add_CAR
            print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');
        else
            print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
            print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');
        else
            print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Mittelung_der_Kanaele']);
            saveas(gcf, [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');
        end
    end
end


%%%%%%%
%Topo%%
%%%%%%%
NIRxXls_Grand_avg_MA
NIRxPlotHead_Grand_avg_MA

disp('Grand average finished!');
return
%%%%%%%
