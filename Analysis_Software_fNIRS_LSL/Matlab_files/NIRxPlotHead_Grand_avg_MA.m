% Modified 04.03.2016
% Bachmaier Dominik
% Changes: Adapted to new version of NIRS setup including LSL recorder

Scale=25; % 0.075 : -0.05
% Scale=15; % 0.1 : -0.075
% Scale=10; % 0.15 : -0.1
% Scale=7.5; % 0.2 : -0.15
% Scale=5; % 0.3 : -0.2
% Scale=0.1;

%%%%%%
%TimePointList={[-3 0];[6 9];[10 13]; [13 16]}; %original
% TimePointList={[-2.5 0];[0 2.5];[2.5 5]; [5 7.5]};
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
        MatVal(ch) =mean(head_oxy(tpidx,ch)); txt='HbO';
        
    end
    MatVal(NIRx.settings.ExCh)=0;
    figure
    topoplot(MatVal, ElectrodeLocation,'maplimits',[-0.2 0.2]);%normal
    title(sprintf('%s - %s : t=%3.1f-%3.1f', MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
    colormap(erdcolormap)
    caxis([-1 1.5]/Scale)
    
    colorbar
    set(gcf,'color','w')
    set(gcf,'Position',[10 540 560 420])
    
    set(gcf,'PaperPositionMode','auto')
    
    
    
    if strcmp(Session, 'Single')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
        end
    elseif strcmp(Session, 'Grand')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
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
        MatVal(ch) = mean(head_deoxy(tpidx,ch)); txt='Hb';
    end
    MatVal(NIRx.settings.ExCh)=0;
    figure
    topoplot(MatVal, ElectrodeLocation,'maplimits',[-0.2 0.2]);
    title(sprintf('%s - %s : t=%3.1f-%3.1f', MeasurementID, txt, TimePoint(1), TimePoint(2)),'interpreter','none')
    colormap(erdcolormap)
    caxis([-1 1.5]/Scale)
    
    colorbar
    set(gcf,'color','w')
    set(gcf,'Position',[10 540 560 420])
    
    set(gcf,'PaperPositionMode','auto')
    
    
    if strcmp(Session, 'Single')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\uncorr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\uncorr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\add_car\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', G.FileName{1},'\mayer_resp_corr\',G.FileName{1},'_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
        end
    elseif strcmp(Session, 'Grand')
        if strcmp(Type, 'uncorr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\uncorr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\uncorr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
        elseif strcmp(Type, 'mayer_resp_corr')
            if Add_CAR
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\add_car\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            else
                print( '-dpng', '-r300', [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)]);
                saveas(gcf, [DataPath, '\Analyse\', 'Grand','\mayer_resp_corr\','Grand','_',modality,'_Topoplot_',txt,'_window_',num2str(k)],'fig');
            end
        end
    end
end %for k = 1 : length(TimePointList)


