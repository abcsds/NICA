clear all
close all
warning off

addpath(genpath('/home/bauernfeind/Desktop/BCI/Offline'));
addpath(genpath('/mnt/public/brunner/Toolboxes/BioSig'));

here = pwd;
cd '/home/bauernfeind/Desktop/BCI/binaries'
setpath
cd(here)

% data = 'EEG/EEG_Laser_Daten/infile/EEG_N10_VEPRL.gdf' %'EEG/nirxlaserred.gdf' %'EEG/NIRx_LBstim_PP1.gdf'


strArray = java_array('java.lang.String', 2);
strArray(1) = java.lang.String('/mnt/data/oBCI/NIRx/EEG/EEG_Laser_Daten/infile/EEG_N10_PVL.gdf');
strArray(2) = java.lang.String('/mnt/data/oBCI/NIRx/EEG/EEG_Laser_Daten/infile/EEG_N09_PVL.gdf');
% strArray(3) = java.lang.String('/mnt/data/oBCI/NIRx/EEG/EEG_Laser_Daten/infile/EEG_N08_PVL.gdf');
strArray(3) = java.lang.String('/mnt/data/oBCI/NIRx/EEG/EEG_Laser_Daten/infile/EEG_N07_PVL.gdf');
strArray(4) = java.lang.String('/mnt/data/oBCI/NIRx/EEG/EEG_Laser_Daten/infile/EEG_N06_PVL.gdf');
strArray(5) = java.lang.String('/mnt/data/oBCI/NIRx/EEG/EEG_Laser_Daten/infile/EEG_N05_PVL.gdf');
data = cell(strArray);




% [signal,h,e] = gdf_reader(data,'dataformat','Matrix','upsamplemode','linear','dataorientation','col');
[signal,h,e] = gdf_multiread(data,'dataformat','Matrix','upsamplemode','linear','dataorientation','col');
signal(isnan(signal)) = 0;

TriggerLine = signal(:,end);

%% ARTIFACT SELECTION:
    
        if sum(e.event_code == 259) > 0
            disp('### Activating Artifact Removal ###')
            ArtifactMask = ones(size(signal,1),1);
            
            ArtifactOnsets = double(e.position(e.event_code==259));
            for g=1:length(ArtifactOnsets)
                ArtifactMask([1:e.duration(e.position==ArtifactOnsets(g))]+ArtifactOnsets(g)) = 0;
            end
            TriggerLine = TriggerLine .* ArtifactMask;
        end
    
%%
signal(:,end) = [];

Fs = h.signals(1).sampling_rate;
% signal(:,13)=signal(:,13)-signal(:,13);
% signal(:,7)=signal(:,7)-signal(:,7);
% signal(:,8)=signal(:,8)-signal(:,8);
%CAR

% signal(:,16) = signal(:,16) - mean(signal, 2);
% signal(:,17) = signal(:,17) - mean(signal, 2);
% signal(:,18) = signal(:,18) - mean(signal, 2);

mean_EEG=mean(signal(:,:),2);
% figure
% plot(mean_EEG)
%         for tt=1:size(signal,2)
%         signal(:,tt)=signal(:,tt)-mean_EEG(:,1);
%         end


%CAR C3:

for g=1:1:size(signal,2)
s = signal(:,g);% - mean(signal,2);

%% FILTERS:
    filter_type = 3;
    N_IIR = 4;
    
    switch filter_type
        case 1 %first HP then LP
            wH = 0.5/(Fs/2); % = 0.5Hz
            [HPb,HPa] = butter(N_IIR,wH ,'high');
            s = filter(HPb,HPa,s);
            
            wL = 10/(Fs/2); % = 10Hz
            [LPb,LPa] = butter(N_IIR,wL ,'low');
            s = filter(LPb,LPa,s);
        case 2 %only LP
            wL = 10/(Fs/2); % = 10Hz
            [LPb,LPa] = butter(N_IIR,wL ,'low');
            s = filter(LPb,LPa,s);
        case 3 %BP
            w1p = 0.8/(Fs/2); % = 3Hz
            w2p = 10/(Fs/2); % = 10Hz
            
            [BPb,BPa] = butter(N_IIR,[w1p,w2p],'bandpass');
            s = filter(BPb,BPa,s);
        case 4 %BP
           
            s = s;  
        case 5 %only HP 
            wH = 12/(Fs/2); % = 12Hz
            [HPb,HPa] = butter(N_IIR,wH ,'high');
            s = filter(HPb,HPa,s);
         
    end

TriggerLine(TriggerLine<3) = 0;
TriggerLine = diff(TriggerLine);
TriggerLine(TriggerLine<0) = 0;

TRIG = find(TriggerLine>0);
a=size(TRIG)

%Trigger f�r blau
% TRIG=TRIG(100:end);

[EP_Matrix, sz] = trigg(s,TRIG,0,floor(1*Fs)-1);
EP_Matrix = reshape(EP_Matrix,sz(2:3));

EP_Mean = mean(EP_Matrix,2);
EP_SE = std(EP_Matrix/sqrt(length(TRIG)),0,2);


figure(200)
% plot(EP_Mean)
darstellung_EEG_sigma_2(g,EP_Mean,EP_SE,Fs)


%spektrum singleplot

if g==16
                    
                    %spektrum
                    maxf=100;
                    figure(198)
                    rHR=calcSpecHR(signal(:,g),Fs); 
                    freqHR=rHR{1}.f;
                    pHR=rHR{1}.p;
                    indHR=find(freqHR<=maxf);

                    h=semilogy(freqHR(indHR),pHR(indHR),'r');
                    set(h,'LineWidth',1);
                    hold on

                   

                    xlabel('f (Hz)','FontSize',4,'FontWeight','bold')
                    grid on;
                    
                    
                    %einzelplot
                    figure(199)
                    t=1/Fs:1/Fs:size(EP_Mean)/Fs;

      
                    h=plot(t',EP_Mean,'b');
                    set(h,'LineWidth',3);
                    hold on
                     h=plot(t',EP_Mean-EP_SE,'b--');
                    set(h,'LineWidth',2);
                     h=plot(t',EP_Mean+EP_SE,'b--');
                    set(h,'LineWidth',2);

                    ax=axis;
                    ax=([ax(1,1) ax(1,2) -1 1]);
                    axis(ax);

                    title(['Ch ' num2str(g)],'FontSize',6,'FontWeight', 'bold')

end
end
