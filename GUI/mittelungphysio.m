%  (c)Günther Bauernfeind

% This file (mittelung) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.

% Modified 15.02.2016 
% Bachmaier Dominik 
% Changes: Adapted to new version of NIRS setup including LSL recorder


function mittelungphysio(NIRx, settings, data, Task, ImageClass, trig, BPfs, gUSBampfs)

    Timing = [-settings.timing.pre (settings.timing.signal + settings.timing.post)];

    t_trial_bp = [round(Timing(1)*BPfs):1:round(Timing(2)*BPfs-1)];
    
    if NIRx.hdr.Bool.gUSBamp
        t_trial_gUSBamp = [round(Timing(1)*gUSBampfs):1:round(Timing(2)*gUSBampfs-1)];
    end
        
    for k = 2 : length(trig)
        [idx idx] = min(abs(NIRx.Time.BP - trig(k)));
        
        try
            data_ch_BP(:,1,k) = NIRx.Data.BPdia(idx + t_trial_bp,1)-mean(NIRx.Data.BPdia(idx + t_trial_bp(1:(round(Timing(1)*BPfs)*(-1)+1))),1);
            data_ch_BP(:,2,k) = NIRx.Data.BPsys(idx + t_trial_bp,1)-mean(NIRx.Data.BPsys(idx + t_trial_bp(1:(round(Timing(1)*BPfs)*(-1)+1)),1));
     
            if NIRx.hdr.Bool.gUSBamp
                [idy idy] = min(abs(NIRx.Time.gUSBamp - trig(k)));
                data_ch_gUSBamp(:,1,k) = NIRx.Data.HR(idy + t_trial_gUSBamp,1)-mean(NIRx.Data.HR(idy + t_trial_gUSBamp(1:((Timing(1)*gUSBampfs)*(-1)+1)),1));
            end
        catch
            disp(['Could not process Trigger Nr. ' num2str(k)]);
        end
    end
    clear k idx idy;

    % averaging and smoothing
    dat_avg_BP = [];
    dat_std_BP = [];

    for k = 1 : size(data_ch_BP,2)
        dat_avg_BP(:,k) = squeeze(mean(data_ch_BP(:,k,:),3));
        dat_std_BP(:,k) = squeeze(std(data_ch_BP(:,k,:)/sqrt(length(trig)),0,3));
    end
    clear k
   
    if NIRx.hdr.Bool.gUSBamp
        dat_avg_gUSBamp = [];
        dat_std_gUSBamp = [];
        
        dat_avg_gUSBamp(:,1) = squeeze(mean(data_ch_gUSBamp(:,1,:),3));
        dat_std_gUSBamp(:,1) = squeeze(std(data_ch_gUSBamp(:,1,:)/sqrt(length(trig)),0,3));
    
        %Auf ref-intervall referenzieren     
        dat_avg_gUSBamp(:,1) = dat_avg_gUSBamp(:,1)-mean(dat_avg_gUSBamp(1:(Timing(1)*gUSBampfs)*(-1)+1,1));
    end
    
    %Auf ref-intervall referenzieren     
    dat_avg_BP(:,1)=dat_avg_BP(:,1)-mean(dat_avg_BP(1:round(Timing(1)*BPfs)*(-1)+1,1));
    dat_avg_BP(:,2)=dat_avg_BP(:,2)-mean(dat_avg_BP(1:round(Timing(1)*BPfs)*(-1)+1,2));

    h = figure;
    subplot(3,1,1)
    title(['Mean Physio Signals ', ' ', ImageClass],'FontSize',12)
    h=plot((t_trial_bp/256)',dat_avg_BP(:,1),'k');
    set(h,'LineWidth',2);
    hold on
    h=plot((t_trial_bp/256)',dat_avg_BP(:,1)-dat_std_BP(:,1),'k');
    set(h,'LineWidth',1);
    hold on
    h=plot((t_trial_bp/256)',dat_avg_BP(:,1)+dat_std_BP(:,1),'k');
    set(h,'LineWidth',1);
    hold on
    xlabel('t(s)','FontSize',12)
    ylabel('(\Delta mm Hg)','FontSize',12)
    legend('[BPdiaV]')
 

    subplot(3,1,2)
    h=plot((t_trial_bp/256)',dat_avg_BP(:,2),'k');
    set(h,'LineWidth',2);
    hold on
    h=plot((t_trial_bp/256)',dat_avg_BP(:,2)-dat_std_BP(:,2),'k');
    set(h,'LineWidth',1);
    hold on
    h=plot((t_trial_bp/256)',dat_avg_BP(:,2)+dat_std_BP(:,2),'k');
    set(h,'LineWidth',1);
    hold on
    xlabel('t(s)','FontSize',12)
    ylabel('(\Delta mm Hg)','FontSize',12)
    legend('[BPsysV]')

    if NIRx.hdr.Bool.gUSBamp
        subplot(3,1,3)
        h=plot((t_trial_gUSBamp/256)',dat_avg_gUSBamp(:,1),'k');
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial_gUSBamp/256)',dat_avg_gUSBamp(:,1)-dat_std_gUSBamp(:,1),'k');
        set(h,'LineWidth',1);
        hold on
        h=plot((t_trial_gUSBamp/256)',dat_avg_gUSBamp(:,1)+dat_std_gUSBamp(:,1),'k');
        set(h,'LineWidth',1);
        hold on
        xlabel('t(s)','FontSize',12)
        ylabel('(\Delta bpm)','FontSize',12)
        legend('[HRV]')
    end

%     gcf;
%     orient landscape;
% 
%     print( '-dpng', '-r300', [evaluationPath filesep Task,'_',ImageClass,'_Mean_Physio_Signals']);
    saveas(h, [data.analysisPath filesep data.analysisFilename '_Physio_Signals_Mean'],'fig');             
end
        


    





    
    
    
    
