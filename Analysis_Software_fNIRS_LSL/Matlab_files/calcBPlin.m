function BP = EHK_calcBPlin(s,fs,typ)
% Calculates and displays the instantaneous BP rate.
%
% This function calculates the instantaneous BP rate. It also computes a 
% confidence interval based on bootstrap statistics.
%
%
%
% Input parameters:
%   s        ... Input signal (as obtained by sload)
%   fs       ... Sampling frequency
%   typ      ... [1] systolic BP
%            ... [2] diastolic BP
%
%
% Output parameter:
%    BP... blood pressure
%
%
%
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

if (nargin < 1)
    error('No input signal specified.');
end;
if (nargin < 2)
    error('No header structure specified.');
end;
if (nargin < 3)
    error('Typ not selected');
end;




% Calculate BP rate

if typ==1
    h_BP = sysdetect_neu(s, fs);
end
if typ==2
    h_BP = diasysdetect_neu(s, fs);
end
time = h_BP.EVENT.POS;

timesec=time./fs;

bp=s(time)/10; %neu


%%%%%%linearisierung%%%%%%
X=timesec;                              %old time axis
XI = (timesec(1):1/fs:timesec(end))';   %new time axis for interpolation
BP = interp1(X,bp,XI,'linear');        %HR linear interpolated
BP=[BP(1)*ones(time(1)-1,1);BP;BP(end)*ones(length(s)-time(end),1)];

