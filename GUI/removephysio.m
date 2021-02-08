function NIRx = removephysio(NIRx, settings)

    %%%%%%%%%%%%%%%%%%%%
    %%%Removal Physio%%%
    %%%%%%%%%%%%%%%%%%%%
    
    NIRx.settings.ExCh = [];
    oxy_signal = NIRx.Data.Concentration.clean.oxy;
    deoxy_signal = NIRx.Data.Concentration.clean.deoxy;

    %CAR
    if settings.signalAnalysis.value == 3
        [oxy_signal, deoxy_signal]=carNIRx(oxy_signal, deoxy_signal, NIRx, settings);
    else % TF and ICA
        %Corr Mayer, Resp, ... 
        [oxy_signal, deoxy_signal,NIRx]=corrNIRx(oxy_signal, deoxy_signal, NIRx, settings);
    end
    
    NIRx.Data.Concentration.clean.oxy = oxy_signal;
    NIRx.Data.Concentration.clean.deoxy = deoxy_signal;
    
    disp('physio artefacts removed');
    
end
