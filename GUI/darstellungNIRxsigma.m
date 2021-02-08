function darstellungNIRxsigma(c,std_oxy_signal,std_deoxy_signal, NIRx,settings,t_trial,fs, data, status,oxy_signal,deoxy_signal)
%  (c)G???nther Bauernfeind

% This file (darstellung_etg_sigma) is part of "NIRS" a programm to compute the concentration
% change of Hb and HbO2 from the rawdata files *.gdf recorded with the Graz-NIRS-system
% and for validation this data with recorded data from the Hitachi ETG-4000
% *.gdf.

% Modified 25.05.2016
% Bachmaier Dominik
% Changes: Adapted to new version of NIRS setup including LSL recorder
%           Added some functionality, plotting single channels an store
%           them

% Timing=NIRx.settings.Timing;
% Anfang=NIRx.settings.Anfang;
% Ende=NIRx.settings.Ende;
% kanal=NIRx.settings.kanal;
% probeset=NIRx.settings.probeset;
% STD=NIRx.settings.STD;
% DisplaySteps=NIRx.settings.DisplaySteps;
% ExCh=NIRx.settings.ExCh;

switch settings.signal.value
    case 1
        Timing = [-settings.timing.pre (settings.timing.signal+settings.timing.post)];
    case 2
        Timing = [1 size(oxy_signal,1)];
end

Anfang = 0;
Ende = settings.timing.signal;
kanal = settings.channels.display;
probeset = settings.probeset.value;
STD = settings.plotSTD;
DisplaySteps = 1;
ExCh = settings.channels.exclude;
cmin = settings.rangeMin;
cmax = settings.rangeMax;

% check if current channel is used
if ExCh(c)
    return
end


% for i=1:1:size(ExCh,2)
%     if c==ExCh(i)
%         
%         return
%     end
% end

if probeset == 5 %50 %NIRx
    
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

if probeset == 1 % 12 %NIRx
    
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

if probeset == 3 % 38 %NIRx
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

if probeset == 2 % 24 %NIRx
    
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
if probeset == 4 % 47
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
        %f?nfte Zeile
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

if probeset == 6 % 99
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
if probeset == 7 % 777
    for i=1:1:size(ExCh,2)
        if c==ExCh(i)
            
            return
        end
    end
    if NIRx.settings.AFChnUse %mit AF
    else %ohne AF
        if c==1
            subplot(5,17,84);
        elseif c==2
            subplot(5,17,68);
        elseif c==3
            subplot(5,17,82);
        elseif c==4
            subplot(5,17,80);
        elseif c==5
            subplot(5,17,64);
        elseif c==6
            subplot(5,17,78);
        elseif c==7
            subplot(5,17,76);
        elseif c==8
            subplot(5,17,60);
        elseif c==9
            subplot(5,17,74);
        elseif c==10
            subplot(5,17,72);
        elseif c==11
            subplot(5,17,56);
        elseif c==12
            subplot(5,17,70);
        elseif c==13
            subplot(5,17,52);
        elseif c==14
            subplot(5,17,66);
        elseif c==15
            subplot(5,17,50);
        elseif c==16
            subplot(5,17,48);
        elseif c==17
            subplot(5,17,32);
        elseif c==18
            subplot(5,17,62);
        elseif c==19
            subplot(5,17,46);
        elseif c==20
            subplot(5,17,44);
        elseif c==21
            subplot(5,17,28);
        elseif c==22
            subplot(5,17,58);
        elseif c==23
            subplot(5,17,42);
        elseif c==24
            subplot(5,17,40);
        elseif c==25
            subplot(5,17,24);
        elseif c==26
            subplot(5,17,54);
        elseif c==27
            subplot(5,17,38);
        elseif c==28
            subplot(5,17,36);
        elseif c==29
            subplot(5,17,20);
        elseif c==30
            subplot(5,17,34);
        elseif c==31
            subplot(5,17,16);
        elseif c==32
            subplot(5,17,30);
        elseif c==33
            subplot(5,17,14);
        elseif c==34
            subplot(5,17,12);
        elseif c==35
            subplot(5,17,26);
        elseif c==36
            subplot(5,17,10);
        elseif c==37
            subplot(5,17,8);
        elseif c==38
            subplot(5,17,22);
        elseif c==39
            subplot(5,17,6);
        elseif c==40
            subplot(5,17,4);
        elseif c==41
            subplot(5,17,18);
        elseif c==42
            subplot(5,17,2);
        end
    end
end
if probeset == 8 % 888
    ChNr=c;
    if ChNr==1
        subplot(14,13,7);
    elseif ChNr==2
        subplot(14,13,19);
    elseif ChNr==3
        subplot(14,13,21);
    elseif ChNr==4
        subplot(14,13,33);
    elseif ChNr==5
        subplot(14,13,31);
    elseif ChNr==6
        subplot(14,13,43);
    elseif ChNr==7
        subplot(14,13,45);
    elseif ChNr==8
        subplot(14,13,57);
    elseif ChNr==9
        subplot(14,13,35);
    elseif ChNr==10
        subplot(14,13,47);
    elseif ChNr==11
        subplot(14,13,49);
    elseif ChNr==12
        subplot(14,13,61);
    elseif ChNr==13
        subplot(14,13,55);
    elseif ChNr==14
        subplot(14,13,67);
    elseif ChNr==15
        subplot(14,13,69);
    elseif ChNr==16
        subplot(14,13,81);
    elseif ChNr==17
        subplot(14,13,59);
    elseif ChNr==18
        subplot(14,13,71);
    elseif ChNr==19
        subplot(14,13,73);
    elseif ChNr==20
        subplot(14,13,85);
    elseif ChNr==21
        subplot(14,13,63);
    elseif ChNr==22
        subplot(14,13,75);
    elseif ChNr==23
        subplot(14,13,77);
    elseif ChNr==24
        subplot(14,13,89);
    elseif ChNr==25
        subplot(14,13,79);
    elseif ChNr==26
        subplot(14,13,93);
    elseif ChNr==27
        subplot(14,13,105);
    elseif ChNr==28
        subplot(14,13,83);
    elseif ChNr==29
        subplot(14,13,95);
    elseif ChNr==30
        subplot(14,13,97);
    elseif ChNr==31
        subplot(14,13,109);
    elseif ChNr==32
        subplot(14,13,87);
    elseif ChNr==33
        subplot(14,13,99);
    elseif ChNr==34
        subplot(14,13,101);
    elseif ChNr==35
        subplot(14,13,113);
    elseif ChNr==36
        subplot(14,13,91);
    elseif ChNr==37
        subplot(14,13,103);
    elseif ChNr==38
        subplot(14,13,117);
    elseif ChNr==39
        subplot(14,13,107);
    elseif ChNr==40
        subplot(14,13,119);
    elseif ChNr==41
        subplot(14,13,121);
    elseif ChNr==42
        subplot(14,13,133);
    elseif ChNr==43
        subplot(14,13,111);
    elseif ChNr==44
        subplot(14,13,123);
    elseif ChNr==45
        subplot(14,13,125);
    elseif ChNr==46
        subplot(14,13,137);
    elseif ChNr==47
        subplot(14,13,115);
    elseif ChNr==48
        subplot(14,13,127);
    elseif ChNr==49
        subplot(14,13,129);
    elseif ChNr==50
        subplot(14,13,141);
    elseif ChNr==51
        subplot(14,13,135);
    elseif ChNr==52
        subplot(14,13,147);
    elseif ChNr==53
        subplot(14,13,149);
    elseif ChNr==54
        subplot(14,13,161);
    elseif ChNr==55
        subplot(14,13,139);
    elseif ChNr==56
        subplot(14,13,151);
    elseif ChNr==57
        subplot(14,13,153);
    elseif ChNr==58
        subplot(14,13,165);
    elseif ChNr==59
        subplot(14,13,163);
    elseif ChNr==60
        subplot(14,13,175);
    elseif ChNr==61
        subplot(14,13,177);
        
    end
    
end

switch settings.signal.value % averaged over trials (1) or continuous (2)
    case 1
        h=plot((t_trial/fs)',deoxy_signal,'b');
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial/fs)',oxy_signal,'Color',[1 0.6 0.5]);
        set(h,'LineWidth',2);
    case 2
        h=plot(deoxy_signal,'b');
        set(h,'LineWidth',2);
        hold on
        h=plot(oxy_signal,'Color',[1 0.6 0.5]);
        set(h,'LineWidth',2);
end

if STD
    h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,'b:');
    set(h,'LineWidth',2);
    h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,'b:');
    set(h,'LineWidth',2);
    h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0.6 0.5]);
    set(h,'LineWidth',2);
    h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0.6 0.5]);
    set(h,'LineWidth',2);
end %STD

ax=([Timing(1,1) Timing(1,2) cmin cmax]);
axis(ax);

line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);

title(['Ch ' num2str(c)],'FontSize',6,'FontWeight', 'bold')



if DisplaySteps
    if kanal(c)
        
        figure(200+c)
        
        font_size = 16;
        
        
        hold on
        h=plot((t_trial/fs)',deoxy_signal,'b');
        set(h,'LineWidth',2);
        hold on
        h=plot((t_trial/fs)',oxy_signal,'Color',[1 0.6 0.5]);
        set(h,'LineWidth',2);
        grid on;
        set(gca,'FontSize',font_size);
        
        % save ak4_ch2 deoxy_signal oxy_signal;
        
        if STD
            h=plot((t_trial/fs)',deoxy_signal+std_deoxy_signal,'b:');
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',deoxy_signal-std_deoxy_signal,'b:');
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal+std_oxy_signal,':','Color',[1 0.6 0.5]);
            set(h,'LineWidth',2);
            h=plot((t_trial/fs)',oxy_signal-std_oxy_signal,':','Color',[1 0.6 0.5]);
            set(h,'LineWidth',2);
        end
        
        if  max(max(oxy_signal,deoxy_signal)) > 0.1 && min(min(oxy_signal,deoxy_signal)) < -0.1
            ax=([Timing(1,1) Timing(1,2) min(min(oxy_signal,deoxy_signal)) max(max(oxy_signal,deoxy_signal))]);
        elseif max(max(oxy_signal,deoxy_signal)) > 0.1 && min(min(oxy_signal,deoxy_signal)) >= -0.1
            ax=([Timing(1,1) Timing(1,2) -0.1 max(max(oxy_signal,deoxy_signal))]);
        elseif max(max(oxy_signal,deoxy_signal)) <= 0.1 && min(min(oxy_signal,deoxy_signal)) >= -0.1
            ax=([Timing(1,1) Timing(1,2) -0.1 0.1]);
        elseif max(max(oxy_signal,deoxy_signal)) <= 0.1 && min(min(oxy_signal,deoxy_signal)) < -0.1
            ax=([Timing(1,1) Timing(1,2) min(min(oxy_signal,deoxy_signal)) 0.1]);
        end
        
%         axis(ax);
        
        line([Anfang Anfang], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
        line([Ende Ende], [ax(1,3) ax(1,4)],'color','k','LineWidth',2);
        ylim([-0.02,0.08]);
        title(['Avg. Concentration Change of Channel ' num2str(c)],'FontSize',12,'FontWeight','bold','Interpreter','none')
        %
        ylabel('\Delta c (mM*mm)','FontSize',12);
        xlabel('Time (s)','FontSize',12);
        legend('[deoxy-Hb]','[oxy-Hb]');
        set(gca,'FontSize',font_size);
        
        if status.grandAverage
            saveas(h, [data.analysisPath filesep data.analysisFilename '_Conc_Chg_Avg', '_','Ch',num2str(c)],'fig');
        else
            if settings.correctionMode.value == 1
    %             print( '-dpng', '-r300', [DataPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_gem-Konzentrations?nderung', '_','Kanal',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode]);
                saveas(h, [data.analysisPath filesep data.analysisFilename '_Conc_Chg_Avg', '_','Ch',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.corrmode],'fig');
            else
    %             print( '-dpng', '-r300', [DataPath, Gruppe, '\', AnalysePath, '\',NIRx.settings.Subj,'_',Task,'_',ImageClass,'_gem-Konzentrations?nderung', '_','Kanal',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode]);
                saveas(h, [data.analysisPath filesep data.analysisFilename '_Conc_Chg_Avg', '_','Ch',num2str(c),NIRx.settings.Usage.CAR,NIRx.settings.Usage.TFICA,NIRx.settings.Usage.corrmode],'fig');
            end
        end
    end
end
end













