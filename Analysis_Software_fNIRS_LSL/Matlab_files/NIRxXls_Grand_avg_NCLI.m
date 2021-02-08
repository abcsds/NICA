




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
                if Add_CAR
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\add_car\',G.FileName{1},'_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\add_car\',G.FileName{1},'_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
                else
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');        
                end
            elseif strcmp(Session, 'Grand')
                if Add_CAR
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\add_car\','Grand','_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\add_car\','Grand','_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');          
                else
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_statistic_Deoxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_statistic_Deoxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');         
                end    
            end        
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
                if Add_CAR
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\add_car\',G.FileName{1},'_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\add_car\',G.FileName{1},'_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');
                else
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', G.FileName{1},'\CAR_0\',G.FileName{1},'_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');        
                end
            elseif strcmp(Session, 'Grand')
                if Add_CAR
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\add_car\','Grand','_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\add_car\','Grand','_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');          
                else
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_statistic_Oxy'],txt1, ['Sheet',num2str(nr_ch)], 'A1'); 
                   xlswrite([DatenPath, 'Analyse\', 'Grand','\CAR_0\','Grand','_',modality,'_statistic_Oxy'],MatVal, ['Sheet',num2str(nr_ch)], 'A2');         
                end    
            end        
            MatVal=[];
            txt=[];
        
        
        

end



