% Modified 04.03.2016
% Bachmaier Dominik
% Changes: Adapted to new version of NIRS setup including LSL recorder

Timing=NIRx.settings.Timing;
T = (Timing(1):1/fs:Timing(2));   % Time vector

%ges_head_XXX= (time x ch x subj)
MatVal=[];
txt=[];
for nr_ch=1:size(ges_head_oxy,2)
    for nr_timepoint=1:length(TimePointList)
        TimePoint=TimePointList{nr_timepoint};
        txt=[txt, {['w', num2str(nr_timepoint)]}];
        if length(TimePoint)==2
            tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
        else
            tpidx = [min(find(T>TimePoint(1)))];
        end
        for nr_sub=1:1:size(ges_head_oxy,3)
            MatVal(nr_sub,nr_timepoint) =mean(ges_head_deoxy(tpidx,nr_ch,nr_sub));
        end
    end
    
    txt1=txt;
    
    if strcmp(Session, 'Single')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        end
    elseif strcmp(Session, 'Grand')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        end
    end
    %%%%%
    MatVal=[];
    txt=[];
end

for nr_ch=1:size(ges_head_oxy,2)
    for nr_timepoint=1:length(TimePointList)
        TimePoint=TimePointList{nr_timepoint};
        txt=[txt, {['w', num2str(nr_timepoint)]}];
        if length(TimePoint)==2
            tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
        else
            tpidx = [min(find(T>TimePoint(1)))];
        end
        for nr_sub=1:1:size(ges_head_oxy,3)
            MatVal(nr_sub,nr_timepoint) =mean(ges_head_oxy(tpidx,nr_ch,nr_sub));
        end
    end
    
    txt1=txt;
    if strcmp(Session, 'Single')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        end
    elseif strcmp(Session, 'Grand')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            else
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1');
                xlswrite([DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
            end
        end
    end
    MatVal=[];
    txt=[];
end



