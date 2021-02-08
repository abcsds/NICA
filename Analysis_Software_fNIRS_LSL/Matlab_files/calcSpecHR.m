function r=calcSpecHR(hr,fs)

% Calculates the Spectrum of the heart rate
%
%
%       r=calcSpecHR(hr,fs)
%
%
% input:
%        hr  ... heart rate 
%        fs  ... sample rate    
%
% output:
%        r ... structure containing the spectrum.

hr_ges = [];
hr = hr(:);
window = hanning(length(hr));
hr_ges = [hr_ges; hr.*window];

% [p, f] = psd(hr_ges-mean(hr_ges), 200*fs, fs, hanning(100*fs), 50*fs, 'linear');
% p = p / (50*fs);

[p, f] = psd(hr_ges-mean(hr_ges), 100*fs, fs, hanning(50*fs), 10*fs, 'linear');
p = p / (10*fs);

r{1}.p = p;
r{1}.f = f;
r{1}.fs = fs;