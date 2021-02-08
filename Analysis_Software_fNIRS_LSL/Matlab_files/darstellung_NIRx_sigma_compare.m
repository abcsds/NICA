function darstellung_NIRx_sigma_compare(c,oxy_signal,deoxy_signal,std_oxy_signal,std_deoxy_signal, NIRx,t_trial,fs, Type)
%  (c)Gï¿½nther Bauernfeind

% This file (darstellung_etg_sigma) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.

Timing=NIRx.settings.Timing;
Anfang=NIRx.settings.Anfang;
Ende=NIRx.settings.Ende;
kanal=NIRx.settings.kanal;
probeset=NIRx.settings.probeset;
STD=NIRx.settings.STD;
DisplaySteps=NIRx.settings.DisplaySteps;
ExCh=NIRx.settings.ExCh;

if probeset==50 %NIRx
      
      if c==1
          subplot(12,21,10);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==2
          subplot(12,21,30);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==3
          subplot(12,21,12);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==4
          subplot(12,21,34);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==5
          subplot(12,21,32);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==6
          subplot(12,21,54);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==7
          subplot(12,21,52);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==8
          subplot(12,21,74);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==9
          subplot(12,21,72);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==10
          subplot(12,21,94);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==11
          subplot(12,21,76);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==12
          subplot(12,21,96);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==13
          subplot(12,21,144);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==14
          subplot(12,21,142);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==15
          subplot(12,21,164);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==16
          subplot(12,21,140);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==17
          subplot(12,21,138);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==18
          subplot(12,21,160);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==19
          subplot(12,21,136);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==20
          subplot(12,21,134);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==21
          subplot(12,21,156);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==22
          subplot(12,21,132);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==23
          subplot(12,21,130);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==24
          subplot(12,21,152);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==25
          subplot(12,21,162);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==26
          subplot(12,21,184);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==27
          subplot(12,21,182);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==28
          subplot(12,21,204);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==29
          subplot(12,21,158);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==30
          subplot(12,21,180);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==31
          subplot(12,21,178);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==32
          subplot(12,21,200);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==33
          subplot(12,21,154);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==34
          subplot(12,21,176);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==35
          subplot(12,21,174);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==36
          subplot(12,21,196);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==37
          subplot(12,21,206);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==38
          subplot(12,21,228);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==39
          subplot(12,21,226);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==40
          subplot(12,21,202);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==41
          subplot(12,21,224);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==42
          subplot(12,21,222);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==43
          subplot(12,21,244);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==44
          subplot(12,21,198);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==45
          subplot(12,21,220);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==46
          subplot(12,21,218);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==47
          subplot(12,21,240);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==48
          subplot(12,21,194);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==49
          subplot(12,21,216);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==50
          subplot(12,21,214);set(gca,'ytick',[]); set(gca,'xtick',[]); end

end
      
if probeset==12 %NIRx
      
      if c==12
          subplot(5,5,2);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==11
          subplot(5,5,6);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==10
          subplot(5,5,4);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==9
          subplot(5,5,10);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==8
          subplot(5,5,8);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==7
          subplot(5,5,14);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==6
          subplot(5,5,12);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==5
          subplot(5,5,18);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==4
          subplot(5,5,16);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==3
          subplot(5,5,22);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==2
          subplot(5,5,20);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      if c==1
          subplot(5,5,24);set(gca,'ytick',[]); set(gca,'xtick',[]); end
end

if probeset==38 %NIRx
      if NIRx.settings.PhysInk==1
          ChNr=c;
          
          for i=1:1:size(ExCh,2)
            if ChNr==ExCh(i)
                rOxy =[];
                rDeoxy=[];
                return
            end
          end
                    if ChNr==2
                        g5=axes('position',[0.41667 0.76667 0.07576 0.125]);axes(g5);end
                    if ChNr==5
                        g6=axes('position',[0.50758 0.76667 0.07576 0.125]);axes(g6);end
                    
                    
                    %second row
                    
                    if ChNr==4
                        g15=axes('position',[0.37121 0.60000 0.07576 0.125]);axes(g15);end
                    if ChNr==16
                        g16=axes('position',[0.46212 0.60000 0.07576 0.125]);axes(g16);end
                    if ChNr==8
                        g17=axes('position',[0.55303 0.60000 0.07576 0.125]);axes(g17);end
                    
                    
                    %third row
                    
                    if ChNr==9
                        g23=axes('position',[0.14394 0.43334 0.07576 0.125]);axes(g23);end
                    if ChNr==10
                        g24=axes('position',[0.23485 0.43334 0.07576 0.125]);axes(g24);end
                    if ChNr==13
                        g25=axes('position',[0.32576 0.43334 0.07576 0.125]);axes(g25);end
                    if ChNr==18
                        g26=axes('position',[0.41667 0.43334 0.07576 0.125]);axes(g26);end
                    if ChNr==21
                        g27=axes('position',[0.50758 0.43334 0.07576 0.125]);axes(g27);end
                    if ChNr==24
                        g28=axes('position',[0.59848 0.43334 0.07576 0.125]);axes(g28);end
                    
                    
                    %fourth row
                    
                    if ChNr==25
                        g34=axes('position',[0.18939 0.26667 0.07576 0.125]);axes(g34);end
                    if ChNr==15
                        g35=axes('position',[0.28030 0.26667 0.07576 0.125]);axes(g35);end
                    if ChNr==29
                        g36=axes('position',[0.37121 0.26667 0.07576 0.125]);axes(g36);end
                    if ChNr==23
                        g37=axes('position',[0.46212 0.26667 0.07576 0.125]);axes(g37);end
                    if ChNr==36
                        g38=axes('position',[0.55303 0.26667 0.07576 0.125]);axes(g38);end
                    
                    
                    %fifth row
                    
                    if ChNr==28
                        g45=axes('position',[0.23485 0.10000 0.07576 0.125]);axes(g45);end
                    if ChNr==31
                        g46=axes('position',[0.32576 0.10000 0.07576 0.125]);axes(g46);end
                    if ChNr==34
                        g47=axes('position',[0.41667 0.10000 0.07576 0.125]);axes(g47);end
                    if ChNr==38
                        g48=axes('position',[0.50758 0.10000 0.07576 0.125]);axes(g48);end
      else
          if c==1
              subplot(7,17,10);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==2
              subplot(7,17,11);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==3
              subplot(7,17,26);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==4
              subplot(7,17,43);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==5
              subplot(7,17,13);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==6
              subplot(7,17,14);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==7
              subplot(7,17,32);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==8
              subplot(7,17,49);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==9
              subplot(7,17,53);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==10
              subplot(7,17,55);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==11
              subplot(7,17,56);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==12
              subplot(7,17,58);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==13
              subplot(7,17,59);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==14
              subplot(7,17,74);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==15
              subplot(7,17,91);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==16
              subplot(7,17,29);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==17
              subplot(7,17,46);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==18
              subplot(7,17,61);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==19
              subplot(7,17,62);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==20
              subplot(7,17,64);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==21
              subplot(7,17,65);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==22
              subplot(7,17,80);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==23
              subplot(7,17,97);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==24
              subplot(7,17,67);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==25
              subplot(7,17,71);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==26
              subplot(7,17,88);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==27
              subplot(7,17,106);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==28
              subplot(7,17,107);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==29
              subplot(7,17,77);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==30
              subplot(7,17,94);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==31
              subplot(7,17,109);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==32
              subplot(7,17,110);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==33
              subplot(7,17,112);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==34
              subplot(7,17,113);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==35
              subplot(7,17,83);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==36
              subplot(7,17,100);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==37
              subplot(7,17,115);set(gca,'ytick',[]); set(gca,'xtick',[]); end
          if c==38
              subplot(7,17,116);set(gca,'ytick',[]); set(gca,'xtick',[]); end
      end
      
     
end

if probeset==24 %NIRx
      
      if c==1
          subplot(4,10,4);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==2
          subplot(4,10,5);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==3
          subplot(4,10,13);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==4
          subplot(4,10,23);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==5
          subplot(4,10,7);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==6
          subplot(4,10,8);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==7
          subplot(4,10,19);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==8
          subplot(4,10,29);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==12
          subplot(4,10,31);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==13
          subplot(4,10,32);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==16
          subplot(4,10,16);set(gca,'ytick',[]); set(gca,'xtick',[]);
      elseif c==17
          subplot(4,10,26);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==18
          subplot(4,10,34);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==19
          subplot(4,10,35);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==20
          subplot(4,10,37);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==21
          subplot(4,10,38);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      elseif c==24
          subplot(4,10,40);set(gca,'ytick',[]); set(gca,'xtick',[]); 
      else
          return
      end

end      
          if probeset==47
                    %erste Zeile
%                     if c==52
%                         %set(gca,'Visible','off')
%                         g52=axes('position',[0.05300 0.76667 0.07576 0.125]);axes(g52);
%                     elseif c==51
%                         g51=axes('position',[0.14394 0.76667 0.07576 0.125]);axes(g51);
                    if c==46
                        g50=axes('position',[0.23485 0.76667 0.07576 0.125]);axes(g50);
                    elseif c==44
                        g49=axes('position',[0.32576 0.76667 0.07576 0.125]);axes(g49);
                    elseif c==43
                        g48=axes('position',[0.41667 0.76667 0.07576 0.125]);axes(g48);
                    elseif c==41
                        g47=axes('position',[0.50758 0.76667 0.07576 0.125]);axes(g47);
                    elseif c==40
                        g46=axes('position',[0.59848 0.76667 0.07576 0.125]);axes(g46);
                    elseif c==38
                        g45=axes('position',[0.68939 0.76667 0.07576 0.125]);axes(g45);
                    elseif c==37
                        g44=axes('position',[0.78030 0.76667 0.07576 0.125]);axes(g44);
%                     elseif c==43
%                         g43=axes('position',[0.87121 0.76667 0.07576 0.125]);axes(g43);
                    %zweite Zeile
                    elseif c==47
                        g42=axes('position',[0.00758 0.60000 0.07576 0.125]);axes(g42);
%                     elseif c==41
%                         g41=axes('position',[0.09848 0.60000 0.07576 0.125]);axes(g41);
                    elseif c==45
                        g40=axes('position',[0.18939 0.60000 0.07576 0.125]);axes(g40);
                    elseif c==32
                        g39=axes('position',[0.28030 0.60000 0.07576 0.125]);axes(g39);
                    elseif c==42
                        g38=axes('position',[0.37121 0.60000 0.07576 0.125]);axes(g38);
                    elseif c==28
                        g37=axes('position',[0.46212 0.60000 0.07576 0.125]);axes(g37);
                    elseif c==39
                        g36=axes('position',[0.55303 0.60000 0.07576 0.125]);axes(g36);
                    elseif c==24
                        g35=axes('position',[0.64394 0.60000 0.07576 0.125]);axes(g35);
                    elseif c==36
                        g34=axes('position',[0.73485 0.60000 0.07576 0.125]);axes(g34);
                    elseif c==20
                        g33=axes('position',[0.82575 0.60000 0.07576 0.125]);axes(g33);
%                     elseif c==32
%                         g32=axes('position',[0.91667 0.60000 0.07576 0.125]);axes(g32);
                    %dritte Zeile
                    elseif c==35
                        g31=axes('position',[0.05300 0.43334 0.07576 0.125]);axes(g31);
                    elseif c==34
                        g30=axes('position',[0.14394 0.43334 0.07576 0.125]);axes(g30);
                    elseif c==31
                        g29=axes('position',[0.23485 0.43334 0.07576 0.125]);axes(g29);
                    elseif c==30
                        g28=axes('position',[0.32576 0.43334 0.07576 0.125]);axes(g28);
                    elseif c==27
                        g27=axes('position',[0.41667 0.43334 0.07576 0.125]);axes(g27);
                    elseif c==26
                        g26=axes('position',[0.50758 0.43334 0.07576 0.125]);axes(g26);
                    elseif c==23
                        g25=axes('position',[0.59848 0.43334 0.07576 0.125]);axes(g25);
                    elseif c==22
                        g24=axes('position',[0.68939 0.43334 0.07576 0.125]);axes(g24);
                    elseif c==19
                        g23=axes('position',[0.78030 0.43334 0.07576 0.125]);axes(g23);
                    elseif c==18
                        g22=axes('position',[0.87121 0.43334 0.07576 0.125]);axes(g22);
                    %vierte Zeile
                    elseif c==16
                        g21=axes('position',[0.00758 0.26667 0.07576 0.125]);axes(g21);
                    elseif c==33
                        g20=axes('position',[0.09848 0.26667 0.07576 0.125]);axes(g20);
                    elseif c==14
                        g19=axes('position',[0.18939 0.26667 0.07576 0.125]);axes(g19);
                    elseif c==29
                        g18=axes('position',[0.28030 0.26667 0.07576 0.125]);axes(g18);
                    elseif c==11
                        g17=axes('position',[0.37121 0.26667 0.07576 0.125]);axes(g17);
                    elseif c==25
                        g16=axes('position',[0.46212 0.26667 0.07576 0.125]);axes(g16);
                    elseif c==8
                        g15=axes('position',[0.55303 0.26667 0.07576 0.125]);axes(g15);
                    elseif c==21
                        g14=axes('position',[0.64394 0.26667 0.07576 0.125]);axes(g14);
                    elseif c==5
                        g13=axes('position',[0.73485 0.26667 0.07576 0.125]);axes(g13);
                    elseif c==17
                        g12=axes('position',[0.82575 0.26667 0.07576 0.125]);axes(g12);
                    elseif c==2
                        g11=axes('position',[0.91667 0.26667 0.07576 0.125]);axes(g11);
                    %fünfte Zeile
                    elseif c==15
                        g10=axes('position',[0.05300 0.10000 0.07576 0.125]);axes(g10);
                    elseif c==13
                        g9=axes('position',[0.14394 0.10000 0.07576 0.125]);axes(g9);
                    elseif c==12
                        g8=axes('position',[0.23485 0.10000 0.07576 0.125]);axes(g8);
                    elseif c==10
                        g7=axes('position',[0.32576 0.10000 0.07576 0.125]);axes(g7);
                    elseif c==9
                        g6=axes('position',[0.41667 0.10000 0.07576 0.125]);axes(g6);
                    elseif c==7
                        g5=axes('position',[0.50758 0.10000 0.07576 0.125]);axes(g5);
                    elseif c==6
                        g4=axes('position',[0.59848 0.10000 0.07576 0.125]);axes(g4);
                    elseif c==4
                        g3=axes('position',[0.68939 0.10000 0.07576 0.125]);axes(g3);
                    elseif c==3
                        g2=axes('position',[0.78030 0.10000 0.07576 0.125]);axes(g2);
                    elseif c==1
                        g1=axes('position',[0.87121 0.10000 0.07576 0.125]);axes(g1);
                    else
                        return
                    end
          end
      
          if probeset==99
                    if c==1
                    subplot(5,11,53); 
                    elseif c==2
                    subplot(5,11,51);
                    elseif c==3
                    subplot(5,11,41);  
                    elseif c==4
                    subplot(5,11,49);  
                    elseif c==5
                    subplot(5,11,47);  
                    elseif c==6
                    subplot(5,11,37);  
                    elseif c==7
                    subplot(5,11,43);  
                    elseif c==8
                    subplot(5,11,31);  
                    elseif c==9
                    subplot(5,11,21);  
                    elseif c==10
                    subplot(5,11,39);  
                    elseif c==11
                    subplot(5,11,29); 
                    elseif c==12
                    subplot(5,11,27);  
                    elseif c==13
                    subplot(5,11,17);  
                    elseif c==14
                    subplot(5,11,35);  
                    elseif c==15
                    subplot(5,11,25); 
                    elseif c==16
                    subplot(5,11,13); 
                    elseif c==17
                    subplot(5,11,11); 
                    elseif c==18
                    subplot(5,11,19); 
                    elseif c==19
                    subplot(5,11,9); 
                    elseif c==20
                    subplot(5,11,7); 
                    elseif c==21
                    subplot(5,11,15); 
                    elseif c==22
                    subplot(5,11,5); 
                    elseif c==23
                    subplot(5,11,3);
                    elseif c==24
                    subplot(5,11,1);
                   else
                        return
                   end
          end      
if probeset==777
    ChNr=c;
      if NIRx.settings.AFChnUse %mit AF
      else %ohne AF
         if ChNr==1
           subplot(5,17,84); 
         elseif ChNr==2
           subplot(5,17,68);
         elseif ChNr==3
           subplot(5,17,82);
         elseif ChNr==4
           subplot(5,17,80);
         elseif ChNr==5
           subplot(5,17,64);
         elseif ChNr==6
           subplot(5,17,78);
         elseif ChNr==7
           subplot(5,17,76);
         elseif ChNr==8
           subplot(5,17,60);
         elseif ChNr==9
           subplot(5,17,74);
         elseif ChNr==10
           subplot(5,17,72);
         elseif ChNr==11
           subplot(5,17,56);
         elseif ChNr==12
           subplot(5,17,70);
         elseif ChNr==13
           subplot(5,17,52);
         elseif ChNr==14
           subplot(5,17,66);
         elseif ChNr==15
           subplot(5,17,50);
         elseif ChNr==16
           subplot(5,17,48);
         elseif ChNr==17
           subplot(5,17,32);
         elseif ChNr==18
           subplot(5,17,62);
         elseif ChNr==19
           subplot(5,17,46);
         elseif ChNr==20
           subplot(5,17,44);
         elseif ChNr==21
           subplot(5,17,28);
         elseif ChNr==22
           subplot(5,17,58);
         elseif ChNr==23
           subplot(5,17,42);
         elseif ChNr==24
           subplot(5,17,40);
         elseif ChNr==25
           subplot(5,17,24);
         elseif ChNr==26
           subplot(5,17,54);
         elseif ChNr==27
           subplot(5,17,38);
         elseif ChNr==28
           subplot(5,17,36);
         elseif ChNr==29
           subplot(5,17,20);
         elseif ChNr==30
           subplot(5,17,34);
         elseif ChNr==31
           subplot(5,17,16);
         elseif ChNr==32
           subplot(5,17,30);
         elseif ChNr==33
           subplot(5,17,14);
         elseif ChNr==34
           subplot(5,17,12);
         elseif ChNr==35
           subplot(5,17,26);
         elseif ChNr==36
           subplot(5,17,10);
         elseif ChNr==37
           subplot(5,17,8);
         elseif ChNr==38
           subplot(5,17,22);
         elseif ChNr==39
           subplot(5,17,6);
         elseif ChNr==40
           subplot(5,17,4);
         elseif ChNr==41
           subplot(5,17,18);
         elseif ChNr==42
           subplot(5,17,2);
         end
      end
 end
      
%end

if Type==1
    h=plot((t_trial/fs)',deoxy_signal,'b');
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial/fs)',oxy_signal,'Color',[1 0 0]);
        set(h,'LineWidth',2);
        if STD
            h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,'b:');
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,'b:');
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0 0]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0 0]);
            set(h,'LineWidth',2);
        end %STD

        ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
        axis(ax);

        line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
        line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
           
        title(['Ch ' num2str(c)],'FontSize',6,'FontWeight', 'bold')
elseif Type==2
    h=plot((t_trial/fs)',deoxy_signal,'Color',[0 0.6 1]);
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial/fs)',oxy_signal,'Color',[1 0.6 0.5]);
        set(h,'LineWidth',2);
        if STD
            h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0 0.6 1]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0 0.6 1]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0.6 0.5]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0.6 0.5]);
            set(h,'LineWidth',2);
        end %STD

        ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
        axis(ax);
        
elseif Type==3
    h=plot((t_trial/fs)',deoxy_signal,'Color',[0.5 0.65 1]);
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial/fs)',oxy_signal,'Color',[1 0.8 0.5]);
        set(h,'LineWidth',2);
        if STD
            h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0.5 0.65 1]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0.5 0.65 1]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0.8 0.5]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0.8 0.5]);
            set(h,'LineWidth',2);
        end %STD

        ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
        axis(ax);

elseif Type==4
    h=plot((t_trial/fs)',deoxy_signal,'Color',[0.5 1 1]);
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial/fs)',oxy_signal,'Color',[0.9 0.5 1]);
        set(h,'LineWidth',2);
        if STD
            h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0.5 1 1]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0.5 1 1]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[0.9 0.5 1]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[0.9 0.5 1]);
            set(h,'LineWidth',2);
        end %STD

        ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
        axis(ax); 
        
elseif Type==5
    h=plot((t_trial/fs)',deoxy_signal,'Color',[0.54 0.7 0.7]);
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial/fs)',oxy_signal,'Color',[0.65 0.71 0.54]);
        set(h,'LineWidth',2);
        if STD
            h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0.54 0.7 0.7]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0.54 0.7 0.7]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[0.65 0.71 0.54]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[0.65 0.71 0.54]);
            set(h,'LineWidth',2);
        end %STD

        ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
        axis(ax);        
                
end

limits=[-0.4 0.3];

if DisplaySteps
	if c==kanal
        if Type==1  
                 figure(200)
                 
                hold on
                h=plot((t_trial/fs)',deoxy_signal,'b');
                set(h,'LineWidth',2);
                hold on
                h=plot((t_trial/fs)',oxy_signal,'Color',[1 0 0]);
                set(h,'LineWidth',2);
                
               % save ak4_ch2 deoxy_signal oxy_signal;
                
                if STD
                    h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,'b:');
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,'b:');
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0 0]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0 0]);
                    set(h,'LineWidth',2);
                end
                ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
                axis(ax);

                line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                
                    title(['gem. Konzentrationsänderung Kanal ' num2str(c)],'FontSize',12,'FontWeight','demi','Interpreter','none')
%               
                ylabel('(mM mm)','FontSize',12)
                legend('[deoxy-Hb]','[oxy-Hb]')
                
                for k = 1 : size(NIRx.Data.AllTrialsOxy{c}(:,:),2)

                dat_avg = squeeze(mean(NIRx.Data.AllTrialsOxy{c}(:,:),2));
                dat_std = squeeze(std(NIRx.Data.AllTrialsOxy{c}(:,:),0,2));
                end
                
                figure (300)
                subplot(3,2,1)
                plot((t_trial/fs)',NIRx.Data.AllTrialsOxy{c}(:,:))
                hold on
                h=plot((t_trial/fs)',dat_avg,'k');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg+dat_std,'k:');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg-dat_std,'k:');
                set(h,'LineWidth',2);
                ax=([Timing(1,1) Timing(1,2) limits]);
                axis(ax);
                line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                title(['RAW [oxy-Hb] Conz. Ch. ' num2str(c)],'FontSize',12,'FontWeight','demi','Interpreter','none')
                ylabel('(mM mm)','FontSize',12)
                
        elseif Type==2  
                 figure(200)
                 
                hold on
                h=plot((t_trial/fs)',deoxy_signal,'Color',[0 0.6 1]);
                set(h,'LineWidth',2);
                hold on
                h=plot((t_trial/fs)',oxy_signal,'Color',[1 0.6 0.5]);
                set(h,'LineWidth',2);
                
               % save ak4_ch2 deoxy_signal oxy_signal;
                
                if STD
                    h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0 0.6 1]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0 0.6 1]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0.6 0.5]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0.6 0.5]);
                    set(h,'LineWidth',2);
                end
                ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
                axis(ax);
                
                for k = 1 : size(NIRx.Data.AllTrialsOxy{c}(:,:),2)

                dat_avg = squeeze(mean(NIRx.Data.AllTrialsOxy{c}(:,:),2));
                dat_std = squeeze(std(NIRx.Data.AllTrialsOxy{c}(:,:),0,2));
                end
                
                figure (300)
                subplot(3,2,3)
                plot((t_trial/fs)',NIRx.Data.AllTrialsOxy{c}(:,:))
                hold on
                h=plot((t_trial/fs)',dat_avg,'k');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg+dat_std,'k:');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg-dat_std,'k:');
                set(h,'LineWidth',2);
                ax=([Timing(1,1) Timing(1,2) limits]);
                axis(ax);
                line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                title(['CAR [oxy-Hb] Conz. Ch. ' num2str(c)],'FontSize',12,'FontWeight','demi','Interpreter','none')
                ylabel('(mM mm)','FontSize',12)

                
        elseif Type==3
                figure(200)
                h=plot((t_trial/fs)',deoxy_signal,'Color',[0.5 0.65 1]);
                set(h,'LineWidth',2);
                hold on
                h=plot((t_trial/fs)',oxy_signal,'Color',[1 0.8 0.5]);
                set(h,'LineWidth',2);
                if STD
                    h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0.5 0.65 1]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0.5 0.65 1]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0.8 0.5]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0.8 0.5]);
                    set(h,'LineWidth',2);
                end %STD

                ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
                axis(ax);
                
                for k = 1 : size(NIRx.Data.AllTrialsOxy{c}(:,:),2)

                dat_avg = squeeze(mean(NIRx.Data.AllTrialsOxy{c}(:,:),2));
                dat_std = squeeze(std(NIRx.Data.AllTrialsOxy{c}(:,:),0,2));
                end
                
                figure (300)
                subplot(3,2,4)
                plot((t_trial/fs)',NIRx.Data.AllTrialsOxy{c}(:,:))
                hold on
                h=plot((t_trial/fs)',dat_avg,'k');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg+dat_std,'k:');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg-dat_std,'k:');
                set(h,'LineWidth',2);
                ax=([Timing(1,1) Timing(1,2) limits]);
                axis(ax);
                line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                title(['TF [oxy-Hb] Conz. Ch. ' num2str(c)],'FontSize',12,'FontWeight','demi','Interpreter','none')
                ylabel('(mM mm)','FontSize',12)
                
                
        elseif Type==4
                figure(200)
                h=plot((t_trial/fs)',deoxy_signal,'Color',[0.5 1 1]);
                set(h,'LineWidth',2);
                hold on
                h=plot((t_trial/fs)',oxy_signal,'Color',[0.9 0.5 1]);
                set(h,'LineWidth',2);
                if STD
                    h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0.5 1 1]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0.5 1 1]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[0.9 0.5 1]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[0.9 0.5 1]);
                    set(h,'LineWidth',2);
                end %STD

                ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
                axis(ax);
                
                for k = 1 : size(NIRx.Data.AllTrialsOxy{c}(:,:),2)

                dat_avg = squeeze(mean(NIRx.Data.AllTrialsOxy{c}(:,:),2));
                dat_std = squeeze(std(NIRx.Data.AllTrialsOxy{c}(:,:),0,2));
                end
                
                figure (300)
                subplot(3,2,5)
                plot((t_trial/fs)',NIRx.Data.AllTrialsOxy{c}(:,:))
                hold on
                h=plot((t_trial/fs)',dat_avg,'k');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg+dat_std,'k:');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg-dat_std,'k:');
                set(h,'LineWidth',2);
                ax=([Timing(1,1) Timing(1,2) limits]);
                axis(ax);
                line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                title(['ICA [oxy-Hb] Conz. Ch. ' num2str(c)],'FontSize',12,'FontWeight','demi','Interpreter','none')
                ylabel('(mM mm)','FontSize',12) 
                
          elseif Type==5
                figure(200)
                h=plot((t_trial/fs)',deoxy_signal,'Color',[0.54 0.7 0.7]);
                set(h,'LineWidth',2);
                hold on
                h=plot((t_trial/fs)',oxy_signal,'Color',[0.65 0.71 0.54]);
                set(h,'LineWidth',2);
                if STD
                    h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,':','Color',[0.54 0.7 0.7]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,':','Color',[0.54 0.7 0.7]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[0.65 0.71 0.54]);
                    set(h,'LineWidth',2);
                    h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[0.65 0.71 0.54]);
                    set(h,'LineWidth',2);
                end %STD

                ax=([Timing(1,1) Timing(1,2) -0.2 0.2]);
                axis(ax);
                
                for k = 1 : size(NIRx.Data.AllTrialsOxy{c}(:,:),2)

                dat_avg = squeeze(mean(NIRx.Data.AllTrialsOxy{c}(:,:),2));
                dat_std = squeeze(std(NIRx.Data.AllTrialsOxy{c}(:,:),0,2));
                end
                
                figure (300)
                subplot(3,2,2)
                plot((t_trial/fs)',NIRx.Data.AllTrialsOxy{c}(:,:))
                hold on
                h=plot((t_trial/fs)',dat_avg,'k');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg+dat_std,'k:');
                set(h,'LineWidth',2);
                h=plot((t_trial/fs)',dat_avg-dat_std,'k:');
                set(h,'LineWidth',2);
                ax=([Timing(1,1) Timing(1,2) limits]);
                axis(ax);
                line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
                title(['TP (Zhang) [oxy-Hb] Conz. Ch. ' num2str(c)],'FontSize',12,'FontWeight','demi','Interpreter','none')
                ylabel('(mM mm)','FontSize',12)       
        end
 	end
          
            
 end
        
        
      


        
        
        
end


        
        
        
              
                    
                    
                    
                    
                    
        
        
        