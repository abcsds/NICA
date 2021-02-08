function applysettings(handles)

    settings = handles.SETTINGS;
    
    % ------------------------------------------------------------------------------------------------------- BASICS ---

    % Version
    set(handles.popupmenuSignal, 'Value', settings.signal.value);
    
    % Image Class
    set(handles.popupmenuImageClass, 'String', settings.imageClass.string_list);
    set(handles.popupmenuImageClass, 'Value', settings.imageClass.nrCond);
    if strcmp(settings.imageClass.string, 'Default')
        set(handles.popupmenuImageClass, 'Enable', 'off');
    else
        set(handles.popupmenuImageClass, 'Enable', 'on');
    end
    
    % Probeset
    set(handles.popupmenuProbeset, 'Value', settings.probeset.value);
    
    % Nr Trials
    set(handles.editNrTrials, 'Value', settings.nrTrials);
    set(handles.editNrTrials, 'String', num2str(settings.nrTrials));
    % Task Name
    set(handles.editTaskName, 'String', settings.taskName);
    
    % ------------------------------------------------------------------------------------------------ PREPROCESSING ---
    
    % Baseline removal
    set(handles.checkboxBaselineRemoval,'Value',settings.baseline);
    
    % Low-pass filter
    set(handles.checkboxLowPassFilter,'Value',settings.lowPass);
    if settings.lowPass
        set(handles.editLowPassCutOff, 'Enable', 'on');
        set(handles.textLowPassCutOff, 'Enable', 'on');
        set(handles.editLowPassCutOff, 'Value', settings.lowPassCutOff);
        set(handles.editLowPassCutOff, 'String', num2str(settings.lowPassCutOff));
    else
        set(handles.editLowPassCutOff, 'Enable', 'off');
        set(handles.textLowPassCutOff, 'Enable', 'off');
    end
    
    % Notch filter
    set(handles.checkboxNotchFilter,'Value',settings.notch);
    % Common Average Reference
%     set(handles.checkboxCAR,'Value',settings.car);
    
    
    % Signal analysis method
    set(handles.popupmenuSignalAnalysisMethod, 'Value', settings.signalAnalysis.value);
    % Mayer waves source
    set(handles.popupmenuMayerWavesSource, 'Value', settings.mayerWavesSource.value);
    % Correction mode
    set(handles.popupmenuCorrectionMode, 'Value', settings.correctionMode.value);
    
    switch settings.correctionMode.value
        case 1  % Uncorrected

            % Mayer Waves Source
            set(handles.popupmenuMayerWavesSource, 'Enable', 'Off');
            set(handles.textMayerWaves, 'Enable', 'Off');
            % Mayer Waves Spectrum
            set(handles.textArtefactRemovalMayerWaves, 'enable', 'off');
            set(handles.editMayerWavesStart, 'enable', 'off');
            set(handles.editMayerWavesEnd, 'enable', 'off');
            set(handles.editMayerWavesInterval, 'enable', 'off');
            % Respiration Peak Spectrum
            set(handles.textArtefactRemovalRespirationPeak, 'enable', 'off');
            set(handles.editRespirationStart, 'enable', 'off');
            set(handles.editRespirationEnd, 'enable', 'off');
            set(handles.editRespirationInterval, 'enable', 'off');
            % Pulse Peak Spectrum
            set(handles.textArtefactRemovalPulsePeak, 'enable', 'off');
            set(handles.editPulseStart, 'enable', 'off');
            set(handles.editPulseEnd, 'enable', 'off');
            set(handles.editPulseInterval, 'enable', 'off');

        case 2  % Respiration

            % Mayer Waves Source
            set(handles.popupmenuMayerWavesSource, 'Enable', 'Off');
            set(handles.textMayerWaves, 'Enable', 'Off');
            % Mayer Waves Spectrum
            set(handles.textArtefactRemovalMayerWaves, 'enable', 'off');
            set(handles.editMayerWavesStart, 'enable', 'off');
            set(handles.editMayerWavesEnd, 'enable', 'off');
            set(handles.editMayerWavesInterval, 'enable', 'off');
            % Respiration Peak Spectrum
            set(handles.textArtefactRemovalRespirationPeak, 'enable', 'on');
            set(handles.editRespirationStart, 'enable', 'on');
            set(handles.editRespirationEnd, 'enable', 'on');
            set(handles.editRespirationInterval, 'enable', 'on');
            % Pulse Peak Spectrum
            set(handles.textArtefactRemovalPulsePeak, 'enable', 'off');
            set(handles.editPulseStart, 'enable', 'off');
            set(handles.editPulseEnd, 'enable', 'off');
            set(handles.editPulseInterval, 'enable', 'off');

        case 3  % Mayer Waves

            % Mayer Waves Source
            set(handles.popupmenuMayerWavesSource, 'Enable', 'On');
            set(handles.textMayerWaves, 'Enable', 'On');
            % Mayer Waves Spectrum
            set(handles.textArtefactRemovalMayerWaves, 'enable', 'on');
            set(handles.editMayerWavesStart, 'enable', 'on');
            set(handles.editMayerWavesEnd, 'enable', 'on');
            set(handles.editMayerWavesInterval, 'enable', 'on');
            % Respiration Peak Spectrum
            set(handles.textArtefactRemovalRespirationPeak, 'enable', 'off');
            set(handles.editRespirationStart, 'enable', 'off');
            set(handles.editRespirationEnd, 'enable', 'off');
            set(handles.editRespirationInterval, 'enable', 'off');
            % Pulse Peak Spectrum
            set(handles.textArtefactRemovalPulsePeak, 'enable', 'off');
            set(handles.editPulseStart, 'enable', 'off');
            set(handles.editPulseEnd, 'enable', 'off');
            set(handles.editPulseInterval, 'enable', 'off');

        case 4  % Mayer and Respiration

            % Mayer Waves Source
            set(handles.popupmenuMayerWavesSource, 'Enable', 'On');
            set(handles.textMayerWaves, 'Enable', 'On');
            % Mayer Waves Spectrum
            set(handles.textArtefactRemovalMayerWaves, 'enable', 'on');
            set(handles.editMayerWavesStart, 'enable', 'on');
            set(handles.editMayerWavesEnd, 'enable', 'on');
            set(handles.editMayerWavesInterval, 'enable', 'on');
            % Respiration Peak Spectrum
            set(handles.textArtefactRemovalRespirationPeak, 'enable', 'on');
            set(handles.editRespirationStart, 'enable', 'on');
            set(handles.editRespirationEnd, 'enable', 'on');
            set(handles.editRespirationInterval, 'enable', 'on');
            % Pulse Peak Spectrum
            set(handles.textArtefactRemovalPulsePeak, 'enable', 'off');
            set(handles.editPulseStart, 'enable', 'off');
            set(handles.editPulseEnd, 'enable', 'off');
            set(handles.editPulseInterval, 'enable', 'off');

        case 5  % Mayer, Respiration and Pulse

            % Mayer Waves Source
            set(handles.popupmenuMayerWavesSource, 'Enable', 'on');
            set(handles.textMayerWaves, 'Enable', 'on');
            % Mayer Waves Spectrum
            set(handles.textArtefactRemovalMayerWaves, 'enable', 'on');
            set(handles.editMayerWavesStart, 'enable', 'on');
            set(handles.editMayerWavesEnd, 'enable', 'on');
            set(handles.editMayerWavesInterval, 'enable', 'on');
            % Respiration Peak Spectrum
            set(handles.textArtefactRemovalRespirationPeak, 'enable', 'on');
            set(handles.editRespirationStart, 'enable', 'on');
            set(handles.editRespirationEnd, 'enable', 'on');
            set(handles.editRespirationInterval, 'enable', 'on');
            % Pulse Peak Spectrum
            set(handles.textArtefactRemovalPulsePeak, 'enable', 'on');
            set(handles.editPulseStart, 'enable', 'on');
            set(handles.editPulseEnd, 'enable', 'on');
            set(handles.editPulseInterval, 'enable', 'on');

        case 6  % Pulse

            % Mayer Waves Source
            set(handles.popupmenuMayerWavesSource, 'Enable', 'Off');
            set(handles.textMayerWaves, 'Enable', 'Off');
            % Mayer Waves Spectrum
            set(handles.textArtefactRemovalMayerWaves, 'enable', 'off');
            set(handles.editMayerWavesStart, 'enable', 'off');
            set(handles.editMayerWavesEnd, 'enable', 'off');
            set(handles.editMayerWavesInterval, 'enable', 'off');
            % Respiration Peak Spectrum
            set(handles.textArtefactRemovalRespirationPeak, 'enable', 'off');
            set(handles.editRespirationStart, 'enable', 'off');
            set(handles.editRespirationEnd, 'enable', 'off');
            set(handles.editRespirationInterval, 'enable', 'off');
            % Pulse Peak Spectrum
            set(handles.textArtefactRemovalPulsePeak, 'enable', 'on');
            set(handles.editPulseStart, 'enable', 'on');
            set(handles.editPulseEnd, 'enable', 'on');
            set(handles.editPulseInterval, 'enable', 'on');

    end
    
     % --------------------------------------------------------------------------------- BIOLOGICAL ARTEFACT REMOVAL ---
    
    % Mayer Waves Start
    set(handles.editMayerWavesStart, 'Value', settings.mayerWavesRemoval.start);
    set(handles.editMayerWavesStart, 'String', num2str(settings.mayerWavesRemoval.start));
    % Mayer Waves End
    set(handles.editMayerWavesEnd, 'Value', settings.mayerWavesRemoval.end);
    set(handles.editMayerWavesEnd, 'String', num2str(settings.mayerWavesRemoval.end));
    % Mayer Waves Interval
    set(handles.editMayerWavesInterval, 'Value', settings.mayerWavesRemoval.interval);
    set(handles.editMayerWavesInterval, 'String', num2str(settings.mayerWavesRemoval.interval));
    
    % Respiration Peaks Start
    set(handles.editRespirationStart, 'Value', settings.respirationRemoval.start);
    set(handles.editRespirationStart, 'String', num2str(settings.respirationRemoval.start));
    % Respiration Peaks End
    set(handles.editRespirationEnd, 'Value', settings.respirationRemoval.end);
    set(handles.editRespirationEnd, 'String', num2str(settings.respirationRemoval.end));
    % REspiration Peaks Interval
    set(handles.editRespirationInterval, 'Value', settings.respirationRemoval.interval);
    set(handles.editRespirationInterval, 'String', num2str(settings.respirationRemoval.interval));
    
    % Pulse Peaks Start
    set(handles.editPulseStart, 'Value', settings.pulseRemoval.start);
    set(handles.editPulseStart, 'String', num2str(settings.pulseRemoval.start));
    % Pulse Peaks End
    set(handles.editPulseEnd, 'Value', settings.pulseRemoval.end);
    set(handles.editPulseEnd, 'String', num2str(settings.pulseRemoval.end));
    % Pulse Peaks Interval
    set(handles.editPulseInterval, 'Value', settings.pulseRemoval.interval);
    set(handles.editPulseInterval, 'String', num2str(settings.pulseRemoval.interval));
    
    % ------------------------------------------------------------------------------------------------------- TIMING ---
    
    % Signal length
    set(handles.editSignalLength, 'Value', settings.timing.signal);
    set(handles.editSignalLength, 'String', num2str(settings.timing.signal));
    
    % Pre-trigger signal
    set(handles.editPreTrigger, 'Value', settings.timing.pre);
    set(handles.editPreTrigger, 'String', num2str(settings.timing.pre));
    
    % Post-trigger signal
    set(handles.editPostTrigger, 'Value', settings.timing.post);
    set(handles.editPostTrigger, 'String', num2str(settings.timing.post));
    
    % Marker offset
    set(handles.checkboxMarkerOffset,'Value',settings.markerOffset);
    
    % ----------------------------------------------------------------------------------------------------- CHANNELS ---

    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');

    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            for i = 1:settings.channels.nr
                set(eval(['handles.checkboxCh' num2str(i)]),'Value',settings.channels.display(i));
            end
        case 'radiobuttonExcludeChannels'
            for i = 1:settings.channels.nr
                set(eval(['handles.checkboxCh' num2str(i)]),'Value',settings.channels.exclude(i));
            end
    end
    
    % ---------------------------------------------------------------------------------------------------- ARTEFACTS ---
    
    % Consider Optode Failure
    set(handles.checkboxConsiderOptodeFailure,'Value', settings.optodeFail.value);
    % Exclude Trials
    set(handles.checkboxExcludeTrials,'Value', settings.excludeTrials.value);
    if settings.excludeTrials.value
        set(handles.radiobuttonExcludeChannels, 'Enable', 'On');
    end
    % Exclude Channels    
    set(handles.checkboxExcludeChannels,'Value', settings.excludeChannels);
    
    % ----------------------------------------------------------------------------------------------- FIGURE OPTIONS ---
    
    % Display Frequency
    set(handles.editDisplayFrequency, 'Value', settings.displayFrequency);
    set(handles.editDisplayFrequency, 'String', num2str(settings.displayFrequency));
    
    % Generate Heart Rate Figures
%     set(handles.checkboxGenerateFiguresHeartRate,'Value',settings.generateFiguresHeartRate);
    % Generate Biosignals Figures
    set(handles.checkboxGenerateFiguresBiosignals,'Value',settings.generateFiguresBiosignals);
    % Generate Spectra Figures
    set(handles.checkboxGenerateFiguresRAW,'Value',settings.generateFiguresRAW);
    % Generate Blood Oxy Figures
    set(handles.checkboxGenerateFiguresBloodOxy,'Value',settings.generateFiguresBloodOxy);
    % Generate Topoplot Figures
    set(handles.checkboxGenerateFiguresTopoplot,'Value',settings.generateFiguresTopoplot);
    % Plot STD Signal
    set(handles.checkboxPlotSTD,'Value',handles.SETTINGS.plotSTD);
    
    % Range Min
    set(handles.editRangeMin, 'Value', settings.rangeMin);
    set(handles.editRangeMin, 'String', num2str(settings.rangeMin));
    % Range Max
    set(handles.editRangeMax, 'Value', settings.rangeMax);
    set(handles.editRangeMax, 'String', num2str(settings.rangeMax));
    
    % Nr. Topoplot figures
    set(handles.editNrTopoplots, 'Value', settings.nrTopoplots);
    set(handles.editNrTopoplots, 'String', num2str(settings.nrTopoplots));
        
end
