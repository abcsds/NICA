function signaln=EHK_remNoise(signal,noise,fs,windowlength)

%
% removes noise from signal
%  
%   signaln=remNoise(signal,noise,fs,shift)
%
% input:
%   signal:     ... signal with noise
%   noise:      ... noise signal from a different source    
%   fs:         ... sampling frequency
% 
% optional input parameter: 
%   windowlength: ... length of one segment for the correction, default=240
%   seconds
%   
%
% output:
%   signaln:  ... corrected signal without influence of noise 

% Copyright by Rupert Ortner
% 23.09.2008

% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by the
% Free Software Foundation; either version 2 of the License, or (at your
% option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
% Public License for more details.
%
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

if nargin==3
    windowlength=240; %240
end

fs_new=fs;    %New sampling rate
global mmax;
mmax=15;     %maximum filter order in function Korr_p
%--------------------------------------------------------------------------
signalD=decimate(signal,fs/fs_new);      %Downsampling to fs_new   
noiseD=decimate(noise,fs/fs_new);        %Downsampling to fs_new     
%--------------------------------------------------------------------------
laenge=(fs_new*windowlength);
partn=ceil(length(signalD)/laenge);
Korr=zeros(length(signalD),1); %preallocation of the correction term
endact=0;                      % end of actual part of signal
for i=1:partn        
    anf=(i-1)*laenge+1;
    ende=i*laenge;
    if ende > length(signalD)
        ende=length(signalD);
    end   
    if anf==1
        noise_e=[ones(mmax,1)*noiseD(1);noiseD(anf:ende)];
    else
        noise_e=noiseD(anf-mmax:ende);     
    end
    %----------------------------------------------------------
    Korr_p=part(noise_e,signalD(anf:ende));
    Korr(endact+1:endact+length(Korr_p))=Korr_p;
    endact=endact+length(Korr_p); 
end

endsignal=round(length(signal)./fs*fs_new);
Korr(end+1:endsignal)=Korr(end);

Korrint=interp(Korr,fs/fs_new);
Korrint=Korrint(1:length(signal));
signaln=signal-Korrint;      % Corrected Signal with original samplerate  
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function Korr_p=part(noise_e,signal_p)

% input
%     noise_e       ... Downsampled noise
%     signal_p      ... Downsampled signal
%     fs_new        ... sample rate
%
% Output:
%      Korr_p       ... Correction term

global mmax;
noise_p=noise_e(mmax+1:end);
mmin=5;
g_yy=xcov(noise_p,mmax,'biased');
g_xy = xcov(signal_p,noise_p,mmax,'biased');%cross-cov. of signal and noise 
g_xx0 = xcov(signal_p,0,'biased');          %Autocov. of signal_p

index=mmax+1;   %tau=0
lambda=zeros(1,mmax-mmin+1);
gu=cell(mmax,1);
for m=mmin:mmax
    g_xy_pj=g_xy(index:index+m);         %Gamma_xy from 0 to m
    g_yy_uj=g_yy(index:index+m);         %Gamma_yy from 0 to m
    G=toeplitz(g_yy_uj);
    gu{m}=inv(G)*g_xy_pj;          
    Snn=g_xx0-gu{m}'*g_xy_pj; 
    lambda(m-mmin+1)=length(noise_p)*log(Snn)+2*(m+1);
end
[minm,minind]=min(lambda);       %minimizing lambda
mind=mmin+minind-1;        
b=gu{mind};

S=filter(b,1,noise_e);
Korr_p=S(mmax+1:end);