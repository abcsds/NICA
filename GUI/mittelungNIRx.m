%  (c)Günther Bauernfeind

% This file (mittelung) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.

% Modified 25.02.2016
% Bachmaier Dominik
% Changes: Adapted to new version of NIRS setup including LSL recorder

function [dat_avg, dat_std, t_trial, data_ch_all]=mittelungNIRx(signal, NIRx, settings, trig, fs)

%     Timing = NIRx.settings.Timing;
    Timing = [-settings.timing.pre (settings.timing.signal+settings.timing.post)];

    t_trial = [round(Timing(1)*fs):1:round(Timing(2)*fs-1)];

    data=[];
    for k = 1 : length(trig)
        
        % Marker offset
        if settings.markerOffset
            diff = NIRx.Time.NIRS(1)-NIRx.hdr.Markers.Time(1);
            diff_idx = round(diff*fs);
        else
            diff_idx = 0;
        end
        
        [idx idx] = min(abs(NIRx.Time.NIRS - trig(k)));
        
        try
%             data(:,:,k) = signal(idx + t_trial,1:2);
            data(:,:,k) = signal(idx+diff_idx + t_trial,1:2); 
            data_ch_all(:,1,k) = signal(idx + t_trial,1)-mean(signal(idx + t_trial(1:(round(Timing(1)*fs)*(-1)+1)),1));
            data_ch_all(:,2,k) = signal(idx + t_trial,2)-mean(signal(idx + t_trial(1:(round(Timing(1)*fs)*(-1)+1)),2));
        catch
            disp(['Could not process Trigger Nr. ' num2str(k)]);
        end
    end
    clear k;

    % averaging and smoothing
    dat_avg = [];
    dat_std = [];
    diff_dat_avg = [];
    for k = 1 : size(data,2)
        % dat_avg(:,k) = smooth(squeeze(mean(data(:,k,:),3)),fs);
        % dat_std(:,k) = smooth(squeeze(std(data(:,k,:)/sqrt(length(trigger)),0,3)),fs);

        dat_avg(:,k) = squeeze(mean(data(:,k,:),3));
        dat_std(:,k) = squeeze(std(data(:,k,:)/sqrt(length(trig)),0,3));
    end
    
    %Auf ref-intervall referenzieren
    dat_avg(:,1)=dat_avg(:,1)-mean(dat_avg(1:(Timing(1)*fs)*(-1)+1,1));
    dat_avg(:,2)=dat_avg(:,2)-mean(dat_avg(1:(Timing(1)*fs)*(-1)+1,2));
end













