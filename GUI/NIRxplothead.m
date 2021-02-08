
% Dominik:

Scale = 15;
cmin = settings.rangeMin;
cmax = settings.rangeMax;

%Scale=25; % 0.075 : -0.05
%Scale=15; % 0.1 : -0.075
% Scale=10; % 0.15 : -0.1
% Scale=7.5; % 0.2 : -0.15
%  Scale=5; % 0.3 : -0.2
% Scale=0.1;

plotrad = 0.5; % default-value
headrad = 0.5; % default-value

%%%%%
switch settings.signal.value % averaged over trials (1) or continuous (2)
    case 1
        Timing = [-settings.timing.pre (settings.timing.signal+settings.timing.post)];
        %TimePointList={[-3 0];[6 9];[10 13]; [13 16]}; %original
        % TimePointList={[-5 0];[0 5];[5 10];[10 15];[15 19]};

        % timingSteps = round(Timing(2)/4);
        timingSteps = round(Timing(2)/(settings.nrTopoplots - 1));
        
%         TimePointList = cell(5,1);        
%         TimePointList{1} = [Timing(1) 0];
%         TimePointList{2} = [0 timingSteps];
%         TimePointList{3} = [timingSteps timingSteps*2];
%         TimePointList{4} = [timingSteps*2 timingSteps*3];
%         TimePointList{5} = [timingSteps*3 Timing(2)];

        TimePointList = cell(settings.nrTopoplots,1);
        for i = 1:length(TimePointList)
            if i == 1
                TimePointList{i} = [Timing(1) 0];
            elseif i == length(TimePointList)
                TimePointList{i} = [timingSteps*(i-2) Timing(2)];
            else
                TimePointList{i} = [timingSteps*(i-2) timingSteps*(i-1)];
            end
        end
       
        T = (Timing(1):1/fs:Timing(2));
    case 2
        T = 1:size(head_oxy,1);
        
        timingSteps = round(T(end)/5); 
        TimePointList = cell(5,1);

        TimePointList{1} = [1 timingSteps];
        TimePointList{2} = [timingSteps+1 timingSteps*2];
        TimePointList{3} = [timingSteps*2+1 timingSteps*3];
        TimePointList{4} = [timingSteps*3+1 timingSteps*4];
        TimePointList{5} = [timingSteps*4+1 timingSteps*5];
end


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
    plotrad = 0.31;
    headrad = 0.31;
else
    error('channel number not supported')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load erdcolormapinverted2;
% plotrad = 0.5;
% headrad = 0.5;
% MatVal=zeros(61, 1);
% figure;
% 
% subplot(2,3,1); title('12 Channels'); set(gca, 'FontSize',16);
% ElectrodeLocation = 'NIRx12.loc';
% topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %normal
% colormap(erdcolormapinverted);
% 
% subplot(2,3,2); title('24 Channels (Laboratory new)'); set(gca, 'FontSize',16);
% ElectrodeLocation = 'NIRx99.loc';
% topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %normal
% 
% % subplot(2,3,3); title('38 Channels');
% % ElectrodeLocation = 'NIRxMATred.loc';
% % topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %normal
% 
% 
% subplot(2,3,3); title('42 Channels (NIRx Sports old)'); set(gca, 'FontSize',16);
% ElectrodeLocation = 'NIRxsport.loc';
% plotrad = 0.4;
% headrad = 0.4;
% topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %normal
% 
% subplot(2,3,4); title('47 Channels'); set(gca, 'FontSize',16);
% ElectrodeLocation = 'NIRx47.loc';
% plotrad = 0.5;
% headrad = 0.5;
% topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %normal
% 
% subplot(2,3,5); title('50 Channels'); set(gca, 'FontSize',16);
% ElectrodeLocation = 'NIRx50b.loc';
% topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %normal
% 
% % subplot(2,3,6); title('24 Channels (lab new)');
% % ElectrodeLocation = 'NIRx99.loc';
% % topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2
% % 0.2],'plotrad',plotrad,'headrad',headrad); %normal
% 
% subplot(2,3,6); title('61 Channels (NIRx Sports new)'); set(gca, 'FontSize',16);
% ElectrodeLocation = 'NIRxsport_neu.loc';
% plotrad = 0.35;
% headrad = 0.35;
% topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %normal



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% load erdcolormapinverted;
load erdcolormapinverted2;
% load erdcolormap;
% colormapInverted = zeros(size(erdcolormap));
% for i = 1:size(erdcolormap,1)
%     colormapInverted(i,1) = erdcolormap(size(erdcolormap,1)+1-i,1);
%     colormapInverted(i,2) = erdcolormap(size(erdcolormap,1)+1-i,2);
%     colormapInverted(i,3) = erdcolormap(size(erdcolormap,1)+1-i,3);
% end

% switch settings.signal.value
%     case 1
%         % Timing=NIRx.settings.Timing;
%         T = (Timing(1):1/fs:Timing(2)); % Time vector
%     case 2
%         T = 1:size(head_oxy,1);
% end
% Check if Time vector fits
if length(T) > size(head_oxy,1)
    T = T(1:size(head_oxy,1));
end

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
        
        % hier berechnet er f?r jeden Channel f?r die Zeit, die betrachtet
        % wird, den Mittelwert f?r HbO
        for ch=1:size(head_oxy,2)
            MatVal(ch)=mean(head_oxy(tpidx,ch)); 
            txt='[oxy-Hb]';
        end
        
        MatVal(NIRx.settings.ExCh)=0;
        hTopo1 = figure;
        topoplot(MatVal, ElectrodeLocation);%normal
        title(sprintf('%s - %s: t=%1.0f-%1.0f', D{1}.MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
        colormap(erdcolormapinverted)
        caxis([cmin cmax])
%         caxis([-1 1.5]/Scale)

        if status.grandAverage
            saveas(hTopo1, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2))],'fig');
        else
            if settings.correctionMode.value == 1
    %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
                saveas(hTopo1, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
            elseif settings.correctionMode.value == 8
    %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
                saveas(hTopo1, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
            else
    %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
                saveas(hTopo1, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
            end
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
            MatVal(ch) = mean(head_deoxy(tpidx,ch)); txt='[deoxy-Hb]';
        end
        MatVal(NIRx.settings.ExCh)=0;
        
        hTopo2 = figure;
        topoplot(MatVal, ElectrodeLocation); %,'maplimits',[-0.2 0.2]);
        title(sprintf('%s - %s: t=%1.0f-%1.0f', txt, TimePoint(1), TimePoint(2)),'interpreter','none') %D{1}.MeasurementID,
        colormap(erdcolormapinverted)
        caxis([cmin cmax])
%         caxis([-1 1.5]/Scale)
        
        if status.grandAverage
            saveas(hTopo2, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2))],'fig');
        else
            if settings.correctionMode.value == 1
    %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
                saveas(hTopo2, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
            elseif settings.correctionMode.value == 8
    %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
                saveas(hTopo2, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
            else
    %             print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
                saveas(hTopo2, [data.analysisPath filesep data.analysisFilename '_Topoplot_',txt,'_t=',num2str(TimePoint(1)),'-',num2str(TimePoint(2)),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
            end
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
        
        % hier berechnet er f?r jeden Channel f?r die Zeit, die betrachtet
        % wird, den Mittelwert f?r HbO
        for ch=1:size(head_oxy,2)
            MatVal(ch)=mean(head_oxy(tpidx,ch)); txt='[oxy-Hb]';
        end
        
        MatVal(find(settings.channels.exclude == 1))=0;
%         MatVal = MatVal*(-1);
        subplot(2,length(TimePointList),k)
        topoplot(MatVal, ElectrodeLocation, 'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %,'maplimits',[-0.2 0.2]);%normal
        title(sprintf('t (s) = %1.0f-%1.0f', TimePoint(1), TimePoint(2)),'interpreter','none')
        colormap(erdcolormapinverted)
%         colorbar
        caxis([cmin cmax])
%         caxis([-1 1.5]/Scale)
        font_size = 16;
        set(gca,'FontSize',font_size);
        
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

    set(hfig,'color','w')
    set(hfig,'Position',[10 540 560 420])
    
    set(hfig,'PaperPositionMode','auto')
    
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
            MatVal(ch) = mean(head_deoxy(tpidx,ch)); txt='[deoxy-Hb]';
        end
        MatVal(find(settings.channels.exclude == 1))=0;
%         MatVal = MatVal*(-1);
        subplot(2,length(TimePointList),k+length(TimePointList))
        topoplot(MatVal, ElectrodeLocation,'maplimits',[-0.2 0.2],'plotrad',plotrad,'headrad',headrad); %,'maplimits',[-0.2 0.2]);
        %title(sprintf('%s - %s: t=%1.0f-%1.0f', D{1}.MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
        colormap(erdcolormapinverted)
        caxis([cmin cmax])
        
        font_size = 16;
        set(gca,'FontSize',font_size);
%         caxis([-1 1.5]/Scale)
        
        %     colorbar
        %     set(gcf,'color','w')
        %     set(gcf,'Position',[10 540 560 420])
        %
        %     set(gcf,'PaperPositionMode','auto')
        %
        
        
    end %for k = 1 : length(TimePointList)
    colorbar('position', [0.91, 0.36, 0.015, 0.35])
    axes('position',[0,0,1,1],'visible','off');
    font_size = 16;
        set(gca,'FontSize',font_size);
    text(0.02,0.94,'[oxy-Hb] (mM*mm)', 'FontSize', 22)
    text(0.02,0.47,'[deoxy-Hb] (mM*mm)', 'FontSize', 22)
    
    if status.grandAverage
            saveas(hfig, [data.analysisPath filesep data.analysisFilename '_Topoplot'],'fig');
    else
        if settings.correctionMode.value == 1
    %         print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(hfig, [data.analysisPath filesep data.analysisFilename '_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        elseif settings.correctionMode.value == 8
    %         print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(hfig, [data.analysisPath filesep data.analysisFilename '_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        else
    %         print( '-dpng', '-r300', [DataPath, Group, '\', AnalysePath, '\',NIRx.settings.Subj,'_',ImageClass,'_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
            saveas(hfig, [data.analysisPath filesep data.analysisFilename '_Topoplot',NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
        end
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
