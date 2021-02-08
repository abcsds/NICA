function [cleanSignal]=EHK_adaptpulsonline(dirtySignal,Noise,fs)

             global Ts TS mu n_koeff M

             
             %Vorverarbeitung
             Noise = [Noise(5:end);Noise(1:4)];
             no_upsample=0;
             if fs==3
                  no_upsample=1;
                  dirty_old=dirtySignal;
             %Upsamplen
                  t=[1/fs:1/fs:length(dirtySignal)/fs];
                  tmean=(1/6)*1000;
                  X=t;                              %old time axis
                  XI = (t(1):(tmean/1000):t(end))';   %new time axis for interpolation
                  dirtySignal = interp1(X,dirtySignal,XI,'linear');        %linear interpolated
                  fs=6;
             end
             %filtern
                 Wnpuls=[0.8 1.8];                    %Bandpassgrenzen 
                 N=200;
                 b = fir1(N,Wnpuls/(fs/2),'bandpass');
                 defstoer=filtfilt(b,1,dirtySignal);
                 defstoer=defstoer-mean(defstoer);
             %Downsamplen
             if no_upsample
             defstoer = resample(defstoer,3,fs);
             fs=3;
             dirtySignal=dirty_old;
             end
             
             
             Noise=(Noise*max(defstoer(100:200))/max(Noise(100:200)));
             %/Vorverarbeitung

            Ts = 1/fs;
            TS = Ts;
            mu = 0.01;       % Schrittweite der Anpassung
            n_koeff = 32;    % Anzahl der Koeffizienten des Filters
            
            time=[1/fs:1/fs:size(Noise)/fs]';
   
        
%             signals=[(Noise/(4*max(Noise))), dirtySignal];
            signals=[Noise, dirtySignal];
            M=[time,signals];  
            
            

%             % ------- Aufruf der Simulation
            sim('adaptiv_puls_elimination',[0, length(time)/fs]);
        
            cleanSignal=y(1:length(time),2);

            
            M=[];
        
        





end