%  (c)G?nther Bauernfeind

% This file (doblno) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.

% Modified 24.02.2016
% Bachmaier Dominik
% Changes: only small changes of formatation and cleaning of unused
% variables

function NIRx = doblnoNIRx(NIRx,settings)

    oxy_signal = NIRx.Data.Concentration.raw.oxy;
    deoxy_signal = NIRx.Data.Concentration.raw.deoxy;
    fs = NIRx.hdr.SamplingRate{1};
    
    % Resampling oxy- and deoxy-Hb signal --> 4 Hz
    ds_up = round(4*10000);
    ds_down = round(fs*10000);
    oxy_signal = resample(oxy_signal, ds_up, ds_down);
    deoxy_signal = resample(deoxy_signal, ds_up, ds_down);
    fs = round(fs * ds_up / ds_down);
    NIRx.hdr.SamplingRate{1} = fs;
    
    if settings.lowPass
        cutoff = settings.lowPassCutOff;
        
%         d = fdesign.lowpass('N,F3dB', 2, cutoff, fs);
%         h = design(d, 'butter', 'SOSScaleNorm', 'linf');
%         SOS = h.sosMatrix;
%         G = h.ScaleValues;
%         for g=1:1:size(oxy_signal,2)
%             oxy_signal(:,g)=filtfilt(SOS, G, oxy_signal(:,g));
%             deoxy_signal(:,g)=filtfilt(SOS, G, deoxy_signal(:,g));
%         end
%         clear g;

        %Remove Haare, Resp, Teile Mayer
        %          [N,Wn]=buttord(0.80/(fs/2),1/(fs/2),3,30); %anf?nglich
        [N,Wn]=buttord(cutoff/(fs/2),(cutoff+0.2)/(fs/2),3,30); %Litcher1

%         [N,Wn]=buttord(1.4/(fs/2),1.4999/(fs/2),3,30); %neu
        [b,a]=butter(N,Wn,'low');
%         oxy_signal=filtfilt(b,a,oxy_signal(:,:));
%         deoxy_signal=filtfilt(b,a,deoxy_signal(:,:));
        for g=1:1:size(oxy_signal,2)
            oxy_signal(:,g)=filtfilt(b,a,oxy_signal(:,g));
            deoxy_signal(:,g)=filtfilt(b,a,deoxy_signal(:,g));
        end
        clear g;
    end
    
%     % Zhang filter
%     [N,Wn]=buttord(0.125/(fs/2),0.2/(fs/2),3,30); %neu
%     [b,a]=butter(N,Wn,'low');
%     for g=1:1:size(oxy_signal,2)
%         oxy_signal(:,g)=filtfilt(b,a,oxy_signal(:,g));
%         deoxy_signal(:,g)=filtfilt(b,a,deoxy_signal(:,g));
%     end
%     clear g;

    
    % Remove peak between 0.6 and 0.8 Hz
    % Bandstop: Wp(1) < Ws(1) < Ws(2) < Wp(2)
%     Wp = [0.59 0.8];
%     Ws = [0.6 0.79];
%     [N,Wn]=buttord(Wp/(fs/2),Ws/(fs/2),1,30);
%     [d,c]=butter(N,Wn,'stop');
%     oxy_signal=filtfilt(d,c,oxy_signal(:,:));
%     deoxy_signal=filtfilt(d,c,deoxy_signal(:,:));

    
    if settings.baseline
        % Remove baseline drifts

%         d = fdesign.highpass('N,F3db', 2, 0.01, fs);
%         hHp = design(d, 'butter', 'SOSScaleNorm', 'linf');    
%         SOS = hHp.sosMatrix;
%         G = hHp.ScaleValues;
%         for g=1:1:size(oxy_signal,2)
%             oxy_signal(:,g)=filtfilt(SOS, G, oxy_signal(:,g));
%             deoxy_signal(:,g)=filtfilt(SOS, G, deoxy_signal(:,g));
%         end
%         clear g;

        [N,Wn]=buttord(0.01/(fs/2),0.005/(fs/2),3,30);
        [d,c]=butter(N,Wn,'high');
        oxy_signal=filtfilt(d,c,oxy_signal(:,:));
        deoxy_signal=filtfilt(d,c,deoxy_signal(:,:));

    end %baseline
    
    NIRx.Data.Concentration.clean.oxy = oxy_signal;
    NIRx.Data.Concentration.clean.deoxy = deoxy_signal;
    disp('Baseline removal and TP filtering done');
    
end




