function [s_signal1, s_signal2, trig, t, SollActivierung, fs]=Upsample_NIRx(NIRx, s_signal1, s_signal2, trig, fs)

    t=[1/fs:1/fs:length(s_signal1)/fs];

    SollActivierung = zeros(size(s_signal1,1),1)*0;
    for k = 1 : length(trig)
        SollActivierung(trig(k)+[round(NIRx.settings.Anfang*fs):round(NIRx.settings.Ende*fs)])=1;
    end

    tmean=(1/6)*1000;
    % 
    %auf 6 Hz interpolieren *g*

    X=t;                              %old time axis
    XI = (t(1):(tmean/1000):t(end))';   %new time axis for interpolation
    XI_alt=XI;
    s_signal1 = interp1(X,s_signal1,XI,'linear');        %linear interpolated
    s_signal2 = interp1(X,s_signal2,XI,'linear');        %linear interpolated
    SollActivierung = interp1(X,SollActivierung,XI,'linear');        %linear interpolated



    trig=gettrigger(SollActivierung); 

    fs=6; %neue fs
    t=[1/fs:1/fs:length(s_signal1)/fs];
    t=t';



end