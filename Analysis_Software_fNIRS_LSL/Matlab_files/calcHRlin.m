function HR=EHK_calcHRlin(s,fs,generatePlot,data,mode)

% calculate the linear interpolated Heart Rate
%
%
%   HR=calcHRlin(s,fs)
%
% input 
%     s:            ... ECG Signal
%     fs            ... sample rate
%
% optional input parameter
%     mode:         ... 1: instantaneous HR (default)
%                       2: delayed HR
% 
%         
% output
%     HR            ... Heart Rate

% 29.08.2007 Rupert Ortner
% last revision 25.04.2008

if nargin==4
    mode=1;
end

h_qrs = qrsdetect(s, fs, 2);
time = round(h_qrs.EVENT.POS);
% Correction of 3 samples
time = time - 3;
timesec=time./fs;


%possible correction
correction=false;
rate=diff(time);
meanrate=mean(rate);
del=[];
for i=1:length(rate)
    if rate(i) < meanrate/2;
        if i < length(rate)
            if rate(i-1) > rate(i+1)             
                 del=[del,i+1];
            else
                 del=[del,i];
            end
        else
            del=[del,i];
        end
       correction=true;
    end
end

q = diff(timesec);     
bpm = 60./q;

%correction
if correction==true && generatePlot
    h1 = figure;
    subplot(2,1,1);
    plot(timesec,[bpm;bpm(end)]);
    title('Heart Rate');
    subplot(2,1,2);
    plot(0:1/fs:length(s)/fs-1/fs,s);
    hold on;
    plot(timesec,s(time),'ro');
    title('detected QRS-peaks');            
    disp('warning: maybe false positive detected heart beats');
    saveas(h1, [data.analysisPath filesep data.analysisFilename '_Heart_Rate'],'fig');
    
    %figure;
    
%   correct=input('correction? y/n: ','s');  
    correct='y';
    if correct=='y'     %calculates the corrected heart rate;
        timesec(del)=[];
        time(del)=[];
        q = diff(timesec);     
        bpm = 60./q;        
        h2 = figure;
        subplot(2,1,1);
        plot(timesec,[bpm;bpm(end)]);
        title('Corrected Heart Rate');
        subplot(2,1,2);
        plot(0:1/fs:length(s)/fs-1/fs,s);
        hold on;
        plot(timesec,s(time),'ro');
        title('detected QRS-peaks');
        saveas(h2, [data.analysisPath filesep data.analysisFilename '_Heart_Rate_Corr'],'fig');
    elseif correct=='n'
        disp('no correction');       
    else
        disp('wrong input, no correction will be done');
    end
end

%Plausibility check
for i = 2:length(bpm)
    if bpm(i) > (2*bpm(i-1))
        bpm(i) = bpm(i-1);
    elseif bpm(i) < (bpm(i-1)/2)
        bpm(i) = bpm(i-1);
    end;
end;

if mode==1                                   %instantaneous
    bpm=[bpm;bpm(end)];
    X=timesec;                                %old time axis
    XI = (timesec(1):1/fs:timesec(end))';     %new time axis for interpolation
    HR = interp1(X,bpm,XI,'linear');          %HR linear interpolated
    HR=[HR(1)*ones(time(1)-1,1);HR;HR(end)*ones(length(s)-time(end),1)];
elseif mode==2                                   %delayed
    bpm=[bpm(1);bpm];
    X=timesec;                                  %old time axis
    XI = (timesec(1):1/fs:timesec(end))';       %new time axis for interpolation
    HR = interp1(X,bpm,XI,'linear');            %HR linear interpolated
    HR=[HR(1)*ones(time(1)-1,1);HR;HR(end)*ones(length(s)-time(end),1)];
end