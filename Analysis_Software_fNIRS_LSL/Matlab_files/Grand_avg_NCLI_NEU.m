%Grand_avg_NCLI(Yes/No)
 
clear all
close all
warning off
current_path=pwd;
current_drive=current_path(1);        
DatenPath=[current_drive,':\foe_2015_bauernfeind\Daten\'];                % Datenordner



i=0;
% init
Session='Single'; %Single %Grand
Type='CAR_0'; %only CAR_0 
Add_CAR=1; %0 NO, 1 YES (in addition to Type) 
modality='OQ_FS'; %TS %FS %OQ %OQ_TS %OQ_FS       
fs=3;
Timing = [-5 25];      % Zeitfenster in sec vor und nach dem Triggersignal max [-5 25]
Liniendicke=2;          % festlegen der Liniendicke
Anfang=0;               % festlegen beginn Task 
Ende=0;                % festlegen Ende Task 
t_trial = [Timing(1)*fs:1:Timing(2)*fs-1];D=[];
Kanal=1; %Dargestellter Kanal
TimePointList={[-5 -2.5];[0 2.5];[2.5 5];[5 7.5];[7.5 10];[10 12.5];[12.5 15];[15 17.5];[17.5 20]}; %%%Windows für Analyse und Topo
ExCh=[];     % Channels not used for analysis [1 2 13 15 16 33 35 47]
OptodeFailure=1;              % Consider OptodeFailure? 1 = YES


if strcmp(Session, 'Single')
    
    G.FileName{i+1}='DB4'; %Beispiel
    G.FileTS{i+1}=[0 1 0 0 0 1 0 1 1 0 ... %1 = TS; Nur wenn OQ_TS oder OQ_FS gewählt relevant
                   1 0 0 0 1 0 0 1 1 0];
    %%%Artefakte nur in single!           
        G.FileArtefactFS{i+1}=[0 0 0 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
                               0 0 0 0 0 0 0 0 0 0 ...
                               0 0 0 0 0 0 0 0 0 0];
        G.FileArtefactTS{i+1}=[0 0 0 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
                               0 0 0 0 0 0 0 0 0 0 ...
                               0 0 0 0 0 1 0 0 0 0]; 
        G.FileArtefactOQ{i+1}=[0 0 0 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
                               0 0 0 0 0 0 0 0 0 0];  
    %%%OptodeFailure nur in single!
    D{1}.OptodeFailure{1}={[5];[6 7]}; 
    D{1}.OptodeFailure{2}={[8];[6 7 15 18 28]}; 
    D{1}.OptodeFailure{3}={[17];[4 7 10 18 19 20]}; 

%     D{1}.OptodeFailure{7}={[ ];[ ]};%...           
               
    i=i+1;
    
    MeasurementID=G.FileName{1};
    
elseif strcmp(Session, 'Grand')

%     G.FileName{i+1}='CC9';
%     i=i+1;
%     G.FileName{i+1}='DA9';
%     i=i+1;
%     G.FileName{i+1}='DB4';
%     i=i+1;
%     G.FileName{i+1}='DD6';
%     i=i+1;
%     G.FileName{i+1}='DD8';
%     i=i+1;
%     G.FileName{i+1}='DE1';
%     i=i+1;
    
    MeasurementID='Grand';
end

% Erzeuge Analysefolder
mkdir([DatenPath, '\Analyse']);
if strcmp(Session, 'Single')
    if Add_CAR
        mkdir([DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\add_car']);
    else 
        mkdir([DatenPath, '\Analyse\', G.FileName{1},'\CAR_0']);
    end
elseif strcmp(Session, 'Grand')
    if Add_CAR
        mkdir([DatenPath, '\Analyse\Grand\CAR_0\add_car']);
    else
        mkdir([DatenPath, '\Analyse\Grand\CAR_0']);
    end
end


for ii=1:1:i
    
  
        if strcmp(Session, 'Single')
            pfad=([DatenPath, G.FileName{ii}, '/Analyse/',Type,'/'  modality(1:2),'/']);
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
            Gruppe=G.FileName{ii};
            
            for nr_trials=1:1:size(NIRx.Data.AllTrialsOxy{1,1},2)
                for nr_ch=1:1:size(NIRx.Data.AllTrialsOxy,2)
                ges_head_oxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsOxy{1,nr_ch}(:,nr_trials);
                ges_head_deoxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsDeoxy{1,nr_ch}(:,nr_trials);
                end
            end
            
            if strcmp(modality, 'TS')
               excluded=find(G.FileArtefactTS{1}==1);
               ges_head_oxy(:,:,excluded)=[]; 
               ges_head_deoxy(:,:,excluded)=[]; 
            elseif strcmp(modality, 'FS')
               excluded=find(G.FileArtefactFS{1}==1);
               ges_head_oxy(:,:,excluded)=[]; 
               ges_head_deoxy(:,:,excluded)=[]; 
            elseif strcmp(modality, 'OQ')
               excluded=find(G.FileArtefactOQ{1}==1);
               ges_head_oxy(:,:,excluded)=[];
               ges_head_deoxy(:,:,excluded)=[];
            end
            
            
            if strcmp(modality, 'OQ')
            elseif strcmp(modality, 'OQ_TS') 
               excl_tmp=find(G.FileArtefactOQ{1}==1); 
               excluded=find(G.FileTS{1}==0);
               all_excluded=[excl_tmp,excluded];
               excluded=unique(all_excluded);
               ges_head_oxy(:,:,excluded)=[]; 
               ges_head_deoxy(:,:,excluded)=[]; 
            elseif strcmp(modality, 'OQ_FS')
               excl_tmp=find(G.FileArtefactOQ{1}==1); 
               excluded=find(G.FileTS{1}==1);
               all_excluded=[excl_tmp,excluded];
               excluded=unique(all_excluded);
               ges_head_oxy(:,:,excluded)=[];
               ges_head_deoxy(:,:,excluded)=[];
            end
            
        elseif strcmp(Session, 'Grand')
             pfad=([DatenPath, G.FileName{ii}, '/Analyse/',Type,'/'  modality(1:2),'/']);
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
            if Add_CAR
                pfad=([DatenPath, '\Analyse\', G.FileName{ii},'\CAR_0\add_car']);
            else 
                pfad=([DatenPath, '\Analyse\', G.FileName{ii},'\CAR_0']);
            end
            Gruppe='Grand';
            load([pfad,'\', G.FileName{ii},'_',modality,'.mat']);
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
    
        
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%DARSTELLUNG%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%        
NIRx.settings.kanal=Kanal;
NIRx.settings.Timing=Timing;

%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma(c,head_oxy(1:length(t_trial),c),head_deoxy(1:length(t_trial),c),head_oxy_std(1:length(t_trial),c),head_deoxy_std(1:length(t_trial),c), NIRx,t_trial,fs, Gruppe)
     set(ni,'Name',['Mittelung der Kanaele 1-61 '],'NumberTitle','off')
end




gcf
orient landscape  
if strcmp(Session, 'Single')
    if Add_CAR
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
       save ([DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\add_car\',G.FileName{1},'_',modality,'.mat'],'Grand')
    else
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
       save ([DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'.mat'],'Grand')
    end
elseif strcmp(Session, 'Grand')
    if Add_CAR
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\CAR_0\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\CAR_0\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');          
    else
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');         
    end    
end    


%%%%%%%
%Topo%%
%%%%%%%
 NIRxXls_Grand_avg_NCLI
 NIRxPlotHead_Grand_avg_NCLI

return
%%%%%%%






