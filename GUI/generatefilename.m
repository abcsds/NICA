function [NIRx,PathCorrmode] = generatefilename(NIRx,settings)

%Dateibenennung:
switch settings.correctionMode.value
    case 1
        NIRx.settings.Usage.corrmode='_uncorr';
        PathCorrmode = 'uncorr';
    case 2
        NIRx.settings.Usage.corrmode='_resp_corr';
        PathCorrmode = 'resp_corr';
    case 3
        NIRx.settings.Usage.corrmode='_mayer_corr';
        PathCorrmode = 'mayer_corr';
    case 4
        NIRx.settings.Usage.corrmode='_mayer_and_resp_corr';
        PathCorrmode = 'mayer_resp_corr';
    case 5
        NIRx.settings.Usage.corrmode='_mayer_resp_and_puls_corr';
        PathCorrmode = 'mayer_resp_puls_corr';
    case 6
        NIRx.settings.Usage.corrmode='_adap_puls';    
        PathCorrmode = 'adap_puls';
    case 7
        NIRx.settings.Usage.corrmode='_online_puls';  
        PathCorrmode = 'online_puls';
    case 8
        NIRx.settings.Usage.corrmode='_TP_Zhang'; 
        PathCorrmode = 'TP_Zhang';
end

switch settings.signalAnalysis.value
    case 1
        NIRx.settings.Usage.TFICA='_TF';
        NIRx.settings.Usage.CAR='';
    case 2
        NIRx.settings.Usage.TFICA='_ICA';
        NIRx.settings.Usage.CAR='';
    case 3
        NIRx.settings.Usage.CAR='_CAR';
        NIRx.settings.Usage.TFICA='';
        NIRx.settings.Usage.corrmode='';
end


    
    
