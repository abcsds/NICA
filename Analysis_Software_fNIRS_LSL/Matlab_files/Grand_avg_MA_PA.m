%Grand_avg_MA(attend, control, ignor)
 
clear all
close all
warning off
current_path=pwd;
current_drive=current_path(1);        
DatenPath=[current_drive,':\foe_2015_bauernfeind\Daten\MA\'];                % Datenordner



i=0;
% init
Session='Single'; %Single %Grand  %%% Grand sollte mit diesen daten nicht verwendet werden!!!
Type='uncorr'; %uncorr, mayer_resp_corr
Add_CAR=1; %0 NO, 1 YES (in addition to Type) %not implemented in total!
modality='attend'; %attend  %control %ignor       
fs=3;
Timing = [-5 25];      % Zeitfenster in sec vor und nach dem Triggersignal 
Liniendicke=2;          % festlegen der Liniendicke
Anfang=0;               % festlegen beginn Task 
Ende=14.2;                % festlegen Ende Task 
t_trial = [Timing(1)*fs:1:Timing(2)*fs-1]; D=[];
Kanal=41; %Dargestellter Kanal
TimePointList={[1 6];[8 13];[15 20]}; %%% altes Zeitfenster [-2.5 0];[2.5 5];[5 7.5]; [7.5 10]; [10 12.5]; [12.5 15]; [15 17.5]; [17.5 20] %%%Windows für Analyse und Topo
ExCh=[1 2 3 13 14 15 16 17 18 20 33 34 35 37 45 46 47];     % PA08_1 Channels not used for analysis [1 2 3 15 16 17 18 20 35 37 47]
% ExCh=[1 2 3 5 17 18 19 20 36 37];     % PA08 Channels not used for analysis [1 2 3 5 17 18 19 20 36 37]
% PA08_2 [1 2 18 37 38]
OptodeFailure=1;              % Consider OptodeFailure? 1 = YES


if strcmp(Session, 'Single')
    
    G.FileName{i+1}='PA08'; %Beispiel
    %%%OptodeFailure nur in single!
%     D{1}.OptodeFailure{1}={[14];[12 13 29 33 34]}; %PA08_1
%     D{1}.OptodeFailure{2}={[44];[32 42 43 46]}; %PA08_1
%     D{1}.OptodeFailure{1}={[5];[4 17 19]}; %PA08_2
%     D{1}.OptodeFailure{2}={[12];[10 13 29]}; %PA08_2
%     D{1}.OptodeFailure{3}={[22];[19 23]}; %PA08_2 
%     D{1}.OptodeFailure{4}={[38];[24 36 40]}; %PA08_2 (für Grand Avg) %...
    
    G.Filecontrol{i+1}=[0 0 0 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
                        0 0 0 0 0 0 0 0 0 0];
               
    G.Fileattend{i+1}=[0 1 1 0 0 1 0 1 1 0 ...%Nur wenn Artefakt ==> 1
                       0 0 0 0 0 1 0 1 1 1 ...
                       0 0 0 1 0 0 0 0 0 1]; 
               
    G.Fileignor{i+1}=[0 0 0 0 0 0 0 1 1 1 ... %Nur wenn Artefakt ==> 1
                      0 0 0 0 1 1 1 1 1 0 ...                  
                      0 0 1 0 0 0 0 0 0 0];                     
                      
    i=i+1;
    
    MeasurementID=G.FileName{1};
    
elseif strcmp(Session, 'Grand')

    G.FileName{i+1}='PA08';
    i=i+1;
    G.FileName{i+1}='PA08_1';
    i=i+1;
    G.FileName{i+1}='PA08_2';
    i=i+1;
%     G.FileName{i+1}='run4';
%     i=i+1;
%     G.FileName{i+1}='run5';
%     i=i+1;
%     G.FileName{i+1}='run6';
%     i=i+1;
    
% %     G.Filecontrol{i+1}=[0 0 1 0 0 0 0 0 1 0 ... %Nur wenn Artefakt ==> 1
% %                         0 0 1 1 0 0 1 0 1 0];
% %                
% %     G.Fileattend{i+1}=[1 0 0 0 1 0 0 0 0 1 ... %Nur wenn Artefakt ==> 1
% %                        0 0 0 0 0 1 1 0 1 0]; 
% %                
% %     G.Fileignor{i+1}=[0 1 1 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
% %                       1 0 0 1 1 1 1 0 0 0];                    
%     i=i+1;
    
%     G.FileName{i+1}='DF6';
%     G.Filecontrol{i+1}=[0 0 0 0 0 0 0 0 0 1 ... %Nur wenn Artefakt ==> 1
%                         0 0 0 0 0 0 0 0 0 0];
%                
%     G.Fileattend{i+1}=[0 1 0 0 0 0 0 0 0 0 ... %Nur wenn Artefakt ==> 1
%                        0 0 0 0 0 1 0 0 0 0]; 
%                
%     G.Fileignor{i+1}=[0 0 0 0 1 1 0 0 0 0 ... %Nur wenn Artefakt ==> 1
%                       0 0 1 1 0 0 1 0 1 0];            
           
%     i=i+1;

    
    MeasurementID='Grand';
end

% Erzeuge Analysefolder
mkdir([DatenPath, '\Analyse']);
if strcmp(Session, 'Single')
    if strcmp(Type, 'uncorr')
        if Add_CAR
            mkdir([DatenPath, '\Analyse\', G.FileName{1},'\uncorr\add_car']);
        else
            mkdir([DatenPath, '\Analyse\', G.FileName{1},'\uncorr']);
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
            mkdir([DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car']);
        else
            mkdir([DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr']);
        end
    end
elseif strcmp(Session, 'Grand')
    if strcmp(Type, 'uncorr')
        if Add_CAR
            mkdir([DatenPath, '\Analyse\Grand\uncorr\add_car']);
        else
            mkdir([DatenPath, '\Analyse\Grand\uncorr']);
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
            mkdir([DatenPath, '\Analyse\Grand\mayer_resp_corr\add_car']);
        else
            mkdir([DatenPath, '\Analyse\Grand\mayer_resp_corr']);
        end
    end
end


for ii=1:1:i
%     pfad=([DatenPath, G.FileName{ii}, '/Analyse/',Type,'/'  modality,'/']);
%         if strcmp(Type, 'uncorr')
%             load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
%         elseif strcmp(Type, 'mayer_resp_corr')
%             load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
%         end
        
         
     
        if strcmp(Session, 'Single')
            pfad=([DatenPath, G.FileName{ii}, '/Analyse/',Type,'/'  modality,'/']);
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
            pfad=([DatenPath, G.FileName{ii}, '/Analyse/',Type,'/'  modality,'/']);
                if strcmp(Type, 'uncorr')
                    load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
                elseif strcmp(Type, 'mayer_resp_corr')
                    load([pfad,G.FileName{ii},'_cleaned_Data_CAR_off.mat']);
                end
            if Add_CAR
             load([DatenPath, '\Analyse\', G.FileName{ii},'\',Type,'\add_car\',G.FileName{ii},'_',modality,'.mat']);
            else
             load([DatenPath, '\Analyse\', G.FileName{ii},'\',Type,'\',G.FileName{ii},'_',modality,'.mat']);
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
        
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%DARSTELLUNG%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%        
NIRx.settings.kanal=Kanal;
%Darstellung mittel neu (optodenfehler)
for c=1:1:size(head_oxy,2)
     ni=figure(100);
     orient landscape
     darstellung_NIRx_sigma(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Gruppe)
     set(ni,'Name',['Mittelung der Kanaele 1-47 '],'NumberTitle','off')
end




gcf
orient landscape  
if strcmp(Session, 'Single')
    if strcmp(Type, 'uncorr')
        if Add_CAR
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
           save ([DatenPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'.mat'],'Grand')
        else
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig'); 
           save ([DatenPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'.mat'],'Grand')
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig'); 
           save ([DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'.mat'],'Grand')
        else
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Mittelung_der_Kanaele'],'fig');
           save ([DatenPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'.mat'],'Grand')
        end
    end
elseif strcmp(Session, 'Grand')
    if strcmp(Type, 'uncorr')
        if Add_CAR
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');   
        else
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');
        end
    elseif strcmp(Type, 'mayer_resp_corr')
        if Add_CAR
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');   
        else
           print( '-djpeg', '-r300', [DatenPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Mittelung_der_Kanaele']); 
           saveas(gcf, [DatenPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Mittelung_der_Kanaele'],'fig');             
        end
    end    
end    


%%%%%%%
%Topo%%
%%%%%%%
 NIRxXls_Grand_avg_MA
 NIRxPlotHead_Grand_avg_MA 

return
%%%%%%%






