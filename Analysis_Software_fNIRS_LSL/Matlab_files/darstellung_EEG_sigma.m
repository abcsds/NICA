function darstellung_EEG_sigma(c,EEG,fs)
%  (c)G�nther Bauernfeind

% This file (darstellung_etg_sigma) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.




      if c==1
          subplot(7,8,4);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==2
          subplot(7,8,5);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==3
          subplot(7,8,20);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==4
          subplot(7,8,21);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==5
          subplot(7,8,25);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==6
          subplot(7,8,32);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==7
          subplot(7,8,36);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==8
          subplot(7,8,37);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==9
          subplot(7,8,41);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==10
          subplot(7,8,42);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==11
          subplot(7,8,48);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==12
          subplot(7,8,47);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==13
          subplot(7,8,51);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==14
          subplot(7,8,52);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==15
          subplot(7,8,54);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==16
          subplot(7,8,53);set(gca,'ytick',[]); set(gca,'xtick',[]); end

   
      
  t=1/fs:1/fs:size(EEG)/fs;

      
        h=plot(t',EEG,'b');
        set(h,'LineWidth',2);
        
        ax=axis;
        ax=([ax(1,1) ax(1,2) -5 5]);
        axis(ax);
           
        title(['Ch ' num2str(c)],'FontSize',6,'FontWeight', 'bold')
        
      


        
        
        
end


        
        
        
              
                    
                    
                    
                    
                    
        
        
        