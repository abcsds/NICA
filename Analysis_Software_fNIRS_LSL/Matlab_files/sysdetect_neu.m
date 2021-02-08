function [HDR] = sysdetect_neu(s,fs,treshold)
% SYSDETECT - detection of SYS_BP_peak
%
%
%   HDR = sysdetect(s,Fs)
%
% INPUT
%
%   s           BP signal data 
%   Fs          sample rate 
%   treshold    treshold
	
% OUTPUT
%   HDR.EVENT  fiducial points of systolic BP	
%
%





% This library is free software; you can redistribute it and/or
% modify it under the terms of the GNU Library General Public
% License as published by the Free Software Foundation; either
% Version 2 of the License, or (at your option) any later version.
%
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Library General Public License for more details.
%
% You should have received a copy of the GNU Library General Public
% License along with this library; if not, write to the
% Free Software Foundation, Inc., 59 Temple Place - Suite 330,
% Boston, MA  02111-1307, USA.

%Remove of the trend
%[signal, trend]=detrend(s,1);
signal=detrend(s,1);

%Reduction of noise, LP filtering 10 Hz
[N,Wn]=buttord(10/(fs/2),30/(fs/2),3,60); 
[b,a]=butter(N,Wn,'low');
signal=filtfilt(b,a,signal);

%Glätten
signal=smooth(signal);
%1 Ableitung
d_signal=diff(signal);
%tresholding
% TH=max(d_signal); %original
TH=std(d_signal);
k=find(d_signal>TH); %original TH/4
%seperation
sep=fs/3; %Puls liegt unter 180 bpm
% Detektion
kpp(1)=k(1);
kpn=[];
for i=1:length(k)-1
    if k(i+1)-k(i)>sep    %To wave must be separated at least by sep
        kpp=[kpp,k(i+1)]; %The point befor sep is the last one of the wave 
        kpn=[kpn,k(i)];   %the next one is the starting point of the next 
                          %wave
    end
end
kpn=[kpn,k(length(k))];   %the last point of k is teh last one of the last
                          %wave
                          
for i=1:length(kpp)
    [m,n(i)]=max(d_signal(kpp(i):kpn(i)));
    pos_detect(i)=kpp(i)+n(i)-1;
end
if pos_detect(1)<=40
    pos_detect=pos_detect(2:end);
end
if pos_detect(end)>=length(signal)-40
    pos_detect=pos_detect(1:end-1);
end
for i=1:length(pos_detect)
    [m1,n1(i)]=max(s(pos_detect(i):pos_detect(i)+40));
    pos(i)=pos_detect(i)+n1(i)-1;
end

HDR.EVENT.POS=pos;

 
