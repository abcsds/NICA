function darstellung_EEG_sigma_2(c,EEG,SD,fs)
%  (c)G�nther Bauernfeind

% This file (darstellung_etg_sigma) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.




      if c==1
          subplot(8,11,5);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==2
          subplot(8,11,7);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==3
          subplot(8,11,17);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==4
          subplot(8,11,24);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==5
          subplot(8,11,26);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==6
          subplot(8,11,28);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==7
          subplot(8,11,30);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==8
          subplot(8,11,32);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==9
          subplot(8,11,34);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==10
          subplot(8,11,36);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==11
          subplot(8,11,38);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==12
          subplot(8,11,40);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==13
          subplot(8,11,42);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==14
          subplot(8,11,44);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==15
          subplot(8,11,46);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==16
          subplot(8,11,48);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      
      %USB-amp2
      if c==17
          subplot(8,11,50);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==18
          subplot(8,11,52);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==19
          subplot(8,11,54);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==20
          subplot(8,11,56);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==21
          subplot(8,11,58);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==22
          subplot(8,11,60);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==23
          subplot(8,11,62);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==24
          subplot(8,11,64);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==25
          subplot(8,11,66);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==26
          subplot(8,11,68);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==27
          subplot(8,11,70);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==28
          subplot(8,11,72);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==29
          subplot(8,11,74);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==30
          subplot(8,11,76);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==31
          subplot(8,11,82);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==32
          subplot(8,11,84);set(gca,'ytick',[]); set(gca,'xtick',[]); end

   
      
  t=1/fs:1/fs:size(EEG)/fs;

      
        h=plot(t',EEG,'b');
        set(h,'LineWidth',2);
        hold on
%          h=plot(t',EEG-SD,'b--');
%         set(h,'LineWidth',1);
%          h=plot(t',EEG+SD,'b--');
%         set(h,'LineWidth',1);
%         
        ax=axis;
        ax=([ax(1,1) ax(1,2) -1 1]);
        axis(ax);
           
        title(['Ch ' num2str(c)],'FontSize',6,'FontWeight', 'bold')
        
      


        
        
        
end


        
        
        
              
                    
                    
                    
                    
                    
        
        
        