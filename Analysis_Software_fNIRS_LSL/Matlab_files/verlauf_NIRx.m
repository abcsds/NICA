% Modified 24.02.2016
% Bachmaier Dominik
% Changes: Adapted to new version of NIRS setup including LSL recorder

function []= verlauf_NIRx(oxy_signal, deoxy_signal, NIRx, t, SollActivierung, fs, c, Gruppe, DataPath, AnalysePath, Task,ImageClass)


kanal=NIRx.settings.kanal;
DisplaySteps=NIRx.settings.DisplaySteps;

if DisplaySteps
    % only plotted if the channel is equal to the current iteration in
    % outer for-loop
    if (c==kanal || kanal == 0) && NIRx.settings.createFigures
        %
        figure(400+c)
        
        h=plot(t',oxy_signal,'r');
        set(h,'LineWidth',1);
        hold on
        h=plot(t',deoxy_signal,'b');
        set(h,'LineWidth',1);
        hold on     
        
        title(['Concentration Change Channel ' num2str(c)],'FontSize',12)
            
        xlabel('t(s)','FontSize',12)
        ylabel('(mM mm)','FontSize',12)
        legend('[oxy-Hb]','[deoxy-Hb]')
        ax1=axis;
        axis([0 length(oxy_signal)/fs ax1(1,3) ax1(1,4)]);
        plot(t', SollActivierung*ax1(4),'g')
        %                 plot(t', SollActivierung*ax1(3),'g')
        
        % print( '-dpng', '-r300', ['C:\Users\Hiebel Hannah\Desktop\NeuroLab/','Gruppe', '_',Gruppe,'Konzentrationsänderung', '_','Kanal',num2str(c),'(FP1)']);
        % saveas(gcf, ['C:\Users\Hiebel Hannah\Desktop\NeuroLab/','Gruppe', '_',Gruppe,'Konzentrationsänderung', '_','Kanal',num2str(c),'(FP1)'],'fig');
        % print( '-dpng', '-r300', ['C:\Documents and Settings\bauernfeind\Desktop\Bakk_Student/','AF', '_',Gruppe,'_Konzentrationsänderung', '_','Kanal',num2str(c),'(FP1)']);
        % saveas(gcf, ['C:\Documents and Settings\bauernfeind\Desktop\Bakk_Student/','AF', '_',Gruppe,'_Konzentrationsänderung', '_','Kanal',num2str(c),'(FP1)'],'fig');
        gcf;
        orient landscape;
        if NIRx.settings.corrmode==0
            print( '-dpng', '-r300', [DataPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Konzentrationsänderung', '_','Kanal',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Konzentrationsänderung', '_','Kanal',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
        else
            print( '-dpng', '-r300', [DataPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Konzentrationsänderung', '_','Kanal',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
            saveas(gcf, [DataPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_Konzentrationsänderung', '_','Kanal',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
        end
        
        %                     %spektrum
        %
        %
        %                     maxf=1.5;
        %                     figure(198)
        %                     rHR=calcNIRSspectra(oxy_signal,fs);
        %                     freqHR=rHR{1}.f;
        %                     pHR=rHR{1}.p;
        %                     indHR=find(freqHR<=maxf);
        %
        %                     h=semilogy(freqHR(indHR),pHR(indHR),'r');
        %                     set(h,'LineWidth',2);
        %                     hold on
        %
        %                     rHR=calcNIRSspectra(deoxy_signal,fs);
        %                     freqHR=rHR{1}.f;
        %                     pHR=rHR{1}.p;
        %                     indHR=find(freqHR<=maxf);
        %                     h=semilogy(freqHR(indHR),pHR(indHR),'b');
        %                     set(h,'LineWidth',2);
        %
        %                     title(['Spektrum Kanal ' num2str(c)],'FontSize',12)
        %                     ylabel('Spektrum','FontSize',12)
        %                     legend('[oxy-Hb]','[deoxy-Hb]')
        %                     xlabel('f (Hz)','FontSize',12,'FontWeight','bold')
        %                     grid on;
        
        % print( '-dpng', '-r300', ['C:\Users\Hiebel Hannah\Desktop\NeuroLab/','Gruppe', '_',Gruppe,'Spektrum', '_','Kanal',num2str(c),'(FP1)']);
        % saveas(gcf, ['C:\Users\Hiebel Hannah\Desktop\NeuroLab/','Gruppe', '_',Gruppe,'Spektrum', '_','Kanal',num2str(c),'(FP1)'],'fig');
        % print( '-dpng', '-r300', ['C:\Documents and Settings\bauernfeind\Desktop\Bakk_Student/','AF', '_',Gruppe,'_Spektrum', '_','Kanal',num2str(c),'(FP1)']);
        % saveas(gcf, ['C:\Documents and Settings\bauernfeind\Desktop\Bakk_Student/','AF', '_',Gruppe,'_Spektrum', '_','Kanal',num2str(c),'(FP1)'],'fig');
    end 
end
end