% Modified 24.02.2016 
% Bachmaier Dominik 
% Changes: Adapted to new version of NIRS setup including LSL recorder

function []= verlaufphysio(NIRx, SollAktivierung, SollAktivierung2, data, Task, ImageClass, BPfs, gUSBampfs)

%     % Flip ECG signal upside down
%     flipud_ECG = 1;
    
    t_bp = 1/BPfs:1/BPfs:length(NIRx.Data.BPdia)/BPfs;
    
    if NIRx.hdr.Bool.gUSBamp
        t_gusbamp = 1/gUSBampfs:1/gUSBampfs:length(NIRx.Data.Resp)/gUSBampfs;
    end
    
    font_size = 16;
    line_width = 2;
    
    h = figure;
    subplot(4,1,1)
    title('Physio Signals ','FontSize',12)
    h=plot(t_bp',NIRx.Data.BP,'k');
    set(h,'LineWidth',line_width);
    hold on
    h=plot(t_bp',NIRx.Data.BPdia,'b');
    set(h,'LineWidth',line_width);
    hold on
    h=plot(t_bp',NIRx.Data.BPsys,'r');
    set(h,'LineWidth',line_width);
    hold on
    xlabel('t(s)','FontSize',font_size)
    ylabel('(mm Hg)','FontSize',font_size)
    legend(' BP',' BPdia',' BPsys ')
    ax1=axis;
    axis([0 length(NIRx.Data.BP)/BPfs ax1(1,3) ax1(1,4)]);
    title('Blood pressure');
    grid on;
    set(gca,'FontSize',font_size);
%     plot(t_bp', SollAktivierung*ax1(4),'g');

             
    if NIRx.hdr.Bool.gUSBamp
        subplot(4,1,2)
        h=plot(t_gusbamp',NIRx.Data.Resp,'k');
        set(h,'LineWidth',line_width);
        hold on
        xlabel('t(s)','FontSize',font_size)
        ylabel('(a.u)','FontSize',font_size)
%         legend('[Resp]')
        ax1=axis;
        axis([0 length(NIRx.Data.Resp)/gUSBampfs ax1(1,3) ax1(1,4)]);
        grid on;
        set(gca,'FontSize',font_size);
        title('Respiration');
%         plot(t_gusbamp', SollAktivierung2*ax1(4),'g')

        subplot(4,1,3)
        h=plot(t_gusbamp',NIRx.Data.HR,'k');
        set(h,'LineWidth',line_width);
        hold on
        xlabel('t(s)','FontSize',font_size)
        ylabel('(bpm)','FontSize',font_size)
%         legend('[HR]')
        ax1=axis;
        axis([0 length(NIRx.Data.HR)/gUSBampfs ax1(1,3) ax1(1,4)]);
        title('Heart rate');
        grid on;
        set(gca,'FontSize',font_size);
%         plot(t_gusbamp', SollAktivierung2*ax1(4),'g');
        
        subplot(4,1,4)
        h=plot(t_gusbamp',NIRx.Data.ecg,'k');
        set(h,'LineWidth',line_width);
        hold on
        xlabel('t(s)','FontSize',font_size)
        ylabel('(a.u.)','FontSize',font_size)
%         legend('[ECG]')
        ax1=axis;
        axis([0 length(NIRx.Data.ecg)/gUSBampfs ax1(1,3) ax1(1,4)]);
        grid on;
        set(gca,'FontSize',font_size);
        title('ECG');
%         plot(t_gusbamp', SollAktivierung2*ax1(4),'g')
    end

%     gcf;
%     orient landscape;

%     print( '-dpng', '-r300', [evaluationPath filesep Task,'_',ImageClass,'_Physio_Signals']);
    
    saveas(h, [data.analysisPath filesep data.analysisFilename '_Physio_Signals'],'fig');
%     saveas(h, [evaluationPath, filesep Task,'_',ImageClass,'_Physio_Signals'],'png');
    
end