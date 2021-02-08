%  (c)Günther Bauernfeind

% This file (doblno) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.

% Modified 24.02.2016
% Bachmaier Dominik
% Changes: only small changes of formatation and cleaning of unused
% variables

function [oxy_signal, deoxy_signal,NIRx]=doblno_NIRx(oxy_signal,deoxy_signal,NIRx,fs)

    if NIRx.settings.TPAnfang==1
        %Remove Haare, Resp, Teile Mayer
        %          [N,Wn]=buttord(0.80/(fs/2),1/(fs/2),3,30); %anfänglich
        [N,Wn]=buttord(0.40/(fs/2),0.8/(fs/2),3,30); %Litcher1

        % [N,Wn]=buttord(1.4/(fs/2),1.4999/(fs/2),3,30); %neu
        [b,a]=butter(N,Wn,'low');
        oxy_signal=filtfilt(b,a,oxy_signal(:,:));
        deoxy_signal=filtfilt(b,a,deoxy_signal(:,:));
    end

    [N,Wn]=buttord(0.125/(fs/2),0.2/(fs/2),3,30); %neu
    [b,a]=butter(N,Wn,'low');
    for g=1:1:size(oxy_signal,2)
        NIRx.Data.clean.oxy_signals_TP_Zhang(:,g)=filtfilt(b,a,oxy_signal(:,g));
        NIRx.Data.clean.deoxy_signals_TP_Zhang(:,g)=filtfilt(b,a,deoxy_signal(:,g));
    end
    clear g;
    
    if NIRx.settings.baseline
        % Remove baseline drifts
        [N,Wn]=buttord(0.01/(fs/2),0.005/(fs/2),1,30);
        [d,c]=butter(N,Wn,'high');
        oxy_signal=filtfilt(d,c,oxy_signal(:,:));
        deoxy_signal=filtfilt(d,c,deoxy_signal(:,:));
    end %baseline
end




