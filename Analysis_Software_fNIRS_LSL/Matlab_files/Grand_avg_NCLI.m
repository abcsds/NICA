%Grand_avg_NCLI(Yes/No)
 
clear all
close all
warning off
current_path=pwd;
current_drive=current_path(1);        
DatenPath=[current_drive,':\foe_2015_bauernfeind\Daten\'];                % Datenordner



i=0;
% init
Session='Grand'; %Single %Grand
Type='CAR_1'; %CAR_0 oder CAR_1
modality='FS'; %TS %FS %OQ %OQ_TS %OQ_FS       
fs=3;
Timing = [-5 10];      % Zeitfenster in sec vor und nach dem Triggersignal 
Liniendicke=2;          % festlegen der Liniendicke
Anfang=0;               % festlegen beginn Task 
Ende=0;                % festlegen Ende Task 
t_trial = [Timing(1)*fs:1:Timing(2)*fs-1];
Kanal=43; %Dargestellter Kanal
TimePointList={[-5 -2.5];[0 2.5];[2.5 5]; [5 7.5]; [7.5 10]}; %%%Windows für Analyse und Topo

if strcmp(Session, 'Single')
    
    G.FileName{i+1}='DE1'; %Beispiel
    G.FileTS{i+1}=[1 1 0 0 1 1 0 0 1 0 ... %Nur wenn OQ_TS oder OQ_FS gewählt relevant
                   1 1 0 1 0 1 0 0 1 0];
               
    i=i+1;
    
    MeasurementID=G.FileName{1};
    
elseif strcmp(Session, 'Grand')

    G.FileName{i+1}='CC9';
%     G.FileTS{i+1}=[1 0 1 1 0 0 0 1 0 1 ... %1 = TS; Nur wenn OQ_TS oder OQ_FS gewählt relevant
%                    0 1 0 1 1 0 0 1 0 1];
    i=i+1;
    G.FileName{i+1}='DA9';
    %G.FileTS{i+1}=[0 0 1 1 0 1 0 0 1 1 ... % NOCH eintragen !!!!!
    %              1 0 0 0 0 1 1 1 1 0];
    i=i+1;
    G.FileName{i+1}='DB4';
    %G.FileTS{i+1}=[0 1 0 0 0 1 0 1 1 0 ... % NOCH eintragen !!!!!
    %               1 0 0 0 1 0 0 1 1 0];
    i=i+1;
    G.FileName{i+1}='DD6';
    %G.FileTS{i+1}=[0 1 0 0 0 1 0 1 0 1 ... % NOCH eintragen !!!!!
    %               0 0 1 0 1 0 0 1 1 0];
    i=i+1;
    G.FileName{i+1}='DD8';
    %G.FileTS{i+1}=[0 1 0 0 0 0 1 1 1 0 ... % NOCH eintragen !!!!!
    %               1 0 1 0 1 0 0 1 1 0];
    i=i+1;
    G.FileName{i+1}='DE1';
    %G.FileTS{i+1}=[1 1 0 0 1 1 0 0 1 0 ... % NOCH eintragen !!!!!
    %               1 1 0 1 0 1 0 0 1 0];
    i=i+1;
    
    MeasurementID='Grand';
end

% Erzeuge Analysefolder
mkdir([DatenPath, '\Analyse']);
if strcmp(Session, 'Single')
    if strcmp(Type, 'CAR_0')
        mkdir([DatenPath, '\Analyse\', G.FileName{1},'\CAR_0']);
    elseif strcmp(Type, 'CAR_1')
        mkdir([DatenPath, '\Analyse\', G.FileName{1},'\CAR_1']);
    end
elseif strcmp(Session, 'Grand')
    if strcmp(Type, 'CAR_0')
        mkdir([DatenPath, '\Analyse\Grand\CAR_0']);
    elseif strcmp(Type, 'CAR_1')
        mkdir([DatenPath, '\Analyse\Grand\CAR_1']);
    end
end


for ii=1:1:i
    pfad=([DatenPath, G.FileName{ii}, '/Analyse/',Type,'/'  modality(1:2),'/']);
        if strcmp(Type, 'CAR_0')
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
        elseif strcmp(Type, 'CAR_1')
            load([pfad,G.FileName{ii},'_cleaned_Data_CAR_on.mat']);
        end
     
        if strcmp(Session, 'Single')
            Gruppe=G.FileName{ii};
            
            for nr_trials=1:1:size(NIRx.Data.AllTrialsOxy{1,1},2)
                for nr_ch=1:1:size(NIRx.Data.AllTrialsOxy,2)
                ges_head_oxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsOxy{1,nr_ch}(:,nr_trials);
                ges_head_deoxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsDeoxy{1,nr_ch}(:,nr_trials);
                end
            end
            
            if strcmp(modality, 'OQ')
            elseif strcmp(modality, 'OQ_TS')
               excluded=find(G.FileTS{1}==0);
               ges_head_oxy(:,:,excluded)=[]; 
               ges_head_deoxy(:,:,excluded)=[]; 
            elseif strcmp(modality, 'OQ_FS')
               excluded=find(G.FileTS{1}==1);
               ges_head_oxy(:,:,excluded)=[];
               ges_head_deoxy(:,:,excluded)=[];
            end
            
        elseif strcmp(Session, 'Grand')
            Gruppe='Grand';
            
            %für OQ_TS / FS
                if strcmp(modality, 'OQ_TS')
                    for nr_trials=1:1:size(NIRx.Data.AllTrialsOxy{1,1},2)
                        for nr_ch=1:1:size(NIRx.Data.AllTrialsOxy,2)
                           tmp_head_oxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsOxy{1,nr_ch}(:,nr_trials);
                           tmp_head_deoxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsDeoxy{1,nr_ch}(:,nr_trials);
                        end
                    end                    
                    excluded=find(G.FileTS{ii}==0);
                    tmp_head_oxy(:,:,excluded)=[]; 
                    tmp_head_deoxy(:,:,excluded)=[]; 
                    ges_head_oxy(:,:,ii)=mean(tmp_head_oxy,3);
                    ges_head_deoxy(:,:,ii)=mean(tmp_head_deoxy,3);                   
                    
                elseif strcmp(modality, 'OQ_FS')
                    for nr_trials=1:1:size(NIRx.Data.AllTrialsOxy{1,1},2)
                        for nr_ch=1:1:size(NIRx.Data.AllTrialsOxy,2)
                            tmp_head_oxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsOxy{1,nr_ch}(:,nr_trials);
                            tmp_head_deoxy(:,nr_ch,nr_trials)=NIRx.Data.AllTrialsDeoxy{1,nr_ch}(:,nr_trials);
                        end
                    end                    
                    excluded=find(G.FileTS{ii}==1);
                    tmp_head_oxy(:,:,excluded)=[];
                    tmp_head_deoxy(:,:,excluded)=[]; 
                    ges_head_oxy(:,:,ii)=mean(tmp_head_oxy,3);
                    ges_head_deoxy(:,:,ii)=mean(tmp_head_deoxy,3);                    
                    
                else    
                ges_head_oxy(:,:,ii)=NIRx.Data.AVGOxy(:,:);
                ges_head_deoxy(:,:,ii)=NIRx.Data.AVGDeoxy(:,:);
                end
            
        end
    

end    
        
    head_oxy=mean(ges_head_oxy,3);
    head_deoxy=mean(ges_head_deoxy,3);
    head_oxy_std=std(ges_head_oxy,0,3)/sqrt(size(ges_head_oxy,3));
    head_deoxy_std=std(ges_head_deoxy,0,3)/sqrt(size(ges_head_oxy,3));        
        
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%DARSTELLUNG%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%        
NIRx.settings.kanal=Kanal;
%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Gruppe)
     set(ni,'Name',['Mittelung der Kanaele 1-61 '],'NumberTitle','off')
end




gcf
orient landscape  
if strcmp(Session, 'Single')
    if strcmp(Type, 'CAR_0')
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
    elseif strcmp(Type, 'CAR_1')
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\CAR_1\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\CAR_1\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');        
    end
elseif strcmp(Session, 'Grand')
    if strcmp(Type, 'CAR_0')
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');          
    elseif strcmp(Type, 'CAR_1')
       print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\CAR_1\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
       saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\CAR_1\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');         
    end    
end    


%%%%%%%
%Topo%%
%%%%%%%
 NIRxXls_Grand_avg_NCLI
 NIRxPlotHead_Grand_avg_NCLI

return
%%%%%%%






