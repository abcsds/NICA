function [data] = redefinetrial(cfg, data);

% REDEFINETRIAL allows you to adjust the time axis of your data,
% i.e. to change from stimulus-locked to response-locked. Furthermore,
% it allows you to select a time window of interest.
%
% Use as
%   trl = redefinetrial(cfg, trl)
% with a trial definition obtained from DEFINETRIAL, or
%   data = redefinetrial(cfg, data)
% with the output from PREPROCESSING.
%
% For realiging the time axes of all trials to a new reference time
% point (i.e. change the definition for t=0) you can use the following
% configuration option
%   cfg.offset = single number or Nx1 vector, expressed in samples
%                relative to current t=0
%
% For selecting a specific subsection of (i.e. cut out a time window
% of interest) you can selec a time window in seconds that is common 
% in all trials
%   cfg.toilim = [tmin tmax] or 'all', to specify a latency window in
%                seconds (default = 'all')
% or alternatively you can specify the begin and end sample in each trial
%   cfg.begsample = single number or Nx1 vector, relative to current t=0
%   cfg.endsample = single number or Nx1 vector, relative to current t=0
%
% For selecting trials with a minimum length you can specify 
%   cfg.minlength = length in seconds, can be 'maxperlen' (default = [])
%
% See also DEFINETRIAL, RECODEEVENT, PREPROCESSING

% Copyright (C) 2006, Robert Oostenveld
%
% $Log: redefinetrial.m,v $
% Revision 1.7  2007/04/03 15:37:07  roboos
% renamed the checkinput function to checkdata
%
% Revision 1.6  2007/03/30 17:05:40  ingnie
% checkinput; only proceed when input data is allowed datatype
%
% Revision 1.5  2007/02/07 12:09:56  roboos
% fixed some small bugs, thanks to Nienke
%
% Revision 1.4  2007/01/04 12:18:05  roboos
% changed a print statement
%
% Revision 1.3  2007/01/02 09:48:06  roboos
% fixed some small typos, prevent the selection of data that is completely outside teh toilim, implemented support for cfg.minlength
%
% Revision 1.2  2006/10/24 06:48:45  roboos
% small changes and bugfixes to make it work, updated documentation
%
% Revision 1.1  2006/10/19 16:06:51  roboos
% new implementation
%

% check if the input data is valid for this function
data = checkdata(data, 'datatype', 'raw', 'feedback', 'yes');

% set the defaults
if ~isfield(cfg, 'offset'),    cfg.offset = [];    end
if ~isfield(cfg, 'toilim'),    cfg.toilim = [];    end
if ~isfield(cfg, 'begsample'), cfg.begsample = []; end
if ~isfield(cfg, 'endsample'), cfg.endsample = []; end
if ~isfield(cfg, 'minlength'), cfg.minlength = []; end

if ~isstruct(data)
  trl = data;
  Ntrial = size(trl,1);
else  
  % event and trl are not specified in the function call
  % but the data is given -> try to locate event and trl in the nested configuration
  event   = [];
  trl     = [];
  lookin  = 'cfg';
  search  = 1;
  while (search)
    if issubfield(data, [lookin '.trl']) % && issubfield(data, [lookin '.event'])
      trl    = getsubfield(data, [lookin '.trl']);
    search = 0; % stop searching
      elseif issubfield(data, [lookin '.previous']) && isstruct(getsubfield(data, [lookin '.previous']))
      lookin = [lookin '.previous'];
      search = 1; % continue searching, go one level deeper into the strucure
    elseif issubfield(data, [lookin '.previous']) && iscell(getsubfield(data, [lookin '.previous']))
      dum = getsubfield(data, [lookin '.previous']);
      if issubfield(dum{1}, 'trl')
        trl = getsubfield(dum{1}, 'trl');
        search = 0; % stop searching
      else
        warning('could not locate "trl" in the data');
      end
    else
      warning('could not locate "trl" in the data');
      search = 0; % stop searching
    end
  end
  Ntrial = size(trl,1);
  if length(data.trial)~=Ntrial || length(data.time)~=Ntrial
    error('the trial definition is inconsistent with the data');
  end
end

% check the input arguments, only one method for processing is allowed
numoptions = ~isempty(cfg.toilim) + ~isempty(cfg.offset) + (~isempty(cfg.begsample) || ~isempty(cfg.endsample));
if numoptions~=1
  error('you should specify either cfg.toilim, cfg.offset, or cfg.begsample and cfg.endsample');
end

% start processing
if ~isempty(cfg.toilim)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % select a latency window from each trial
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  begsample = zeros(Ntrial,1);
  endsample = zeros(Ntrial,1);
  skiptrial = zeros(Ntrial,1);
  for i=1:Ntrial
    if cfg.toilim(1)>data.time{i}(end) || cfg.toilim(2)<data.time{i}(1)
      begsample(i) = nan;
      endsample(i) = nan;
      skiptrial(i) = 1;
    else
      begsample(i) = nearest(data.time{i}, cfg.toilim(1)); 
      endsample(i) = nearest(data.time{i}, cfg.toilim(2)); 
      data.trial{i} = data.trial{i}(:, begsample(i):endsample(i));
      data.time{i}  = data.time{i} (   begsample(i):endsample(i));
    end
  end

  % also correct the trial definition
  trlold = trl;
  if ~isempty(trl)
    trl(:,1) = trl(:,1) + begsample - 1;
    trl(:,2) = trl(:,1) + (endsample-begsample+1);
    trl(:,3) = trl(:,3) + begsample - 1;
  end

  % remove trials that are completely empty
  trl = trl(~skiptrial,:);
  data.time  = data.time(~skiptrial);
  data.trial = data.trial(~skiptrial);
  fprintf('removing %d trials in which no data was selected\n', sum(skiptrial));

elseif ~isempty(cfg.offset)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % shift the time axis from each trial
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  offset = cfg.offset(:);
  if length(cfg.offset)==1
    offset = repmat(offset, Ntrial, 1);
  end
  for i=1:Ntrial
    data.time{i} = data.time{i} + offset(i)/data.fsample;
  end

  % also correct the trial definition
  trlold = trl;
  if ~isempty(trl)
    trl(:,3) = trl(:,3) + offset;
  end

elseif ~isempty(cfg.begsample) || ~isempty(cfg.endsample)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % select a latency window from each trial based on begin and end sample
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  begsample = cfg.begsample(:);
  endsample = cfg.endsample(:);
  if length(begsample)==1
    begsample = repmat(begsample, Ntrial, 1);
  end
  if length(endsample)==1
    endsample = repmat(endsample, Ntrial, 1);
  end
  for i=1:Ntrial
    data.trial{i} = data.trial{i}(:, begsample(i):endsample(i));
    data.time{i}  = data.time{i} (   begsample(i):endsample(i));
  end

  % also correct the trial definition
  trlold = trl;
  if ~isempty(trl)
    trl(:,1) = trl(:,1) + begsample - 1;
    trl(:,2) = trl(:,1) + (endsample-begsample+1);
    trl(:,3) = trl(:,3) + begsample - 1;
  end

end % processing the realignment or data selection

if ~isempty(cfg.minlength)
  Ntrial = length(data.trial);
  trllength = zeros(Ntrial, 1);
  % determine the length of each trial
  for i=1:Ntrial
    trllength(i) = data.time{i}(end) - data.time{i}(1);
  end
  if ischar(cfg.minlength) && strcmp(cfg.minlength, 'maxperlen')
    minlength = max(trllength);
  else
    minlength = cfg.minlength;
  end
  
  % remove trials that are too short
  skiptrial = (trllength<minlength);
  trl = trl(~skiptrial,:);
  data.time  = data.time(~skiptrial);
  data.trial = data.trial(~skiptrial);
  fprintf('removing %d trials that are too short\n', sum(skiptrial));
end


% remember the previous and the up-to-date trial definitions in the configuration
cfg.trl    = trl;
cfg.trlold = trlold;

% add version information to the configuration
try
  % get the full name of the function
  cfg.version.name = mfilename('fullpath');
catch
  % required for compatibility with Matlab versions prior to release 13 (6.5)
  [st, i] = dbstack;
  cfg.version.name = st(i);
end
cfg.version.id = '$Id: redefinetrial.m,v 1.7 2007/04/03 15:37:07 roboos Exp $';
% remember the configuration details of the input data
try, cfg.previous = data.cfg; end
% remember the exact configuration details in the output 
data.cfg = cfg;

