function r = calcSpectrum(s, h, t, varargin)
% Calculates the spectrum of each channel.
%
% This function calculates the spectrum of each channel in the input signal. Two
% conditions can be specified, first the mandatory reference interval (plotted
% in blue), and optionally the activation interval (plotted in red).
%
% Usage:
%   r = calcSpectrum(s, h, t);
%
% Input parameters:
%   s         ... Input signal <TxC>.
%   h         ... Header structure (as obtained by sload) <1x1 struct>.
%   t         ... Start and end point within trial (in s) <1x2>.
%
% Optional input parameters (variable argument list):
%   't2'      ... Second interval (start and end point within trial), where
%                 another spectrum is calculated (in s) <1x2>.
%                 Default: No second interval is calculated.
%   'class'   ... List of classes used in the calculation <1xM>.
%                 Default: All available classes are used.
%   'heading' ... Heading of the plot <string>.
%                 Default: No heading is used.
%   'montage' ... Topographic layout of channels <NxM>. This matrix consists of
%                 zeros and ones. The channels are arranged in N rows and M
%                 columns on the plot, and they are located where the values of
%                 the matrix are equal to 1.
%                 Default: A rectangular layout is used.
% 
% Output parameter:
%   r ... Structure containing the results <1x1 struct>.

% Copyright by Clemens Brunner
% $Revision: 0.5 $ $Date: 09/19/2007 11:14:22 $
% E-Mail: clemens.brunner@tugraz.at

% Revision history:
%   0.5: Completely restructured the function, the calculation is now really
%        performed here and not in the plot function. All optional arguments are
%        now implemented as a variable argument list.

% This program is free software; you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation; either version 2 of the License, or (at your option) any later
% version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along with
% this program; if not, write to the Free Software Foundation, Inc., 59 Temple
% Place - Suite 330, Boston, MA  02111-1307, USA.

if (nargin < 1)
    error('No input signal specified.');
end;
if (nargin < 2)
    error('No header structure specified.');
end;
if (nargin < 3)
    error('Start and end point of one trial not specified.');
end;

% Default parameters, can be overwritten by varargin
t2 = [];  % No second interval for the calculation of the spectrum
class = [];  % All classes are used in the calculation
montage = [];  % Layout the electrodes in a grid
heading = '';  % Default name used for the title

if ~isempty(varargin)  % Are there optional parameters available?
    k = 1;
    while k<=length(varargin)
        if strcmp(varargin{k}, 't2')
            t2 = varargin{k + 1};
            k = k + 2;
        elseif strcmp(varargin{k}, 'class')
            class = varargin{k + 1};
            k = k + 2;    
        elseif strcmp(varargin{k}, 'montage')
            montage = varargin{k + 1};
            k = k + 2;
        elseif strcmp(varargin{k}, 'heading')
            heading = varargin{k + 1};
            k = k + 2;
        else  % Unknown parameter
            error('Unknown parameter %s.', varargin{k});
        end;
    end;
end;

if isempty(class)
    class = unique(h.Classlabel);
end;

fs = h.SampleRate;

% Trigger data
[st, temp] = trigg(s, h.TRIG(ismember(h.Classlabel, class)), round(t(1)*fs), round(t(2)*fs)-1);
if ~isempty(t2)
    [st2, temp2] = trigg(s, h.TRIG(ismember(h.Classlabel, class)), round(t2(1)*fs), round(t2(2)*fs)-1);
end;

triallen = round((t(2) - t(1)) * fs);
trials = length(st) / triallen;
if ~isempty(t2)
    triallen2 = round((t2(2) - t2(1)) * fs);
end;

% Topographic layout
if ~isempty(montage)
    if isnumeric(montage)
        plot_index = find(montage' == 1);
        n_rows = size(montage, 1);
        n_cols = size(montage, 2);
    elseif ischar(montage)
        [lap, plot_index, n_rows, n_cols] = getMontage(montage);
    end;
else
    plot_index = 1:size(s, 2);
    n_rows = ceil(sqrt(size(s, 2)));
    n_cols = n_rows;
end;

clear s;

for k = 1:length(plot_index)
    spec = [];
    for l = 1:trials
        temp = fft(st(k, (l-1)*triallen + 1:l*triallen) .* hanning(triallen)', 512) / triallen;
        spec = [spec (temp.*conj(temp))'];
    end;
    r.spec{k} = mean(spec, 2);
    
    if ~isempty(t2)
        spec = [];
        for l = 1:trials
            temp = fft(st2(k, (l-1)*triallen2 + 1:l*triallen2) .* hanning(triallen2)', 512) / triallen2;
            spec = [spec (temp.*conj(temp))'];
        end;
        r.spec2{k} = mean(spec, 2);
    end;
end;

r.plot_index = plot_index;
r.n_rows = n_rows;
r.n_cols = n_cols;
r.trials = trials;
r.class = class;
r.heading = heading;
r.fs = fs;
r.datatype = 'Spectrum';
