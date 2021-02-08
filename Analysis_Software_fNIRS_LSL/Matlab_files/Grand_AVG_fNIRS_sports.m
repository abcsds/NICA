clear all
close all

%%%%%%%%%%%%%
%Daten Laden%
%%%%%%%%%%%%%

%Pfad festlegen
DatenPath='C:\Users\Günther Bauernfeind\Desktop\sports_fNIRS\Daten\';                % Lokal
clear D

i=0;
j=0;
s=0;
%File festlegen

% Task{s+1} = 'T'; s=s+1; 
% Task{s+1} = 'F'; s=s+1;
Task{s+1} = 'ME'; s=s+1;

%Typ
% Typ{j+1} = 'MI_1'; j=j+1;
% Typ{j+1} = 'Video'; j=j+1;
% Typ{j+1} = 'MI_2'; j=j+1;
Typ{j+1} = 'ME'; j=j+1;

%Subject

% FileName{i+1} ='AO8'; i=i+1;
% FileName{i+1} ='CM2'; i=i+1;
FileName{i+1} ='CM3'; i=i+1; % ME
FileName{i+1} ='CM4'; i=i+1; % ME


clear i s j EHK

%%%%%%%
%laden%
%%%%%%%
figPos = get(0, 'ScreenSize');


% k Schleife Typ
% h Schleife Subj
% m Schleife Task

for k=1:1:size(Typ,2)
    for m=1:1:size(Task,2)
        for h=1:1:size(FileName,2)
            
            load([DatenPath,FileName{h},'\', Typ{k},'\', FileName{h},'_',Typ{k},'_',Task{m},'_','Processed_Data_CAR_on_uncorr','.mat'])
            
            disp(['Loading... ', FileName{h},'_',Typ{k},'_',Task{m},'_','Processed_Data_CAR_on_uncorr','.mat'])
            
            ges_head_oxy(:,:,h)=NIRx.Data.AVGOxy;
            ges_head_deoxy(:,:,h)=NIRx.Data.AVGDeoxy;
            
            %clear NIRx
        end
        fs=NIRx.hdr.SamplingRate{1};
        Timing=NIRx.settings.Timing;
        t_trial = [round(Timing(1)*fs):1:round(Timing(2)*fs-1)];
        Gruppe=[Typ{k},'_',Task{m}];
        
        
        head_oxy=mean(ges_head_oxy,3);
        head_deoxy=mean(ges_head_deoxy,3);
        head_oxy_std=std(ges_head_oxy,0,3);
        head_deoxy_std=std(ges_head_deoxy,0,3);
        
        clear ges_head_oxy ges_head_deoxy
        
        
        for c=1:1:size(head_oxy,2)
             ni=figure(100);
             %orient landscape
             darstellung_NIRx_sigma(c,head_oxy(:,c),head_deoxy(:,c),head_oxy_std(:,c),head_deoxy_std(:,c), NIRx,t_trial,fs, Gruppe)
        end
        set(ni, 'outerposition', figPos);
        set(ni,'Name',['Grand AVG der Kanaele 1-61 '],'NumberTitle','off')
        
        print( '-djpeg', '-r300', [DatenPath,'Grand_avg','\', Typ{k},'_',Task{m},'_Grand_MultChMap']);
        saveas(gcf, [DatenPath,'Grand_avg','\', Typ{k},'_',Task{m},'_Grand_MultChMap'],'fig'); 
        
        
            
        
        
        NIRxPlotHead_Grand(DatenPath,head_oxy,head_deoxy,NIRx,Gruppe,fs);

        close all

        
    end
end
















  





