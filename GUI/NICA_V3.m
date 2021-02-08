function varargout = NICA_V3(varargin)
% NICA_V3 MATLAB code for NICA_V3.fig
%      NICA_V3, by itself, creates a new NICA_V3 or raises the existing
%      singleton*.
%
%      H = NICA_V3 returns the handle to a new NICA_V3 or the handle to
%      the existing singleton*.
%
%      NICA_V3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NICA_V3.M with the given input arguments.
%
%      NICA_V3('Property','Value',...) creates a new NICA_V3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NICA_V3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NICA_V3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NICA_V3

% Last Modified by GUIDE v2.5 11-Apr-2019 13:49:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NICA_V3_OpeningFcn, ...
                   'gui_OutputFcn',  @NICA_V3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before NICA_V3 is made visible. --------------------------------------------------- OPENING FCN ---
function NICA_V3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NICA_V3 (see VARARGIN)

% Choose default command line output for NICA_V3
handles.output = hObject;

% Start up settings
handles = startupgui(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NICA_V3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line. -------------------------------------- OUTPUT FCN --%
function varargout = NICA_V3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% ------------------------------------------------------------------------------------------------- LIST OF CONTENTS --%
% --- MENU FILE
% ------ CLOSE GUI
% ------ CLOSE FIGURES
% ------ OPEN ANALYSIS PATH
% ------ SELECT ANALYSIS PATH
%
% --- MENU MEASUREMENT DATA
% ------ LOAD HDR FILE
% ------ LOAD XDF FILES
% ------ CLEAR DATA
% ------ DEFINE CONDITIONS
%
% --- MENU USER SETTINGS
% ------ SAVE SETTINGS
% ------ SAVE SETTINGS AS
% ------ LOAD SETTINGS
%
% --- MENU GRAND AVERAGE
% ------ DEFINE ROIS
% ------ START GRAND AVERAGE
% ------ STOP GRAND AVERAGE
%
% --- LISTBOX XDF DATA
%
% --- UIPANEL SETTINGS BASICS
% ------ POPUPMENU SIGNAL
% ------ POPUPMENU IMAGE CLASS
% ------ POPUPMENU PROBESET
% ------ EDIT NR TRIALS
% ------ EDIT TASK NAME
%
% --- UIPANEL SETTINGS PREPROCESSING
% ------ POPUPMENU CORRECTION MODE
% ------ POPUPMENU MAYER WAVES SOURCE
% ------ POPUPMENU SIGNAL ANALYSIS METHOD
% ------ CHECKBOX LOW PASS FILTER
% ------ CHECKBOX NOTCH FILTER
% ------ CHECKBOX BASELINE REMOVAL
% ------ CHECKBOX COMMON AVERAGE REFERENCE
%
% --- UIPANEL SETTINGS BIOLOGICAL ARTEFACT REMOVAL
% ----- MAYER WAVES REMOVAL
% ----- RESPIRATION PEAK REMOVAL
% ----- PULSE PEAK REMOVAL
%
% --- UIPANEL SETTINGS TIMING
% ------ EDIT SIGNAL LENGTH
% ------ EDIT PRE-TRIGGER SIGNAL
% ------ EDIT POST-TRIGGER SIGNAL
%
% --- UIPANEL CHANNELS
% ------ CHECKBOX CH 1-61
% ------ CHECKBOX CH ALL
% ------ CHECKBOX CH NONE
% ------ UIPANEL CHANNEL OPTIONS
%
% --- UIPANEL ARTEFACTS
% ------ CHECKBOX EXCLUDE TRIALS
% ------ CHECKBOX EXCLUDE CHANNELS
% ------ CHECKBOX CONSIDER OPTODE FAIL
%
% --- UIPANEL DISPLAY OPTIONS
% ------ EDIT DISPLAY FREQUENCY
% ------ CHECKBOX GENERATE FIGURES HEART RATE
% ------ CHECKBOX GENERATE FIGURES BIOSIGNALS
% ------ CHECKBOX GENERATE FIGURES SPECTRA
% ------ CHECKBOX GENERATE FIGURES BLOOD OXY
% ------ CHECKBOX GENERATE FIGURES TOPOPLOT
% ------ CHECKBOX PLOT STD SIGNAL
%
% --- PUSHBUTTON START ANALYSIS
%
% --- LISTBOX OUTPUT
%
% --- CLOSE REQUEST FUNCTION


% ======================================================================================================== MENU FILE ==%
function MenuFile_Callback(hObject, eventdata, handles)
% hObject    handle to MenuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -------------------------------------------------------------------------------------------------------- CLOSE GUI --%
function menuFileCloseGUI_Callback(hObject, eventdata, handles)
% hObject    handle to menuFileCloseGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure1_CloseRequestFcn(handles.figure1, eventdata, handles);

% ---------------------------------------------------------------------------------------------------- CLOSE FIGURES --%
function menuFileCloseFigures_Callback(hObject, eventdata, handles)
% hObject    handle to menuFileCloseFigures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    set(handles.figure1, 'HandleVisibility', 'off');
    close all;
    set(handles.figure1, 'HandleVisibility', 'on');
    set(handles.menuFileCloseFigures,'Enable','Off');

% ----------------------------------------------------------------------------------------------- OPEN ANALYSIS PATH --%
function menuOpenAnalysisPath_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpenAnalysisPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    try
        winopen(handles.DATA.analysisPath);
    catch ME
        errordlg(ME.message);
    end
 
% --------------------------------------------------------------------------------------------- SELECT ANALYSIS PATH --%
function menuSelectAnalysisPath_Callback(hObject, eventdata, handles)
% hObject    handle to menuSelectAnalysisPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    start_path = handles.NIRxGUIDirectory;
    dialog_title = 'Select a Directory for your Analysis Files:'; 
    folder_name = uigetdir(start_path,dialog_title);

    if folder_name ~= 0
        handles.DATA.analysisPathMain = folder_name;
        handles.STATUS.analysisPath = 1;
        checkstatus(handles.STATUS,handles.pushbuttonStartAnalysis,handles.textAnalysisStatus);
        guidata(hObject, handles);
    end
    
    
% ============================================================================================ MENU MEASUREMENT DATA ==%
function menuMeasuerementData_Callback(hObject, eventdata, handles)
% hObject    handle to menuMeasuerementData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menuMeasurementDataLoad_Callback(hObject, eventdata, handles)
% hObject    handle to menuMeasurementDataLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ---------------------------------------------------------------------------------------------------- LOAD HDR FILE --%
function menuMeasurementDataLoadHDR_Callback(hObject, eventdata, handles)
% hObject    handle to menuMeasurementDataLoadHDR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Check if a path already exists
    if isfield(handles, 'pathTempHDR')
        pathTemp = handles.pathTempHDR;
    elseif isfield(handles, 'pathTempXDF');
        pathTemp = handles.pathTempXDF;
    elseif ~isempty(handles.DATA.analysisPathMain)
        pathTemp = handles.DATA.analysisPathMain;
    else
        pathTemp = handles.NIRxGUIDirectory;
    end

    % Load HDR File
    [FileName,PathName] = uigetfile('*.hdr','Please select your HDR File',pathTemp);

    if ~PathName % Selection: Cancel                                                  
        return
    elseif isempty(strfind(FileName,'.hdr')) % Type of file is not HDR                      
        warndlg('The type of the selected file must be HDR!');
        return
    else % Selection was OK                                                   
        handles.DATA.hdr.name = FileName;
        handles.DATA.hdr.path = PathName;

        handles.pathTempAll = PathName;
        handles.pathTempHDR = PathName;

        set(handles.textHDRFilePath, 'String', PathName);
        set(handles.textHDRFileName, 'String', FileName);

        handles.STATUS.hdr = 1;

        checkstatus(handles.STATUS,handles.pushbuttonStartAnalysis,handles.textAnalysisStatus);

        guidata(hObject, handles);
    end

% --------------------------------------------------------------------------------------------------- LOAD XDF FILES --%
function menuMeasurementDataLoadXDF_Callback(hObject, eventdata, handles)
% hObject    handle to menuMeasurementDataLoadXDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Check if a path already exists
    if isfield(handles, 'pathTempXDF')
        pathTemp = handles.pathTempXDF;
    elseif isfield(handles, 'pathTempHDR');
        pathTemp = handles.pathTempHDR;
    elseif ~isempty(handles.DATA.analysisPathMain)
        pathTemp = handles.DATA.analysisPathMain;
    else
        pathTemp = handles.NIRxGUIDirectory;
    end

    [FileName,PathName] = uigetfile('*.xdf','Please select your XDF File(s)','MultiSelect','on',pathTemp);

    if iscell(FileName) % Multiselect: cell array
        falseInput = find(cellfun(@isempty,strfind(FileName,'.xdf')));
        listboxMax = numel(FileName);
    else % One file: char array
        falseInput = isempty(strfind(FileName,'.xdf'));
        listboxMax = 1;
    end

    if ~PathName % Selection: Cancel
        return
    elseif falseInput % Type of file(s) is not XDF
        warndlg('The type of the selected file(s) must be XDF!');
        return
    else % Selection was OK
        handles.DATA.xdf.name = FileName;
        handles.DATA.xdf.path = PathName;

        handles.pathTempAll = PathName;
        handles.pathTempXDF = PathName;

        set(handles.listboxXDFData,  'String', FileName);
        set(handles.listboxXDFData,  'Max',    listboxMax);

        set(handles.textXDFFilePath, 'String', PathName);

        handles.DATA.xdf.selected = 1;
        handles.STATUS.xdf = 1;

        checkstatus(handles.STATUS,handles.pushbuttonStartAnalysis,handles.textAnalysisStatus);

        guidata(hObject, handles);
    end
 
% ------------------------------------------------------------------------------------------------------- CLEAR DATA --%
function menuMeasurementDataClear_Callback(hObject, eventdata, handles)
% hObject    handle to menuMeasurementDataClear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    status = handles.STATUS;
    set(handles.textAnalysisStatus, 'Foregroundcolor', [ 0 127/255 0]);

    if ~status.hdr && ~status.xdf
        msgbox('There is no data to remove!');
        return
    else
        data = handles.DATA;

        if status.hdr
            data = rmfield(data,'hdr');
            status.hdr = 0;
            set(handles.textHDRFilePath, 'String', '');
            set(handles.textHDRFileName, 'String', '');
        end

        if status.xdf
            data = rmfield(data,'xdf');
            status.xdf = 0;
            set(handles.textXDFFilePath, 'String', '');
            set(handles.listboxXDFData, 'String', '');
        end

        checkstatus(status,handles.pushbuttonStartAnalysis,handles.textAnalysisStatus);

        handles.DATA = data;
        handles.STATUS = status;

        set(handles.menuOpenAnalysisPath,'Enable','Off');
        
        guidata(hObject, handles);
    end

 % ----------------------------------------------------------------------------------------------- DEFINE CONDITIONS --%
function menuDataDefineConditions_Callback(hObject, eventdata, handles)
% hObject    handle to menuDataDefineConditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    prompt = 'Number of Conditions';
    dlg_title = 'Define Conditions';
    num_lines = 1;
    
    answer = inputdlg(prompt,dlg_title,num_lines);
    
    if ~isempty(answer)
        nrConditions = str2double(answer{1});
        if isnan(nrConditions)
            errordlg('You have to enter a number!');
        else
            prompt = cell(nrConditions*2,1);
            for i = 1:nrConditions
                prompt{i*2-1,1} = ['Name Condition ' num2str(i)];
                prompt{i*2,1} = ['Marker Nr. Condition ' num2str(i)];
            end
            
            answer = inputdlg(prompt,dlg_title);
            
            if ~isempty(answer)
                for i = 1:nrConditions
                    if isempty(answer{i})
                        errordlg('You have to enter a Name and a Marker Number for each Condition!');
                        return
                    end
                end
                
                cond_string = cell(nrConditions,1);
                cond_number = cell(nrConditions,1);
                for i = 1:nrConditions
                    cond_string{i,1} = answer{i*2-1,1};
                    cond_number{i,1} = answer{i*2,1};
                end
                
                
                set(handles.popupmenuImageClass, 'String', cond_string);
                set(handles.popupmenuImageClass, 'Value', 1);
                set(handles.popupmenuImageClass, 'Enable', 'On');
                
                handles.SETTINGS.imageClass.string = cond_string{1};
                handles.SETTINGS.imageClass.value  = str2double(cond_number{1});
                handles.SETTINGS.imageClass.nrCond = nrConditions;
                handles.SETTINGS.imageClass.list   = answer;
                handles.SETTINGS.imageClass.string_list = cond_string;
                handles.SETTINGS.imageClass.number_list = cond_number;
                
                guidata(hObject, handles);
            else
                return
            end
        end
    else
        return
    end

    
% =============================================================================================== MENU USER SETTINGS ==%
function MenuUserSettings_Callback(hObject, eventdata, handles)
% hObject    handle to MenuUserSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% -------------------------------------------------------------------------------------------------- SAVE SETTINGS ----%
function menuUserSettingsSave_Callback(hObject, eventdata, handles)
% hObject    handle to menuUserSettingsSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [status,handles.filenameSettings] = savesettings(handles.SETTINGS,handles.NIRxGUIDirectory,0,...
                                                     handles.filenameSettings);

    switch status
        case 1
            msgbox('Your settings have been successfully saved!','Save Settings');
            guidata(hObject, handles);
        case 2
            msgbox('Problems with saving the user settings.','Save Settings');
    end
    
% ----------------------------------------------------------------------------------------------- SAVE SETTINGS AS ----%
function menuUserSettingsSaveAs_Callback(hObject, eventdata, handles)
% hObject    handle to menuUserSettingsSaveAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [status,handles.filenameSettings] = savesettings(handles.SETTINGS,handles.NIRxGUIDirectory,1,...
                                                     handles.filenameSettings);

    switch status
        case 1
            msgbox('Your settings have been successfully saved!','Save Settings');
            guidata(hObject, handles);
        case 2
            msgbox('Problems with saving the user settings.','Save Settings');
    end

% ---------------------------------------------------------------------------------------------------- LOAD SETTINGS --%
function menuUserSettingsLoad_Callback(hObject, eventdata, handles)
% hObject    handle to menuUserSettingsLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [settings,handles.filenameSettings] = loadsettings(handles.NIRxGUIDirectory);

    if ~isempty(settings)

        handles.SETTINGS = settings;
        applysettings(handles);

        guidata(hObject, handles);
    end

    
% =============================================================================================== MENU GRAND AVERAGE ==%
function menuGrandAverage_Callback(hObject, eventdata, handles)
% hObject    handle to menuGrandAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ------------------------------------------------------------------------------------------------------ DEFINE ROIS --%
function defineROIs_Callback(hObject, eventdata, handles)
% hObject    handle to defineROIs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    prompt = 'Number of ROIs';
    dlg_title = 'Define ROIs';
    num_lines = 1;
    
    answer = inputdlg(prompt,dlg_title,num_lines);
    
    if ~isempty(answer)
        nrROIs = str2double(answer{1});
        if isnan(nrROIs)
            errordlg('You have to enter a number!');
        else
            
            message = ['Multiple channels have to be separated with a comma ",", a semicolon ";" or space " ".' ...
                        ' Examples: "1,2,3", "1;2;3" or "1 2 3"'];
            title = 'ROI input assistance';
            waitfor(msgbox(message,title));
            
            prompt = cell(1,nrROIs);
            for i = 1:nrROIs
                prompt{1,i} = ['ROI ' num2str(i) ':'];
            end
            
            errorVal = 1;
            
            while errorVal
                
                answer = inputdlg(prompt,dlg_title,num_lines);
            
                if isempty(answer)
                    return
                else
                    
                    errorVal = 0;
                    ROIs = cell(nrROIs,1);
                    
                    for i = 1:nrROIs
                        if isempty(answer{i})
                            errorVal = 1;
                        elseif isempty(str2num(answer{i}))
                            errorVal = 2;
                        else
                            ROIs{i} = str2num(answer{i});
                        end
                    end
                    
                    if errorVal == 1
                        waitfor(errordlg('You have to enter at least 1 channel for each ROI!'));
                    elseif errorVal == 2
                        waitfor(errordlg(message));
                    end
                end
            end
                
            handles.SETTINGS.grandAverage.nrROIs = nrROIs;
            handles.SETTINGS.grandAverage.ROIs = ROIs;

            guidata(hObject, handles);
        end
    else
        return
    end

    
% ---------------------------------------------------------------------------------------------- START GRAND AVERAGE --%
function menuGrandAverageStart_Callback(hObject, eventdata, handles)
% hObject    handle to menuGrandAverageStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if ~isfield(handles.SETTINGS,'grandAverage')
        handles.SETTINGS.grandAverage.nrROIs = 0;
        handles.SETTINGS.grandAverage.ROIs   = [];
    end
        
    if handles.SETTINGS.grandAverage.nrROIs == 0
        errordlg('You have to define your ROIs before starting with the grand average analysis.','Grand Average Error');
        return
    end
    
    handles.STATUS.grandAverage = 1;
    handles.STATUS.analysisPath = 0;
    checkstatus(handles.STATUS,handles.pushbuttonStartAnalysis,handles.textAnalysisStatus);
    
    set(handles.pushbuttonStartAnalysis, 'String', 'Start Grand Average');

    set(handles.listboxXDFData, 'Enable', 'off');

    set(handles.popupmenuSignal, 'Enable', 'off');
%     set(handles.popupmenuImageClass, 'Enable', 'off');
    set(handles.popupmenuProbeset, 'Enable', 'off');
    set(handles.editNrTrials, 'Enable', 'off');
    set(handles.editTaskName, 'Enable', 'off');

    set(handles.checkboxBaselineRemoval, 'Enable', 'off');
    set(handles.checkboxLowPassFilter,'Enable', 'off');
    set(handles.checkboxNotchFilter,'Enable', 'off');
%     set(handles.checkboxCAR,'Enable', 'off');
    set(handles.popupmenuSignalAnalysisMethod, 'Enable', 'off');
    set(handles.popupmenuMayerWavesSource, 'Enable', 'off');
    set(handles.popupmenuCorrectionMode, 'Enable', 'off');

    set(handles.editMayerWavesStart, 'Enable', 'off');
    set(handles.editMayerWavesEnd, 'Enable', 'off');
    set(handles.editMayerWavesInterval, 'Enable', 'off');
    set(handles.editRespirationStart, 'Enable', 'off');
    set(handles.editRespirationEnd, 'Enable', 'off');
    set(handles.editRespirationInterval, 'Enable', 'off');
    set(handles.editPulseStart, 'Enable', 'off');
    set(handles.editPulseEnd, 'Enable', 'off');
    set(handles.editPulseInterval, 'Enable', 'off');
    
    set(handles.editDisplayFrequency, 'Enable', 'off');
%     set(handles.checkboxGenerateFiguresHeartRate,'Enable', 'off');
    set(handles.checkboxGenerateFiguresBiosignals,'Enable', 'off');
    set(handles.checkboxGenerateFiguresRAW,'Enable', 'off');
    
    guidata(hObject, handles);
    
% ----------------------------------------------------------------------------------------------- STOP GRAND AVERAGE --%
function menuGrandAverageStop_Callback(hObject, eventdata, handles)
% hObject    handle to menuGrandAverageStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.STATUS.grandAverage = 0;
    handles.STATUS.analysisPath     = 0;
    checkstatus(handles.STATUS,handles.pushbuttonStartAnalysis,handles.textAnalysisStatus);
    
    set(handles.pushbuttonStartAnalysis, 'String', 'Start Analysis');

    set(handles.listboxXDFData, 'Enable', 'on');

    set(handles.popupmenuSignal, 'Enable', 'on');
    set(handles.popupmenuImageClass, 'Enable', 'on');
    set(handles.popupmenuProbeset, 'Enable', 'on');
    set(handles.editNrTrials, 'Enable', 'on');
    set(handles.editTaskName, 'Enable', 'on');

    set(handles.checkboxBaselineRemoval, 'Enable', 'on');
    set(handles.checkboxLowPassFilter,'Enable', 'on');
    set(handles.checkboxNotchFilter,'Enable', 'on');
%     set(handles.checkboxCAR,'Enable', 'on');
    set(handles.popupmenuSignalAnalysisMethod, 'Enable', 'on');
    set(handles.popupmenuMayerWavesSource, 'Enable', 'on');
    set(handles.popupmenuCorrectionMode, 'Enable', 'on');

    set(handles.editMayerWavesStart, 'Enable', 'on');
    set(handles.editMayerWavesEnd, 'Enable', 'on');
    set(handles.editMayerWavesInterval, 'Enable', 'on');
    set(handles.editRespirationStart, 'Enable', 'on');
    set(handles.editRespirationEnd, 'Enable', 'on');
    set(handles.editRespirationInterval, 'Enable', 'on');
    set(handles.editPulseStart, 'Enable', 'on');
    set(handles.editPulseEnd, 'Enable', 'on');
    set(handles.editPulseInterval, 'Enable', 'on');
    
    set(handles.editDisplayFrequency, 'Enable', 'on');
%     set(handles.checkboxGenerateFiguresHeartRate,'Enable', 'on');
    set(handles.checkboxGenerateFiguresBiosignals,'Enable', 'on');
    set(handles.checkboxGenerateFiguresRAW,'Enable', 'on');
    
    guidata(hObject, handles);

    
% ================================================================================================= LISTBOX XDF DATA ==%
function listboxXDFData_Callback(hObject, eventdata, handles)
% hObject    handle to listboxXDFData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');

    handles.DATA.xdf.selected = value;
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listboxXDFData_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxXDFData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ========================================================================================== UIPANEL SETTINGS BASICS ==%

% --- Executes on selection change in popupmenuSignal. -------------------------------------------- POPUPMENU SIGNAL --%
function popupmenuSignal_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    list  = cellstr(get(hObject,'String'));
    value = get(hObject,'Value');

    handles.SETTINGS.signal.string = list{value};
    handles.SETTINGS.signal.value  = value;

    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenuSignal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuSignal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    list  = cellstr(get(hObject,'String'));
    value = get(hObject,'Value');

    handles.SETTINGS.signal.string = list{value};
    handles.SETTINGS.signal.value  = value;

    guidata(hObject, handles);

% --- Executes on selection change in popupmenuImageClass. ----------------------------------- POPUPMENU IMAGE CLASS --%
function popupmenuImageClass_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuImageClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    list  = cellstr(get(hObject,'String'));
    value = get(hObject,'Value');

    handles.SETTINGS.imageClass.string = list{value};
    handles.SETTINGS.imageClass.value  = str2double(handles.SETTINGS.imageClass.list{value*2});

    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenuImageClass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuImageClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    list  = cellstr(get(hObject,'String'));
    value = get(hObject,'Value');

    handles.SETTINGS.imageClass.string = list{value};
    handles.SETTINGS.imageClass.value  = value;
    handles.SETTINGS.imageClass.list   = list;

    guidata(hObject, handles);

% --- Executes on selection change in popupmenuProbeset. ---------------------------------------- POPUPMENU PROBESET --%
function popupmenuProbeset_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuProbeset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    list  = cellstr(get(hObject,'String'));
    value = get(hObject,'Value');

    handles.SETTINGS.probeset.string = list{value};
    handles.SETTINGS.probeset.value  = value;

    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenuProbeset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuProbeset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    list  = cellstr(get(hObject,'String'));
    value = get(hObject,'Value');

    handles.SETTINGS.probeset.string = list{value};
    handles.SETTINGS.probeset.value  = value;

    guidata(hObject, handles);

% --------------------------------------------------------------------------------------------------- EDIT NR TRIALS --%
function editNrTrials_Callback(hObject, eventdata, handles)
% hObject    handle to editNrTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.nrTrials = value;
        guidata(hObject, handles);
    end

% --- Executes during object creation, after setting all properties.
function editNrTrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNrTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.nrTrials = [];
    guidata(hObject, handles);
    
% --------------------------------------------------------------------------------------------------- EDIT TASK NAME --%
function editTaskName_Callback(hObject, eventdata, handles)
% hObject    handle to editTaskName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    objectString = get(hObject,'String');
    
    handles.SETTINGS.taskName = objectString;
    guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function editTaskName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTaskName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.taskName = [];
    guidata(hObject, handles);

    
% =================================================================================== UIPANEL SETTINGS PREPROCESSING ==%

% --- Executes on selection change in popupmenuCorrectionMode. --------------------------- POPUPMENU CORRECTION MODE --%
function popupmenuCorrectionMode_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuCorrectionMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

list  = cellstr(get(hObject,'String'));
value = get(hObject,'Value');

switch value
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

handles.SETTINGS.correctionMode.string = list{value};
handles.SETTINGS.correctionMode.value  = value;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenuCorrectionMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuCorrectionMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

list  = cellstr(get(hObject,'String'));
value = get(hObject,'Value');

handles.SETTINGS.correctionMode.string = list{value};
handles.SETTINGS.correctionMode.value  = value;

guidata(hObject, handles);
    
 % --- Executes on selection change in popupmenuMayerWavesSource. --------------------- POPUPMENU MAYER WAVES SOURCE --%
function popupmenuMayerWavesSource_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuMayerWavesSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

list  = cellstr(get(hObject,'String'));
value = get(hObject,'Value');

handles.SETTINGS.mayerWavesSource.string = list{value};
handles.SETTINGS.mayerWavesSource.value  = value;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenuMayerWavesSource_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuMayerWavesSource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

list  = cellstr(get(hObject,'String'));
value = get(hObject,'Value');

handles.SETTINGS.mayerWavesSource.string = list{value};
handles.SETTINGS.mayerWavesSource.value  = value;

guidata(hObject, handles);
    
 % --- Executes on selection change in popupmenuSignalAnalysisMethod. ------------- POPUPMENU SIGNAL ANALYSIS METHOD --%
function popupmenuSignalAnalysisMethod_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuSignalAnalysisMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

list  = cellstr(get(hObject,'String'));
valueMethod = get(hObject,'Value');

switch valueMethod
    case 1  % TF --> uncorrected
        set(handles.popupmenuCorrectionMode, 'Enable', 'On');
        set(handles.textCorrectionMode, 'Enable', 'On');
        set(handles.popupmenuCorrectionMode, 'Value', 1);
        list  = cellstr(get(handles.popupmenuCorrectionMode,'String'));
        value = get(handles.popupmenuCorrectionMode,'Value');
        handles.SETTINGS.correctionMode.string = list{value};
        handles.SETTINGS.correctionMode.value  = value;
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
        
    case 2  % ICA --> uncorrected
        set(handles.popupmenuCorrectionMode, 'Enable', 'On');
        set(handles.textCorrectionMode, 'Enable', 'On');
        set(handles.popupmenuCorrectionMode, 'Value', 1);
        list  = cellstr(get(handles.popupmenuCorrectionMode,'String'));
        value = get(handles.popupmenuCorrectionMode,'Value');
        handles.SETTINGS.correctionMode.string = list{value};
        handles.SETTINGS.correctionMode.value  = value;
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
        
    case 3  % CAR
        set(handles.popupmenuCorrectionMode, 'Enable', 'Off');
        set(handles.textCorrectionMode, 'Enable', 'Off');
        set(handles.popupmenuCorrectionMode, 'Value', 1);
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
end

handles.SETTINGS.signalAnalysis.string = list{valueMethod};
handles.SETTINGS.signalAnalysis.value  = valueMethod;

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenuSignalAnalysisMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenuSignalAnalysisMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

list  = cellstr(get(hObject,'String'));
value = get(hObject,'Value');

handles.SETTINGS.signalAnalysis.string = list{value};
handles.SETTINGS.signalAnalysis.value  = value;

guidata(hObject, handles);

% --- Executes on button press in checkboxLowPassFilter. ---------------------------------- CHECKBOX LOW PASS FILTER --%
function checkboxLowPassFilter_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxLowPassFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = get(hObject,'Value');

if value
    set(handles.textLowPassCutOff, 'Enable', 'On');
    set(handles.editLowPassCutOff, 'Enable', 'On');
else
    set(handles.textLowPassCutOff, 'Enable', 'Off');
    set(handles.editLowPassCutOff, 'Enable', 'Off');
end

handles.SETTINGS.lowPass = value;
guidata(hObject,handles);
    
    
function editLowPassCutOff_Callback(hObject, eventdata, handles)
% hObject    handle to editLowPassCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = str2double(get(hObject,'String'));

if isnan(value)
    warndlg('Please enter a number!');
    set(hObject,'String','');
else
    handles.SETTINGS.lowPassCutOff = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function editLowPassCutOff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLowPassCutOff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxNotchFilter. --------------------------------------- CHECKBOX NOTCH FILTER --%
function checkboxNotchFilter_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxNotchFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');

    handles.SETTINGS.notch = value;
    guidata(hObject,handles);
    
 % --- Executes on button press in checkboxBaselineRemoval. ------------------------------ CHECKBOX BASELINE REMOVAL --%
function checkboxBaselineRemoval_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxBaselineRemoval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');

    handles.SETTINGS.baseline = value;
    guidata(hObject,handles);

% --- Executes on button press in checkboxCAR. ----------------------------------- CHECKBOX COMMON AVERAGE REFERENCE --%
function checkboxCAR_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');

    handles.SETTINGS.car = value;
    guidata(hObject,handles);

    
% ===================================================================== UIPANEL SETTINGS BIOLOGICAL ARTEFACT REMOVAL ==%

% ---------------------------------------------------------------------------------------------- MAYER WAVES REMOVAL --%
function editMayerWavesStart_Callback(hObject, eventdata, handles)
% hObject    handle to editMayerWavesStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = str2double(get(hObject,'String'));

if isnan(value)
    warndlg('Please enter a number!');
    set(hObject,'String','');
else
    handles.SETTINGS.mayerWavesRemoval.start = value;
    guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function editMayerWavesStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMayerWavesStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.mayerWavesRemoval.start = [];
    guidata(hObject, handles);
    
function editMayerWavesEnd_Callback(hObject, eventdata, handles)
% hObject    handle to editMayerWavesEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.mayerWavesRemoval.end = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editMayerWavesEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMayerWavesEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.mayerWavesRemoval.end = [];
    guidata(hObject, handles);
  
function editMayerWavesInterval_Callback(hObject, eventdata, handles)
% hObject    handle to editMayerWavesInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.mayerWavesRemoval.interval = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editMayerWavesInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMayerWavesInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.mayerWavesRemoval.interval = [];
    guidata(hObject, handles); 

% ----------------------------------------------------------------------------------------- RESPIRATION PEAK REMOVAL --%
function editRespirationStart_Callback(hObject, eventdata, handles)
% hObject    handle to editRespirationStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.respirationRemoval.start = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editRespirationStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRespirationStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.respirationRemoval.start = [];
    guidata(hObject, handles);

function editRespirationEnd_Callback(hObject, eventdata, handles)
% hObject    handle to editRespirationEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.respirationRemoval.end = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editRespirationEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRespirationEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.respirationRemoval.end = [];
    guidata(hObject, handles);

function editRespirationInterval_Callback(hObject, eventdata, handles)
% hObject    handle to editRespirationInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.respirationRemoval.interval = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editRespirationInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRespirationInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.respirationRemoval.interval = [];
    guidata(hObject, handles);

% ----------------------------------------------------------------------------------------------- PULSE PEAK REMOVAL --%
function editPulseStart_Callback(hObject, eventdata, handles)
% hObject    handle to editPulseStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.pulseRemoval.start = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editPulseStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPulseStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.pulseRemoval.start = [];
    guidata(hObject, handles);

function editPulseEnd_Callback(hObject, eventdata, handles)
% hObject    handle to editPulseEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.pulseRemoval.end = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editPulseEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPulseEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.pulseRemoval.end = [];
    guidata(hObject, handles);

function editPulseInterval_Callback(hObject, eventdata, handles)
% hObject    handle to editPulseInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.pulseRemoval.interval = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editPulseInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPulseInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.pulseRemoval.interval = [];
    guidata(hObject, handles);


% ========================================================================================== UIPANEL SETTINGS TIMING ==%

% ----------------------------------------------------------------------------------------------- EDIT SIGNAL LENGTH --%
function editSignalLength_Callback(hObject, eventdata, handles)
% hObject    handle to editSignalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('You have to enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.timing.signal = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editSignalLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSignalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.timing.signal = [];
    guidata(hObject, handles);

% ------------------------------------------------------------------------------------------------- EDIT PRE TRIGGER --%
function editPreTrigger_Callback(hObject, eventdata, handles)
% hObject    handle to editPreTrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('You have to enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.timing.pre = value;
        guidata(hObject, handles);
    end

% --- Executes during object creation, after setting all properties.
function editPreTrigger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPreTrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.timing.pre = [];
    guidata(hObject, handles);

% ------------------------------------------------------------------------------------------------ EDIT POST TRIGGER --%
function editPostTrigger_Callback(hObject, eventdata, handles)
% hObject    handle to editPostTrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.timing.post = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editPostTrigger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPostTrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.timing.post = [];
    guidata(hObject, handles);


% ======================================================================================== UIPANEL SETTINGS CHANNELS ==%

% --- Executes on button press in checkboxCh1. ---------------------------------------------------------------- CH01 --%
function checkboxCh1_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh2. ---------------------------------------------------------------- CH02 --%
function checkboxCh2_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh3. ---------------------------------------------------------------- CH03 --%
function checkboxCh3_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh4. ---------------------------------------------------------------- CH04 --%
function checkboxCh4_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh5. ---------------------------------------------------------------- CH05 --%
function checkboxCh5_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh6. ---------------------------------------------------------------- CH06 --%
function checkboxCh6_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);
 
% --- Executes on button press in checkboxCh7. ---------------------------------------------------------------- CH07 --%
function checkboxCh7_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh8. ---------------------------------------------------------------- CH08 --%
function checkboxCh8_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh9. ---------------------------------------------------------------- CH09 --%
function checkboxCh9_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh10. --------------------------------------------------------------- CH10 --%
function checkboxCh10_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh11. --------------------------------------------------------------- CH11 --%
function checkboxCh11_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh12. --------------------------------------------------------------- CH12 --%
function checkboxCh12_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh13. --------------------------------------------------------------- CH13 --%
function checkboxCh13_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh14. --------------------------------------------------------------- CH14 --%
function checkboxCh14_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh15. --------------------------------------------------------------- CH15 --%
function checkboxCh15_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh16. --------------------------------------------------------------- CH16 --%
function checkboxCh16_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh17. --------------------------------------------------------------- CH17 --%
function checkboxCh17_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh18. --------------------------------------------------------------- CH18 --%
function checkboxCh18_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh19. --------------------------------------------------------------- CH19 --%
function checkboxCh19_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh20. --------------------------------------------------------------- CH20 --%
function checkboxCh20_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh21. --------------------------------------------------------------- CH21 --%
function checkboxCh21_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh22. --------------------------------------------------------------- CH22 --%
function checkboxCh22_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh23. --------------------------------------------------------------- CH23 --%
function checkboxCh23_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh24. --------------------------------------------------------------- CH24 --%
function checkboxCh24_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh25. --------------------------------------------------------------- CH25 --%
function checkboxCh25_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh26. --------------------------------------------------------------- CH26 --%
function checkboxCh26_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh27. --------------------------------------------------------------- CH27 --%
function checkboxCh27_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh28. --------------------------------------------------------------- CH28 --%
function checkboxCh28_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh29. --------------------------------------------------------------- CH29 --%
function checkboxCh29_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh30. --------------------------------------------------------------- CH30 --%
function checkboxCh30_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh31. --------------------------------------------------------------- CH31 --%
function checkboxCh31_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh32. --------------------------------------------------------------- CH32 --%
function checkboxCh32_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh33. --------------------------------------------------------------- CH33 --%
function checkboxCh33_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh34. --------------------------------------------------------------- CH34 --%
function checkboxCh34_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh35. --------------------------------------------------------------- CH35 --%
function checkboxCh35_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh36. --------------------------------------------------------------- CH36 --%
function checkboxCh36_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh37. --------------------------------------------------------------- CH37 --%
function checkboxCh37_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh38. --------------------------------------------------------------- CH38 --%
function checkboxCh38_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh39. --------------------------------------------------------------- CH39 --%
function checkboxCh39_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh40. --------------------------------------------------------------- CH40 --%
function checkboxCh40_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh41. --------------------------------------------------------------- CH41 --%
function checkboxCh41_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh42. --------------------------------------------------------------- CH42 --%
function checkboxCh42_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh43. --------------------------------------------------------------- CH43 --%
function checkboxCh43_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh44. --------------------------------------------------------------- CH44 --%
function checkboxCh44_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh45. --------------------------------------------------------------- CH45 --%
function checkboxCh45_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh46. --------------------------------------------------------------- CH46 --%
function checkboxCh46_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh47. --------------------------------------------------------------- CH47 --%
function checkboxCh47_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh48. --------------------------------------------------------------- CH48 --%
function checkboxCh48_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh49. --------------------------------------------------------------- CH49 --%
function checkboxCh49_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh50. --------------------------------------------------------------- CH50 --%
function checkboxCh50_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh51. --------------------------------------------------------------- CH51 --%
function checkboxCh51_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh52. --------------------------------------------------------------- CH52 --%
function checkboxCh52_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh53. --------------------------------------------------------------- CH53 --%
function checkboxCh53_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh54. --------------------------------------------------------------- CH54 --%
function checkboxCh54_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh55. --------------------------------------------------------------- CH55 --%
function checkboxCh55_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh56. --------------------------------------------------------------- CH56 --%
function checkboxCh56_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh57. --------------------------------------------------------------- CH57 --%
function checkboxCh57_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh58. --------------------------------------------------------------- CH58 --%
function checkboxCh58_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh59. --------------------------------------------------------------- CH59 --%
function checkboxCh59_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh60. --------------------------------------------------------------- CH60 --%
function checkboxCh60_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxCh61. --------------------------------------------------------------- CH61 --%
function checkboxCh61_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxCh61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    strCh = strrep(get(hObject,'String'),'Ch','');
    numCh = str2double(strCh);
    
    channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
    channelOptionsTag = get(channelOptionsObject, 'Tag');
    
    switch channelOptionsTag
        case 'radiobuttonDisplayChannels'
            handles.SETTINGS.channels.display(numCh) = value;
        case 'radiobuttonExcludeChannels'
            handles.SETTINGS.channels.exclude(numCh) = value;
    end
    
    guidata(hObject,handles);

% --- Executes on button press in checkboxChAll. ------------------------------------------------------------ CH ALL --%
function checkboxChAll_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxChAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject, 'Value');

    if value
        nrCh = handles.SETTINGS.channels.nr;
        for i = 1:nrCh
            set(eval(['handles.checkboxCh' num2str(i)]),'Value',value);
        end
        set(handles.checkboxChNone,'Value',~value);

        channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
        channelOptionsTag = get(channelOptionsObject, 'Tag');

        switch channelOptionsTag
            case 'radiobuttonDisplayChannels'
                handles.SETTINGS.channels.display(1:nrCh) = value;
            case 'radiobuttonExcludeChannels'
                handles.SETTINGS.channels.exclude(1:nrCh) = value;
        end
        guidata(hObject,handles);
    end

% --- Executes on button press in checkboxChNone. ---------------------------------------------------------- CH NONE --%
function checkboxChNone_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxChNone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject, 'Value');

    if value
        nrCh = handles.SETTINGS.channels.nr;
        for i = 1:nrCh
            set(eval(['handles.checkboxCh' num2str(i)]),'Value',~value);
        end
        set(handles.checkboxChAll,'Value',~value);

        channelOptionsObject = get(handles.uipanelChannelOptions, 'SelectedObject');
        channelOptionsTag = get(channelOptionsObject, 'Tag');

        switch channelOptionsTag
            case 'radiobuttonDisplayChannels'
                handles.SETTINGS.channels.display(1:nrCh) = ~value;
            case 'radiobuttonExcludeChannels'
                handles.SETTINGS.channels.exclude(1:nrCh) = ~value;
        end
       
        guidata(hObject,handles);
    end

% --- Executes when selected object is changed in uipanelChannelOptions. --------------------------- CHANNEL OPTIONS --%
function uipanelChannelOptions_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanelChannelOptions 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

newButton = get(eventdata.NewValue, 'tag');

switch newButton
    case 'radiobuttonDisplayChannels'
        for i = 1:handles.SETTINGS.channels.nr
            set(eval(['handles.checkboxCh' num2str(i)]),'Value',handles.SETTINGS.channels.display(i));
        end
    case 'radiobuttonExcludeChannels'
        for i = 1:handles.SETTINGS.channels.nr
            set(eval(['handles.checkboxCh' num2str(i)]),'Value',handles.SETTINGS.channels.exclude(i));
        end
end
    

% ================================================================================================ UIPANEL ARTEFACTS ==%

% --- Executes on button press in checkboxExcludeTrials. ----------------------------------- CHECKBOX EXCLUDE TRIALS --%
function checkboxExcludeTrials_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxExcludeTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    nrTrials = handles.SETTINGS.nrTrials;
    
    if value
        if isempty(nrTrials)
            warndlg('You have to determine the Number of Trials first!');
            value = 0;
            set(hObject, 'Value', value);
            return
        else
            [excludeTrialsArray,status] = excludetrials(hObject,nrTrials);
            if status
                handles.SETTINGS.excludeTrials.array = excludeTrialsArray;
            else
                return
            end
        end
    else
        handles.SETTINGS.excludeTrials.array = zeros(1,nrTrials);
    end

    handles.SETTINGS.excludeTrials.value = value;
    guidata(hObject,handles);

% --- Executes on button press in checkboxExcludeChannels. ------------------------------- CHECKBOX EXCLUDE CHANNELS --%
function checkboxExcludeChannels_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxExcludeChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    value = get(hObject,'Value');

    if value
        set(handles.radiobuttonExcludeChannels, 'Enable', 'On');
        set(handles.uipanelChannelOptions,'SelectedObject', handles.radiobuttonExcludeChannels);
        for i = 1:handles.SETTINGS.channels.nr
            set(eval(['handles.checkboxCh' num2str(i)]),'Value',handles.SETTINGS.channels.exclude(i));
        end
    else
        set(handles.radiobuttonExcludeChannels, 'Enable', 'Off');
        set(handles.uipanelChannelOptions,'SelectedObject', handles.radiobuttonDisplayChannels);
        for i = 1:handles.SETTINGS.channels.nr
            set(eval(['handles.checkboxCh' num2str(i)]),'Value',handles.SETTINGS.channels.display(i));
        end
        handles.SETTINGS.channels.exclude = zeros(1,handles.SETTINGS.channels.nr);
    end
    
    handles.SETTINGS.excludeChannels = value;
    guidata(hObject,handles);

% --- Executes on button press in checkboxConsiderOptodeFailure. --------------------- CHECKBOX CONSIDER OPTODE FAIL --%
function checkboxConsiderOptodeFailure_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxConsiderOptodeFailure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');

    if value
        [optodeFailureCell,status] = consideroptodefailure(handles.SETTINGS.channels.nr);
        if status
            handles.SETTINGS.optodeFail.cellArray = optodeFailureCell;
        else
            set(hObject, 'Value', 0);
            return
        end
    else
        handles.SETTINGS.optodeFail.cellArray = [];
    end
    
    handles.SETTINGS.optodeFail.value = value;
    guidata(hObject,handles);
    
    
% ========================================================================================== UIPANEL FIGURE OPTIONS ==%

% ------------------------------------------------------------------------------------------- EDIT DISPLAY FREQUENCY --%
function editDisplayFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to editDisplayFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = str2double(get(hObject,'String'));

    if isnan(value)
        warndlg('Please enter a number!');
        set(hObject,'String','');
    else
        handles.SETTINGS.displayFrequency = value;
        guidata(hObject,handles);
    end

% --- Executes during object creation, after setting all properties.
function editDisplayFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDisplayFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    handles.SETTINGS.displayFrequency = [];
    guidata(hObject, handles);

% --- Executes on button press in checkboxGenerateFiguresHeartRate. ----------- CHECKBOX GENERATE FIGURES HEART RATE --%
function checkboxGenerateFiguresHeartRate_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxGenerateFiguresHeartRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    handles.SETTINGS.generateFiguresHeartRate = value;

    guidata(hObject,handles);

% --- Executes on button press in checkboxGenerateFiguresBiosignals. ---------- CHECKBOX GENERATE FIGURES BIOSIGNALS --%
function checkboxGenerateFiguresBiosignals_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxGenerateFiguresBiosignals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    handles.SETTINGS.generateFiguresBiosignals = value;

    guidata(hObject,handles);

% --- Executes on button press in checkboxGenerateFiguresRAW. -------------------- CHECKBOX GENERATE FIGURES SPECTRA --%
function checkboxGenerateFiguresRAW_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxGenerateFiguresRAW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    handles.SETTINGS.generateFiguresRAW = value;

    guidata(hObject,handles);

% --- Executes on button press in checkboxGenerateFiguresBloodOxy. ------------- CHECKBOX GENERATE FIGURES BLOOD OXY --%
function checkboxGenerateFiguresBloodOxy_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxGenerateFiguresBloodOxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    value = get(hObject,'Value');
    handles.SETTINGS.generateFiguresBloodOxy = value;

    guidata(hObject,handles);

% --- Executes on button press in checkboxGenerateFiguresTopoplot. -------------- CHECKBOX GENERATE FIGURES TOPOPLOT --%
function checkboxGenerateFiguresTopoplot_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxGenerateFiguresTopoplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	value = get(hObject,'Value');
    handles.SETTINGS.generateFiguresTopoplot = value;

    guidata(hObject,handles);

% --- Executes on button press in checkboxPlotSTD. ---------------------------------------- CHECKBOX PLOT STD SIGNAL --%
function checkboxPlotSTD_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxPlotSTD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    value = get(hObject,'Value');
    handles.SETTINGS.plotSTD = value;

    guidata(hObject,handles);

% ======================================================================================== PUSHBUTTON START ANALYSIS ==%
% --- Executes on button press in pushbuttonStartAnalysis.
function pushbuttonStartAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStartAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    analysisStat = handles.textAnalysisStatus;
    listbox  = handles.listboxOutput;

    % Prepare the Evaluation Status
    set(analysisStat, 'String', '');
    set(analysisStat, 'Foregroundcolor', 'k');

    % Prepare the Output Text
    set(listbox, 'String', '');

    % Close all figures
    set(handles.menuFileCloseFigures,'Enable','On');
    set(handles.menuOpenAnalysisPath,'Enable','On');
    
    % ------------------------------------------------------------------------------------------------ GRAND AVERAGE --%
    if handles.STATUS.grandAverage 
        try
            data     = handles.DATA;
            settings = handles.SETTINGS;
            Tcell = [];

            set(analysisStat, 'String', 'Loading Data-Files ...');
            pause(0.01);
            [nirxAll,nirx,fileCell,status] = grandaveragegetdata(data.analysisPathMain);
            if ~status
                return
            end
            
%             timeStamp = generatetimestamp;
            condition = settings.imageClass.string;
            data.analysisPath = [data.analysisPathMain filesep 'Grand Average' filesep condition];
            data.analysisFilename = ['Grand_Average_' condition];

            fs = nirx.settings.fs;
            timing = [-settings.timing.pre (settings.timing.signal+settings.timing.post)];
            nirx.settings.t_trial = [round(timing(1)*fs):1:round(timing(2)*fs-1)];

%             signalOxy = nirxAll{1}.oxy_Hb;
%             signalDeoxy = nirxAll{1}.deoxy_Hb;
            
            if ~exist(data.analysisPath,'dir')
                mkdir(data.analysisPath)
            end

            set(analysisStat, 'String', 'Generating Concentration Plot and Head Topoplot ...');
            pause(0.01);
            [T,nirx] = evalc('generateheadplot(nirx,settings,data,handles.STATUS)');
            % Display Message
            Tcell = displayoutputmessage(T,Tcell,listbox);

            % Generate XLSX Output
            set(analysisStat, 'String', 'Generating XLSX Output ...');
            pause(0.01);
            [T,status] = evalc('grandaverageoutputfile(nirxAll,nirx,settings,data)');
            Tcell = displayoutputmessage(T,Tcell,listbox);
            
            % Save Output to TXT File
            set(analysisStat, 'String', 'Saving Filenames ...');
            pause(0.01);
            dlmwrite([data.analysisPath filesep data.analysisFilename '_Filenames.txt'],fileCell,'delimiter','');

            set(analysisStat, 'String', 'Grand Average finished!');
            set(handles.menuOpenAnalysisPath,'Enable','On');
            
            handles.DATA = data;
            handles.SETTINGS = settings;
            guidata(hObject,handles);
            beep;
        catch ME
            errFile = ME.stack.file;
            errLine = ME.stack.line;
            errMess = ME.message;
            errordlg(['Error in File ' errFile ' at line ' num2str(errLine) ': ' errMess]);
            set(analysisStat, 'Foregroundcolor', 'red');
            beep;
        end
    % ----------------------------------------------------------------------------------------------------- ANALYSIS --%    
    else
        status = checksettings(handles.SETTINGS);

        if ~status
            warndlg('The Settings have to be complete!');
            return
        else
            try
                data     = handles.DATA;
                settings = handles.SETTINGS;

                data.analysisPath = [];
                Tcell = [];

                % Create Evaluation Path
                [data.analysisPath,data.analysisFilename] = createevaluationpath(settings,data);
                if isempty(data.analysisPath)
                    set(analysisStat, 'String', 'Could not create Analysis Path');
                    set(analysisStat, 'Foregroundcolor', 'red');
                    return
                end
                
                % Load XDF Data
                set(analysisStat, 'String', 'Loading XDF-Data ...');
                pause(0.01);
                [T,nirx,status] = evalc('loadNIRxXDF(data,settings)');
                % Display Message
                Tcell = displayoutputmessage(T,Tcell,listbox);
                if ~status
                    set(analysisStat, 'String', 'Error while loading XDF-Data');
                    set(analysisStat, 'Foregroundcolor', 'red');
                    return
                end

                % Check Probeset
                set(analysisStat, 'String', 'Checking Probeset ...');
                pause(0.01);
                nirx = checkprobeset(nirx,settings.probeset.value);

                % Generate Evaluation Filename
                [nirx,PathCorrmode] = generatefilename(nirx,settings);

                % Generate Biosignals and Concentration Change Signals, Get
                % Markers
                set(analysisStat, 'String', 'Generating Biosignals and Concentration Change Signals...');
                pause(0.01);
                [T, nirx, status] = evalc('generatebiosignals(nirx,settings,data)');
                % Display Message
                Tcell = displayoutputmessage(T,Tcell,listbox);
                if ~status
                    set(analysisStat, 'String', 'Error while generating Biosignals and Conc. Change Signals');
                    set(analysisStat, 'Foregroundcolor', 'red');
                    return
                end

                % Baseline Removal and Low-Pass Filtering
                set(analysisStat, 'String', 'Removing Baseline and Filtering ...');
                pause(0.01);
                [T, nirx] = evalc('doblnoNIRx(nirx,settings)');
                % Display Message
                Tcell = displayoutputmessage(T,Tcell,listbox);

                % Generate Raw Spectra
                if settings.generateFiguresRAW 
                    set(analysisStat, 'String', 'Generating RAW Spectra ...');
                    pause(0.01);
                    [T, nirx] = evalc('generaterawspectra(nirx, settings, data)');
                    % Display Message
                    Tcell = displayoutputmessage(T,Tcell,listbox);
                end

                % Remove Physiological Artefacts
                set(analysisStat, 'String', 'Removing Physiological Artefacts ...');
                pause(0.01);
                [T, nirx] = evalc('removephysio(nirx, settings)');
                % Display Message
                Tcell = displayoutputmessage(T,Tcell,listbox);

                % Generate Cleaned Spectra
                if settings.generateFiguresRAW 
                    set(analysisStat, 'String', 'Generating Cleaned Spectra ...');
                    pause(0.01);
                    [T,nirx] = evalc('generatecleanedspectra(nirx,settings,data)');
                    % Display Message
                     Tcell = displayoutputmessage(T,Tcell,listbox);
                end

                % Compare Spectra
                set(analysisStat, 'String', 'Comparing Spectra ...');
                pause(0.01);
                [T,nirx] = evalc('comparespectra(nirx,settings,data) ');
                % Display Message
                Tcell = displayoutputmessage(T,Tcell,listbox);

                % Generate Concentration Change and Head Topoplot
                set(analysisStat, 'String', 'Generating Concentration Plot and Head Topoplot ...');
                pause(0.01);
                [T,nirx] = evalc('generateheadplot(nirx,settings,data,handles.STATUS)');
                % Display Message
                Tcell = displayoutputmessage(T,Tcell,listbox);

                % Save Output to TXT File
                saveoutputtotxtfile(Tcell,data);

                % Save Output to XLSX File
                set(analysisStat, 'String', 'Generating XLSX-Output ...');
                pause(0.01);
                [T,stat] = evalc('writecsvoutput(nirx.Data.oxy_Hb,nirx.Data.deoxy_Hb,data.analysisPath,data.analysisFilename)');
                if ~stat
                    set(analysisStat, 'String', 'Error whith saving XLSX-Output');
                    set(analysisStat, 'Foregroundcolor', 'red');
                end
                % Display Message
                Tcell = displayoutputmessage(T,Tcell,listbox);

                handles.DATA = data;
                handles.SETTINGS = settings;

                % Save structure
                guidata(hObject, handles);

                % End of Evaluation
                set(analysisStat, 'String', 'Analysis finished!');
                set(analysisStat, 'Foregroundcolor', [ 0 127/255 0]);
                try
                    figure(handles.figure1);
                catch
                end
                
            catch ME
                errFile = ME.stack.file;
                errLine = ME.stack.line;
                errMess = ME.message;
                errordlg(['Error in File ' errFile ' at line ' num2str(errLine) ': ' errMess]);
                set(analysisStat, 'Foregroundcolor', 'red');
                handles.DATA = data;
                handles.SETTINGS = settings;
                % Save structure
                guidata(hObject, handles);
                beep;
                try
                    saveoutputtotxtfile(Tcell,data);
                    stat = writecsvoutput(nirx.Data.oxy_Hb,nirx.Data.deoxy_Hb,data.analysisPath,data.analysisFilename);
                    return
                catch
                    errordlg('Could not save all output files!');
                    return
                end
            end
        end  
    end
    
% =================================================================================================== LISTBOX OUTPUT ==%
% --- Executes on selection change in listboxOutput.
function listboxOutput_Callback(hObject, eventdata, handles)
% hObject    handle to listboxOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function listboxOutput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% =========================================================================================== CLOSE REQUEST FUNCTION ==%
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Construct a questdlg with three options
    response = questdlg( 'Do you want to save your settings?', ['Close ' mfilename], 'Yes','No','Cancel','Cancel');

    % Handle response
    switch response 
        case 'Yes' % Close NIRx GUI and try saving user settings   
            % Save settings: status = 1, if the user input was correct and the setting file could be saved
            %                status = 0, otherwise       
            [status,handles.filenameSettings] = ...
                savesettings(handles.SETTINGS,handles.NIRxGUIDirectory,0,handles.filenameSettings);
            if status % Close NIRx GUI with saving user settings
                delete(hObject);
            else % Continue
                return
            end        
        case 'No' % Close NIRx GUI without saving user settings
            delete(hObject);        
        case 'Cancel' % Continue
            return
    end



function editRangeMin_Callback(hObject, eventdata, handles)
% hObject    handle to editRangeMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRangeMin as text
%        str2double(get(hObject,'String')) returns contents of editRangeMin as a double

value = str2double(get(hObject,'String'));

if isnan(value)
    warndlg('Please enter a number!');
    set(hObject,'String','');
else
    handles.SETTINGS.rangeMin = value;
    guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function editRangeMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRangeMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.SETTINGS.rangeMin = [];
guidata(hObject, handles);


function editRangeMax_Callback(hObject, eventdata, handles)
% hObject    handle to editRangeMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRangeMax as text
%        str2double(get(hObject,'String')) returns contents of editRangeMax as a double

value = str2double(get(hObject,'String'));

if isnan(value)
    warndlg('Please enter a number!');
    set(hObject,'String','');
else
    handles.SETTINGS.rangeMax = value;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function editRangeMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRangeMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.SETTINGS.rangeMax = [];
guidata(hObject, handles);


% --- Executes on button press in checkboxMarkerOffset.
function checkboxMarkerOffset_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxMarkerOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxMarkerOffset
value = get(hObject,'Value');

handles.SETTINGS.markerOffset = value;
guidata(hObject,handles);



function editNrTopoplots_Callback(hObject, eventdata, handles)
% hObject    handle to editNrTopoplots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value = str2double(get(hObject,'String'));

if isnan(value)
    warndlg('Please enter a number!');
    set(hObject,'String','');
else
    handles.SETTINGS.nrTopoplots = value;
    guidata(hObject,handles);
end
    

% --- Executes during object creation, after setting all properties.
function editNrTopoplots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNrTopoplots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.SETTINGS.nrTopoplots = [];
guidata(hObject, handles);
