% Modified 24.02.2016 
% Bachmaier Dominik 
% Changes: Adapted to new version of NIRS setup including LSL recorder

function []= verlauf_physio(NIRx, SollAktivierung, SollAktivierung2, Gruppe, DatenPath, AnalysePath, Task, ImageClass, BPfs, gUSBampfs)

    t_bp = 1/BPfs:1/BPfs:length(NIRx.Data.BPdia)/BPfs;
    
    if NIRx.hdr.Bool.gUSBamp
        t_gusbamp = 1/gUSBampfs:1/gUSBampfs:length(NIRx.Data.Resp)/gUSBampfs;
    end
    
    figure(1)
    subplot(4,1,1)
    title(['Physio Signals ', Gruppe],'FontSize',12)
    h=plot(t_bp',NIRx.Data.BP,'k');
    set(h,'LineWidth',1);
    hold on
    h=plot(t_bp',NIRx.Data.BPdia,'b');
    set(h,'LineWidth',1);
    hold on
    h=plot(t_bp',NIRx.Data.BPsys,'r');
    set(h,'LineWidth',1);
    hold on
    xlabel('t(s)','FontSize',12)
    ylabel('(mm Hg)','FontSize',12)
    legend('[BP]','[BPdia]','[BPsys]')
    ax1=axis;
    axis([0 length(NIRx.Data.BP)/BPfs ax1(1,3) ax1(1,4)]);
    plot(t_bp', SollAktivierung*ax1(4),'g');
             
    if NIRx.hdr.Bool.gUSBamp
        subplot(4,1,2)
        h=plot(t_gusbamp',NIRx.Data.Resp,'k');
        set(h,'LineWidth',1);
        hold on
        xlabel('t(s)','FontSize',12)
        ylabel('(a.u)','FontSize',12)
        legend('[Resp]')
        ax1=axis;
        axis([0 length(NIRx.Data.Resp)/gUSBampfs ax1(1,3) ax1(1,4)]);
        plot(t_gusbamp', SollAktivierung2*ax1(4),'g')

        subplot(4,1,3)
        h=plot(t_gusbamp',NIRx.Data.HR,'k');
        set(h,'LineWidth',1);
        hold on
        xlabel('t(s)','FontSize',12)
        ylabel('(bpm)','FontSize',12)
        legend('[HR]')
        ax1=axis;
        axis([0 length(NIRx.Data.HR)/gUSBampfs ax1(1,3) ax1(1,4)]);
        plot(t_gusbamp', SollAktivierung2*ax1(4),'g')

        subplot(4,1,4)
        h=plot(t_gusbamp',NIRx.Data.ecg,'k');
        set(h,'LineWidth',1);
        hold on
        xlabel('t(s)','FontSize',12)
        ylabel('(a.u.)','FontSize',12)
        legend('[ECG]')
        ax1=axis;
        axis([0 length(NIRx.Data.ecg)/gUSBampfs ax1(1,3) ax1(1,4)]);
        plot(t_gusbamp', SollAktivierung2*ax1(4),'g')
    end

    gcf;
    orient landscape;

    print( '-dpng', '-r300', [DatenPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Physio_Signals']);
    saveas(gcf, [DatenPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Physio_Signals'],'fig');
end