
% Dominik:

Scale = 30;
%Scale=25; % 0.075 : -0.05
%Scale=15; % 0.1 : -0.075
% Scale=10; % 0.15 : -0.1
% Scale=7.5; % 0.2 : -0.15
%  Scale=5; % 0.3 : -0.2
% Scale=0.1;

%%%%%%

%TimePointList={[-3 0];[6 9];[10 13]; [13 16]}; %original
TimePointList={[-5 0];[0 5];[5 10];[10 15];[15 19]};
%%%%%%%%

if size(head_oxy,2)==50
    ElectrodeLocation = 'NIRx50b.loc';
elseif size(head_oxy,2)==12
    ElectrodeLocation = 'NIRx12.loc';
elseif size(head_oxy,2)==47
    ElectrodeLocation = 'NIRx47.loc';
elseif size(head_oxy,2)==24
    ElectrodeLocation = 'NIRx99.loc'; %Labor
elseif size(head_oxy,2)==38
    ElectrodeLocation = 'NIRxMATred.loc';
    
    
    tmp=[head_oxy(:,2) head_oxy(:,5) head_oxy(:,4) head_oxy(:,16) head_oxy(:,8)...
        head_oxy(:,9) head_oxy(:,10) head_oxy(:,13) head_oxy(:,18) head_oxy(:,21)...
        head_oxy(:,24) head_oxy(:,25) head_oxy(:,15) head_oxy(:,29) head_oxy(:,23)...
        head_oxy(:,36) head_oxy(:,28) head_oxy(:,31) head_oxy(:,34) head_oxy(:,38)];
    
    head_oxy=[];
    head_oxy=tmp;
    
    tmp=[head_deoxy(:,2) head_deoxy(:,5) head_deoxy(:,4) head_deoxy(:,16) head_deoxy(:,8)...
        head_deoxy(:,9) head_deoxy(:,10) head_deoxy(:,13) head_deoxy(:,18) head_deoxy(:,21)...
        head_deoxy(:,24) head_deoxy(:,25) head_deoxy(:,15) head_deoxy(:,29) head_deoxy(:,23)...
        head_deoxy(:,36) head_deoxy(:,28) head_deoxy(:,31) head_deoxy(:,34) head_deoxy(:,38)];
    
    head_deoxy=[];
    head_deoxy=tmp;
elseif size(head_oxy,2)==42
    ElectrodeLocation = 'NIRxsport.loc';
elseif size(head_oxy,2)==61
    ElectrodeLocation = 'NIRxsport_neu.loc';
else
    error('channel number not supported')
end

load erdcolormap;

Timing=NIRx.settings.Timing;
T = (Timing(1):1/fs:Timing(2));   % Time vector

if topoplotsSingle
    for k = 1 : length(TimePointList)
        TimePoint=TimePointList{k};
        % Extract data for head
        MatVal=zeros(size(head_oxy,2), 1);
        if length(TimePoint)==2
            tpidx = min(find(T>TimePoint(1))):max(find(T<TimePoint(2)));
        else
            tpidx = min(find(T>TimePoint(1)));
        end
        
        % hier berechnet er für jeden Channel für die Zeit, die betrachtet
        % wird, den Mittelwert für HbO
        for ch=1:size(head_oxy,2)
            MatVal(ch)=mean(head_oxy(tpidx,ch)); 
            txt='HbO';
        end
        
        MatVal(NIRx.settings.ExCh)=0;
        figure
        topoplot(MatVal, ElectrodeLocation);%normal
        title(sprintf('%s - %s: t=%1.0f-%1.0f', D{1}.MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
        colormap(erdcolormap)
        caxis([-1 1.5]/Scale)

        if NIRx.settings.corrmode==0
            print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        elseif NIRx.settings.corrmode==7
            print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        else
            print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
        end
        
    end %for k = 1 : length(TimePointList)
    
    for k = 1 : length(TimePointList)
        TimePoint=TimePointList{k};
        % Extract data for head
        MatVal=[];
        if length(TimePoint)==2
            tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
        else
            tpidx = [min(find(T>TimePoint(1)))];
        end
        for ch=1:size(head_oxy,2)
            MatVal(ch) = mean(head_deoxy(tpidx,ch)); txt='Hb';
        end
        MatVal(NIRx.settings.ExCh)=0;
        
        figure
        topoplot(MatVal, ElectrodeLocation); %,'maplimits',[-0.2 0.2]);
        title(sprintf('%s - %s: t=%1.0f-%1.0f', D{1}.MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
        colormap(erdcolormap)
        caxis([-1 1.5]/Scale)
        
        if NIRx.settings.corrmode==0
            print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        elseif NIRx.settings.corrmode==7
            print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        else
            print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
        end
    end %for k = 1 : length(TimePointList)
else
    hfig=figure(300);
    set(hfig,'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%     text(0.15,0.1,txt, 'FontSize', 14)
    for k = 1 : length(TimePointList)
        TimePoint=TimePointList{k};
        % Extract data for head
        MatVal=zeros(size(head_oxy,2), 1);
        if length(TimePoint)==2
            tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
        else
            tpidx = [min(find(T>TimePoint(1)))];
        end
        
        % hier berechnet er für jeden Channel für die Zeit, die betrachtet
        % wird, den Mittelwert für HbO
        for ch=1:size(head_oxy,2)
            MatVal(ch)=mean(head_oxy(tpidx,ch)); txt='HbO:';
        end
        
        MatVal(NIRx.settings.ExCh)=0;
        subplot(2,length(TimePointList),k)
        topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2]); %,'maplimits',[-0.2 0.2]);%normal
        title(sprintf('t=%1.0f-%1.0f', TimePoint(1), TimePoint(2)),'interpreter','none')
        colormap(erdcolormap)
%         colorbar
        caxis([-1 1.5]/Scale)
        
        %     if NIRx.settings.corrmode==0
        %         print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        %         saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        %     elseif NIRx.settings.corrmode==7
        %         print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        %         saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        %     else
        %         print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
        %         saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
        %     end
        
        
    end %for k = 1 : length(TimePointList)
    
%     text(1000,200,'HbO', 'FontSize', 14)
    % subplot(2,length(TimePointList)+1,k+1)

    set(gcf,'color','w')
    set(gcf,'Position',[10 540 560 420])
    
    set(gcf,'PaperPositionMode','auto')
    
    for k = 1 : length(TimePointList)
        TimePoint=TimePointList{k};
        % Extract data for head
        MatVal=[];
        if length(TimePoint)==2
            tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
        else
            tpidx = [min(find(T>TimePoint(1)))];
        end
        for ch=1:size(head_oxy,2)
            MatVal(ch) = mean(head_deoxy(tpidx,ch)); txt='Hb';
        end
        MatVal(NIRx.settings.ExCh)=0;
        
        subplot(2,length(TimePointList),k+length(TimePointList))
        topoplot(MatVal, ElectrodeLocation); %,'maplimits',[-0.2 0.2]);
        %title(sprintf('%s - %s: t=%1.0f-%1.0f', D{1}.MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
        colormap(erdcolormap)
        caxis([-1 1.5]/Scale)
        
        %     colorbar
        %     set(gcf,'color','w')
        %     set(gcf,'Position',[10 540 560 420])
        %
        %     set(gcf,'PaperPositionMode','auto')
        %
        
        
    end %for k = 1 : length(TimePointList)
    colorbar('position', [0.91, 0.36, 0.015, 0.35])
    axes('position',[0,0,1,1],'visible','off');
    text(0.07,0.75,'HbO', 'FontSize', 22)
    text(0.07,0.29,'Hb', 'FontSize', 22)

    if NIRx.settings.corrmode==0
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplots',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    elseif NIRx.settings.corrmode==7
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
    else
        print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
        saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
    end
end


%     for k = 1 : length(TimePointList)
%         TimePoint=TimePointList{k};
%         % Extract data for head
%         MatVal=[];
%         if length(TimePoint)==2
%             tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
%         else
%             tpidx = [min(find(T>TimePoint(1)))];
%         end
%         for ch=1:size(head_oxy,2)
%             MatVal(ch) =mean(head_oxy(tpidx,ch)); txt='HbO';
%
%         end
%         MatVal(NIRx.settings.ExCh)=0;
%         figure
%         topoplot(MatVal, ElectrodeLocation,'maplimits',[-0.2 0.2]);%normal
%         title(sprintf('%s - %s : t=%3.1f-%3.1f', D{1}.MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
%         colormap(erdcolormap)
%         caxis([-1 1.5]/Scale)
%
%         colorbar
%         set(gcf,'color','w')
%         set(gcf,'Position',[10 540 560 420])
%
%         set(gcf,'PaperPositionMode','auto')
%
%
%
%
%         if NIRx.settings.corrmode==0
%             print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
%             saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
%         elseif NIRx.settings.corrmode==7
%             print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
%             saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
%         else
%             print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
%             saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
%         end
%
%     end %for k = 1 : length(TimePointList)
%
%     for k = 1 : length(TimePointList)
%         TimePoint=TimePointList{k};
%         % Extract data for head
%         MatVal=[];
%         if length(TimePoint)==2
%             tpidx = [min(find(T>TimePoint(1))):max(find(T<TimePoint(2)))];
%         else
%             tpidx = [min(find(T>TimePoint(1)))];
%         end
%         for ch=1:size(head_oxy,2)
%             MatVal(ch) = mean(head_deoxy(tpidx,ch)); txt='Hb';
%         end
%         MatVal(NIRx.settings.ExCh)=0;
%         figure
%         topoplot(MatVal, ElectrodeLocation,'maplimits',[-0.2 0.2]);
%         title(sprintf('%s - %s : t=%3.1f-%3.1f', D{1}.MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
%         colormap(erdcolormap)
%         caxis([-1 1.5]/Scale)
%
%         colorbar
%         set(gcf,'color','w')
%         set(gcf,'Position',[10 540 560 420])
%
%         set(gcf,'PaperPositionMode','auto')
%
%
%         if NIRx.settings.corrmode==0
%             print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
%             saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
%         elseif NIRx.settings.corrmode==7
%             print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
%             saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
%         else
%             print( '-djpeg', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
%             saveas(gcf, [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
%         end
%     end %for k = 1 : length(TimePointList)
%
%
