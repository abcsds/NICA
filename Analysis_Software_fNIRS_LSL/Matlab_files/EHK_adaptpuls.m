function [cleanSignal]=EHK_adaptpuls(dirtySignal,Noise,fs)

    Noise=Noise/max(Noise);

    calcPulsNoise = AdaptiveFilterGB(dirtySignal, Noise, 50);

    no_upsample=0;
    if fs==3
        no_upsample=1;

        %Upsamplen
        t=[1/fs:1/fs:length(calcPulsNoise)/fs];
        tmean=(1/6)*1000;
        X=t;                              %old time axis
        XI = (t(1):(tmean/1000):t(end))';   %new time axis for interpolation
        calcPulsNoise = interp1(X,calcPulsNoise,XI,'linear');        %linear interpolated
        fs=6;
    end
    
    %filtern
    Wn=[0.8];                    %HP grezen
    N=200;
    b = fir1(N,Wn/(fs/2),'high');
    calcPulsNoise=filtfilt(b,1,calcPulsNoise);
    
    %Downsamplen
    if no_upsample
        calcPulsNoise = resample(calcPulsNoise,3,fs);
        fs=3;
    end

    %     Wn=[0.8];                    %HP grezen
    %     N=200;
    %     b = fir1(N,Wn/(fs/2),'high');
    %     calcPulsNoise=filtfilt(b,1,calcPulsNoise);

    cleanSignal=dirtySignal-calcPulsNoise;

    % figure
    % subplot(3,1,1)
    % plot(dirtySignal)
    % subplot(3,1,2)
    % plot(calcPulsNoise)
    % subplot(3,1,3)
    % plot(cleanSignal)
end