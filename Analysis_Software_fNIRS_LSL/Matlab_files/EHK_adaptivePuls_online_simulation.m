%EHK_Puls_Elimination online simulation

clear all
close all

load('C:\Bauernfeind\Daten_neu\s2\BK6_s2_Daten_Dirty_Fuss.mat')

% ------- Allgemeine Parameter
fs = 10;
Ts = 1/fs;
TS = Ts;
nr=26;
dispFreq=2;
window=EHK.setting.auto.win.type;
window_length=EHK.setting.auto.win.length;
setting.auto.win.ovelap=EHK.setting.auto.win.ovelap;
setting.auto.fft_length=EHK.setting.auto.fft_length;

time=[1/fs:1/fs:size(EHK.Data.puls_down)/fs]';
signals=[(EHK.Data.puls_down/(4*max(EHK.Data.puls_down))), EHK.Data.oxy_signals(:,nr)];

M=[time,signals];



mu = 0.01;       % Schrittweite der Anpassung
n_koeff = 32;    % Anzahl der Koeffizienten des Filters

% ------- Aufruf der Simulation
sim('adaptiv_puls_elimination',[0, length(time)/fs]);

% ------- Darstellung der Ergebnisse

t=time;
figure(1);    clf;
subplot(221), plot(t, y(1:length(time),1));
title('Durch Puls gestörtes oxy-Hb Signal');
xlabel('Zeit in s');   grid;

subplot(223), plot(t, y(1:length(time),2));
title('Adaptiv entstoertes oxy-Hb Signal');
xlabel('Zeit in s');   grid;

subplot(222), plot(t, y(1:length(time),3));
title('Gelernte Stoerung');
xlabel('Zeit in s');   grid;

subplot(224), stem(koeff);
title('Filterkoeffizienten');
xlabel('n');   grid;

figure(2);    clf;
freqz(koeff,1);
title('Frequenzgang des angepassten Filters');


% %Nachbearbeitung
%     Wn=[0.8];                    %HP grezen
%     N=200;
%     b = fir1(N,Wn/(fs/2),'high');
%     y(:,3)=filtfilt(b,1,y(:,3));

% cleanSignal=EHK.Data.oxy_signals(1:length(y(:,1)),23)-y(:,3);
% cleanSignal=y(:,1)-y(:,3);
%Spectren
figure(3)
rOxy=EHK_calcSpecETG(y(:,2),fs,window,window_length,setting.auto.win.ovelap,setting.auto.fft_length,EHK);
% rOxy=EHK_calcSpecETG(cleanSignal,fs,window,window_length,setting.auto.win.ovelap,setting.auto.fft_length,EHK);
rOxyorig=EHK_calcSpecETG(EHK.Data.oxy_signals(:,nr),fs,window,window_length,setting.auto.win.ovelap,setting.auto.fft_length,EHK);
% rOxyorig=EHK_calcSpecETG(y(:,1),fs,window,window_length,setting.auto.win.ovelap,setting.auto.fft_length,EHK);
    
%oxy
        p1 = rOxy{1}.p;
        f1 = rOxy{1}.f;
        p2 = rOxyorig{1}.p;
        f2 = rOxyorig{1}.f;
        farbe='k';
        idx = find(f2<=dispFreq);
        
        plot(f2(idx), 10*log10(p2(idx)),'Color', farbe,'LineWidth',1.5);
        hold on
        farbe='r';
       idx = find(f1<=dispFreq);
        plot(f1(idx), 10*log10(p1(idx)),'Color', farbe,'LineWidth',1.5);
        
        

