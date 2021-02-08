function handles = savedatatohandles(handles,nirx,data,settings,signalOxy,signalDeoxy)

    handles.NIRx = nirx;
    handles.DATA = data;
    handles.SETTINGS = settings;
    handles.SIGNAL.oxy = signalOxy;
    handles.SIGNAL.deoxy = signalDeoxy;
end