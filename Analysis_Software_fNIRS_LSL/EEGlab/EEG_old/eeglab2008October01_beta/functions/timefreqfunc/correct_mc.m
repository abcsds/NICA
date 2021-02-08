% correct_mc() - compute an upper limit for the number of independant 
%                time-frequency estimate in a given time-frequency image. 
%                This number can be used to correct for multiple comparisons.
%
% Usage:
%   [ncorrect array] = correct_mc( EEG, cycles, maxfreq, timesout);
%
% Inputs: 
%    EEG       - EEGLAB structure
%    cycles    - [float] same as the cycle input to timef(). Default is [3 0.5].
%    freqrange - [float] minimum and maximum frequency. Default is [2 50] Hz.
%    timesout  - [integer] array of number of time points to test. 
%
% Output:
%    ncorrect - number of independant tf estimate in the time-freq image
%    array    - array of size (freqs x timesout) containing pvalues.
%
% Method details:
%
% Dividing by the total number of time-frequency estimate in the 2-D 
% time-frequency image decomposition would be too conservative since 
% spectral estimates of neighboring time-frequency points are highly 
% correlated. One must thus estimate the number of independent 
% time-frequency points in the TF image. Here, I used geometrical wavelets 
% which are optimal in terms of image compression, so neighboring 
% frequencies can be assume to carry independent spectral estimates. 
% We thus had time-frequency decompositions at only X frequencies (e.g. 120, 
% 60, 30, 15, 7.5, 3.25, 1.625 Hz). For each frequency, I then found 
% the minimum number of time points for which there was a significant 
% correlation of the spectral estimates between neighboring time points 
% (for each frequency and number of time point, I computed the correlation 
% from 0 to 1 for all data channel to obtain an a probability distribution 
% of correlation; we then fitted this distribution using a 4th order curve 
% (Ramberg, J. S., E. J. Dudewicz, et al. (1979). "A probability 
% distribution and its uses in fitting data." Technometrics 21(2)) and 
% assessed the probability of significance for the value 0 (no correlation) 
% to be within the distribution of estimated correlation). For instance, 
% using 28 time points at 120 Hz, there was no significant (p>0.05 taking 
% into account Bonferoni correction for multiple comparisons) correlation 
% between neighboring time-frequency power estimate, but there was a 
% significant correlation using 32 time points instead of 28 (p<0.05). 
% Applying the same approach for the X geometrical frequencies and summing 
% the minimum number of time points for observing a significant correlation 
% at all frequencies, ones obtain in general a number below 200 (with the 
% defaults above and 3-second data epochs) independent estimates. In all 
% the time-frequency plots, one has to used a significance mask at p<0.00025 
% (0.05/200). An alternative method for correcting for multiple comparisons 
% is presented in Nichols & Holmes, Human Brain Mapping, 2001.
%
% Author: Arnaud Delorme, SCCN, Jan 17, 2004

% Copyright (C) 2004 Arnaud Delorme, SCCN, arno@salk.edu
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

% $Log: correct_mc.m,v $
% Revision 1.1  2005/01/17 23:20:03  arno
% Initial revision
%

function [ncorrect, pval] = correct_mc( EEG, cycles, freqrange, timesout);

    if nargin < 1
        help correct_mc;
        return;
    end;
    if nargin < 2
        cycles  = [3 0.5];
    end;
    if nargin < 3
        freqrange = [2 50];
    end;
    if nargin < 4
        % possible number of time outputs
        % -------------------------------
        timesout = [5 6 7 8 9 10 12 14 16 18 20 24 28 32 36 40];
    end;
    nfreqs = ceil(log2(freqrange(2)));
        
    % scan times
    % ----------
    for ti = 1:length(timesout)
        clear tmpf
        
        % scan data channels
        % ------------------
        for index = 1:EEG.nbchan
            
            clf; [ersp,itc,powbase,times,freqs,erspboot,itcboot] = newtimef(EEG.data(index,:),EEG.pnts, ...
                             [EEG.xmin EEG.xmax]*1000,EEG.srate, cycles, 'timesout', timesout(ti), ...
                             'freqscale', 'log', 'nfreqs', nfreqs, 'freqrange', freqrange, 'plotitc', 'off', 'plotersp', 'off');
            
            % compute correlation
            % -------------------
            for fi = 1:length(freqs)
                tmp      = corrcoef(ersp(fi,1:end-1), ersp(fi,2:end));
                tmpf(index,fi) = tmp(2,1);
            end;
            
        end;
        
        % fit curve and determine if the result is significant
        % ----------------------------------------------------
        for fi = 1:length(freqs)
            pval(fi, ti) = rsfit(tmpf(:,fi)', 0);
            if pval(fi,ti) > 0.9999, pval(fi,ti) = NaN; end;
        end;
    end;

    % find minimum number of points for each frequency
    % ------------------------------------------------
    ncorrect = 0;
    threshold = 0.05 / prod(size(pval));
    for fi = 1:size(pval,1)
        ti = 1;
        while ti <= size(pval,2)
            if pval(fi,ti) < threshold
                ncorrect = ncorrect +  timesout(ti);
                ti = size(pval,2)+1;
            end;
            ti = ti+1;
        end;
    end;
