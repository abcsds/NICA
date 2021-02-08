% Illustration_multichannel_spectra
% uses the calcNIRSspectra function to calculate and illustrates the [(de)oxy-Hb]spectra
% of each used NIRS channel from a x*x measurement grid
%
% [rOxy rDeoxy]=Illustration_multichannel_spectra(ChNr, oxy_Data, deoxy_Data, fs, dispFreq, ExCh)
%
% Input:
%   ChNr          ... Number of the current channel
%   oxy_Data      ... Oxy data of the current channel
%   deoxy_Data    ... Deoxy data of the current channel
%   fs            ... Sampling frequency
%   dispFreq      ... Frequencies up to this value are plotted
%   ExCh          ... Channels not used
%
% Output:
%   rOxy          ... Structure containing the [oxy-Hb] spectrum
%   rDeoxy        ... Calculated [deoxy-Hb] spectrum

% Copyright (C) 2012 by the Institute for Knowledge Discovery, Graz University of Technology
% Guenther Bauernfeind <g.bauernfeind@tugraz.at>
% WWW: http://bci.tugraz.at/
% $Id: Illustration_multichannel_spectra.m v0.1 2012-02-13 10:00:00 ISD$
%
% This software was implemented in the framework of the Styrian government project "Einfluss von
% Herz-Kreislauf-Parametern auf das Nah-Infrarot-Spektroskopie (NIRS) Signal" (A3-22.N-13/2009-8)
% and is part of the BIOSIG-toolbox http://biosig.sf.net/
%
% LICENSE:
%
%   This program is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.

% Modified 24.02.2016
% Bachmaier Dominik
% Changes:  - Adapted to new version of NIRS setup including LSL recorder

function [rOxy, rDeoxy]=illustrationmultichannelspectra(ChNr, oxy_Data, deoxy_Data, fs, dispFreq, NIRx, settings,ExCh)
    % check if current channel is used
    for i=1:1:size(ExCh,2)
        if ExCh(ChNr)
            rOxy =[];
            rDeoxy=[];
            return
        end
    end

    %% Illustration definition for 3*11 grid
    if settings.probeset.value == 5 % 50(52) ???

        %first row
        if ChNr==1
            %set(gca,'Visible','off')
            g1=axes('position',[0.05300 0.76667 0.07576 0.125]);axes(g1);
        end
        if ChNr==2
            g2=axes('position',[0.14394 0.76667 0.07576 0.125]);axes(g2);end
        if ChNr==3
            g3=axes('position',[0.23485 0.76667 0.07576 0.125]);axes(g3);end
        if ChNr==4
            g4=axes('position',[0.32576 0.76667 0.07576 0.125]);axes(g4);end
        if ChNr==5
            g5=axes('position',[0.41667 0.76667 0.07576 0.125]);axes(g5);end
        if ChNr==6
            g6=axes('position',[0.50758 0.76667 0.07576 0.125]);axes(g6);end
        if ChNr==7
            g7=axes('position',[0.59848 0.76667 0.07576 0.125]);axes(g7);end
        if ChNr==8
            g8=axes('position',[0.68939 0.76667 0.07576 0.125]);axes(g8);end
        if ChNr==9
            g9=axes('position',[0.78030 0.76667 0.07576 0.125]);axes(g9);end
        if ChNr==10
            g10=axes('position',[0.87121 0.76667 0.07576 0.125]);axes(g10);end

        %second row
        if ChNr==11
            g11=axes('position',[0.00758 0.60000 0.07576 0.125]);axes(g11);end
        if ChNr==12
            g12=axes('position',[0.09848 0.60000 0.07576 0.125]);axes(g12);end
        if ChNr==13
            g13=axes('position',[0.18939 0.60000 0.07576 0.125]);axes(g13);end
        if ChNr==14
            g14=axes('position',[0.28030 0.60000 0.07576 0.125]);axes(g14);end
        if ChNr==15
            g15=axes('position',[0.37121 0.60000 0.07576 0.125]);axes(g15);end
        if ChNr==16
            g16=axes('position',[0.46212 0.60000 0.07576 0.125]);axes(g16);end
        if ChNr==17
            g17=axes('position',[0.55303 0.60000 0.07576 0.125]);axes(g17);end
        if ChNr==18
            g18=axes('position',[0.64394 0.60000 0.07576 0.125]);axes(g18);end
        if ChNr==19
            g19=axes('position',[0.73485 0.60000 0.07576 0.125]);axes(g19);end
        if ChNr==20
            g20=axes('position',[0.82575 0.60000 0.07576 0.125]);axes(g20);end
        if ChNr==21
            g21=axes('position',[0.91667 0.60000 0.07576 0.125]);axes(g21);end

        %third row
        if ChNr==22
            g22=axes('position',[0.05300 0.43334 0.07576 0.125]);axes(g22);end
        if ChNr==23
            g23=axes('position',[0.14394 0.43334 0.07576 0.125]);axes(g23);end
        if ChNr==24
            g24=axes('position',[0.23485 0.43334 0.07576 0.125]);axes(g24);end
        if ChNr==25
            g25=axes('position',[0.32576 0.43334 0.07576 0.125]);axes(g25);end
        if ChNr==26
            g26=axes('position',[0.41667 0.43334 0.07576 0.125]);axes(g26);end
        if ChNr==27
            g27=axes('position',[0.50758 0.43334 0.07576 0.125]);axes(g27);end
        if ChNr==28
            g28=axes('position',[0.59848 0.43334 0.07576 0.125]);axes(g28);end
        if ChNr==29
            g29=axes('position',[0.68939 0.43334 0.07576 0.125]);axes(g29);end
        if ChNr==30
            g30=axes('position',[0.78030 0.43334 0.07576 0.125]);axes(g30);end
        if ChNr==31
            g31=axes('position',[0.87121 0.43334 0.07576 0.125]);axes(g31);end

        %fourth row
        if ChNr==32
            g32=axes('position',[0.00758 0.26667 0.07576 0.125]);axes(g32);end
        if ChNr==33
            g33=axes('position',[0.09848 0.26667 0.07576 0.125]);axes(g33);end
        if ChNr==34
            g34=axes('position',[0.18939 0.26667 0.07576 0.125]);axes(g34);end
        if ChNr==35
            g35=axes('position',[0.28030 0.26667 0.07576 0.125]);axes(g35);end
        if ChNr==36
            g36=axes('position',[0.37121 0.26667 0.07576 0.125]);axes(g36);end
        if ChNr==37
            g37=axes('position',[0.46212 0.26667 0.07576 0.125]);axes(g37);end
        if ChNr==38
            g38=axes('position',[0.55303 0.26667 0.07576 0.125]);axes(g38);end
        if ChNr==39
            g39=axes('position',[0.64394 0.26667 0.07576 0.125]);axes(g39);end
        if ChNr==40
            g40=axes('position',[0.73485 0.26667 0.07576 0.125]);axes(g40);end
        if ChNr==41
            g41=axes('position',[0.82575 0.26667 0.07576 0.125]);axes(g41);end
        if ChNr==42
            g42=axes('position',[0.91667 0.26667 0.07576 0.125]);axes(g42);end

        %fifth row
        if ChNr==43
            g43=axes('position',[0.05300 0.10000 0.07576 0.125]);axes(g43);end
        if ChNr==44
            g44=axes('position',[0.14394 0.10000 0.07576 0.125]);axes(g44);end
        if ChNr==45
            g45=axes('position',[0.23485 0.10000 0.07576 0.125]);axes(g45);end
        if ChNr==46
            g46=axes('position',[0.32576 0.10000 0.07576 0.125]);axes(g46);end
        if ChNr==47
            g47=axes('position',[0.41667 0.10000 0.07576 0.125]);axes(g47);end
        if ChNr==48
            g48=axes('position',[0.50758 0.10000 0.07576 0.125]);axes(g48);end
        if ChNr==49
            g49=axes('position',[0.59848 0.10000 0.07576 0.125]);axes(g49);end
        if ChNr==50
            g50=axes('position',[0.68939 0.10000 0.07576 0.125]);axes(g50);end
        if ChNr==51
            g51=axes('position',[0.78030 0.10000 0.07576 0.125]);axes(g51);end
        if ChNr==52
            g52=axes('position',[0.87121 0.10000 0.07576 0.125]);axes(g52);end

    elseif settings.probeset.value == 3 % 38
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


    elseif settings.probeset.value == 4 % 47
        c=ChNr;
        %erste Zeile
        %                     if c==52
        %                         %set(gca,'Visible','off')
        %                         g52=axes('position',[0.05300 0.76667 0.07576 0.125]);axes(g52);
        %                     elseif c==51
        %                         g51=axes('position',[0.14394 0.76667 0.07576 0.125]);axes(g51);
        if c==46
            g50=axes('position',[0.23485 0.76667 0.07576 0.125]);axes(g50);end
        if c==44
            g49=axes('position',[0.32576 0.76667 0.07576 0.125]);axes(g49);end
        if c==43
            g48=axes('position',[0.41667 0.76667 0.07576 0.125]);axes(g48);end
        if c==41
            g47=axes('position',[0.50758 0.76667 0.07576 0.125]);axes(g47);end
        if c==40
            g46=axes('position',[0.59848 0.76667 0.07576 0.125]);axes(g46);end
        if c==38
            g45=axes('position',[0.68939 0.76667 0.07576 0.125]);axes(g45);end
        if c==37
            g44=axes('position',[0.78030 0.76667 0.07576 0.125]);axes(g44);end
        %                     elseif c==43
        %                         g43=axes('position',[0.87121 0.76667 0.07576 0.125]);axes(g43);
        %zweite Zeile
        if c==47
            g42=axes('position',[0.00758 0.60000 0.07576 0.125]);axes(g42);end
        %                     elseif c==41
        %                         g41=axes('position',[0.09848 0.60000 0.07576 0.125]);axes(g41);
        if c==45
            g40=axes('position',[0.18939 0.60000 0.07576 0.125]);axes(g40);end
        if c==32
            g39=axes('position',[0.28030 0.60000 0.07576 0.125]);axes(g39);end
        if c==42
            g38=axes('position',[0.37121 0.60000 0.07576 0.125]);axes(g38);end
        if c==28
            g37=axes('position',[0.46212 0.60000 0.07576 0.125]);axes(g37);end
        if c==39
            g36=axes('position',[0.55303 0.60000 0.07576 0.125]);axes(g36);end
        if c==24
            g35=axes('position',[0.64394 0.60000 0.07576 0.125]);axes(g35);end
        if c==36
            g34=axes('position',[0.73485 0.60000 0.07576 0.125]);axes(g34);end
        if c==20
            g33=axes('position',[0.82575 0.60000 0.07576 0.125]);axes(g33);end
        %                     elseif c==32
        %                         g32=axes('position',[0.91667 0.60000 0.07576 0.125]);axes(g32);
        %dritte Zeile
        if c==35
            g31=axes('position',[0.05300 0.43334 0.07576 0.125]);axes(g31);end
        if c==34
            g30=axes('position',[0.14394 0.43334 0.07576 0.125]);axes(g30);end
        if c==31
            g29=axes('position',[0.23485 0.43334 0.07576 0.125]);axes(g29);end
        if c==30
            g28=axes('position',[0.32576 0.43334 0.07576 0.125]);axes(g28);end
        if c==27
            g27=axes('position',[0.41667 0.43334 0.07576 0.125]);axes(g27);end
        if c==26
            g26=axes('position',[0.50758 0.43334 0.07576 0.125]);axes(g26);end
        if c==23
            g25=axes('position',[0.59848 0.43334 0.07576 0.125]);axes(g25);end
        if c==22
            g24=axes('position',[0.68939 0.43334 0.07576 0.125]);axes(g24);end
        if c==19
            g23=axes('position',[0.78030 0.43334 0.07576 0.125]);axes(g23);end
        if c==18
            g22=axes('position',[0.87121 0.43334 0.07576 0.125]);axes(g22);end
        %vierte Zeile
        if c==16
            g21=axes('position',[0.00758 0.26667 0.07576 0.125]);axes(g21);end
        if c==33
            g20=axes('position',[0.09848 0.26667 0.07576 0.125]);axes(g20);end
        if c==14
            g19=axes('position',[0.18939 0.26667 0.07576 0.125]);axes(g19);end
        if c==29
            g18=axes('position',[0.28030 0.26667 0.07576 0.125]);axes(g18);end
        if c==11
            g17=axes('position',[0.37121 0.26667 0.07576 0.125]);axes(g17);end
        if c==25
            g16=axes('position',[0.46212 0.26667 0.07576 0.125]);axes(g16);end
        if c==8
            g15=axes('position',[0.55303 0.26667 0.07576 0.125]);axes(g15);end
        if c==21
            g14=axes('position',[0.64394 0.26667 0.07576 0.125]);axes(g14);end
        if c==5
            g13=axes('position',[0.73485 0.26667 0.07576 0.125]);axes(g13);end
        if c==17
            g12=axes('position',[0.82575 0.26667 0.07576 0.125]);axes(g12);end
        if c==2
            g11=axes('position',[0.91667 0.26667 0.07576 0.125]);axes(g11);end
        %fünfte Zeile
        if c==15
            g10=axes('position',[0.05300 0.10000 0.07576 0.125]);axes(g10);end
        if c==13
            g9=axes('position',[0.14394 0.10000 0.07576 0.125]);axes(g9);end
        if c==12
            g8=axes('position',[0.23485 0.10000 0.07576 0.125]);axes(g8);end
        if c==10
            g7=axes('position',[0.32576 0.10000 0.07576 0.125]);axes(g7);end
        if c==9
            g6=axes('position',[0.41667 0.10000 0.07576 0.125]);axes(g6);end
        if c==7
            g5=axes('position',[0.50758 0.10000 0.07576 0.125]);axes(g5);end
        if c==6
            g4=axes('position',[0.59848 0.10000 0.07576 0.125]);axes(g4);end
        if c==4
            g3=axes('position',[0.68939 0.10000 0.07576 0.125]);axes(g3);end
        if c==3
            g2=axes('position',[0.78030 0.10000 0.07576 0.125]);axes(g2);end
        if c==1
            g1=axes('position',[0.87121 0.10000 0.07576 0.125]);axes(g1);end



    elseif settings.probeset.value == 6 % 99
        if ChNr==1
            subplot(5,11,53);
        elseif ChNr==2
            subplot(5,11,51);
        elseif ChNr==3
            subplot(5,11,41);
        elseif ChNr==4
            subplot(5,11,49);
        elseif ChNr==5
            subplot(5,11,47);
        elseif ChNr==6
            subplot(5,11,37);
        elseif ChNr==7
            subplot(5,11,43);
        elseif ChNr==8
            subplot(5,11,31);
        elseif ChNr==9
            subplot(5,11,21);
        elseif ChNr==10
            subplot(5,11,39);
        elseif ChNr==11
            subplot(5,11,29);
        elseif ChNr==12
            subplot(5,11,27);
        elseif ChNr==13
            subplot(5,11,17);
        elseif ChNr==14
            subplot(5,11,35);
        elseif ChNr==15
            subplot(5,11,25);
        elseif ChNr==16
            subplot(5,11,13);
        elseif ChNr==17
            subplot(5,11,11);
        elseif ChNr==18
            subplot(5,11,19);
        elseif ChNr==19
            subplot(5,11,9);
        elseif ChNr==20
            subplot(5,11,7);
        elseif ChNr==21
            subplot(5,11,15);
        elseif ChNr==22
            subplot(5,11,5);
        elseif ChNr==23
            subplot(5,11,3);
        elseif ChNr==24
            subplot(5,11,1);
        else
            return
        end

    elseif settings.probeset.value == 7 % 777
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
        
    elseif settings.probeset.value == 8 % 888
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
        
    else
        disp('grid not supported');
    end

    %% test OF
    if settings.optodeFail.value
        try
            OptodeFailure = settings.optodeFail.cellArray;
            OFInk=1;
        catch ME
            disp(ME.message);
            OFInk=0;
        end

        if OFInk
            OFChSpectra=[];
            if ~isempty(OptodeFailure)

                for k = 1 : length(OptodeFailure)
                    OFChSpectra = [OFChSpectra OptodeFailure{k}{1}];
                end
            end
        end
    else
        OFInk = 0;
    end


    %%   Calculate and display the [(de)oxy-Hb]spectra
    %calculate [(de)oxy-Hb] spectra
    if OFInk
        for h=1:1:length(OFChSpectra)
            if OFChSpectra(h)==ChNr
                rOxy =[];
                rDeoxy=[];
                return
            else
            end
        end
    end
    
    
    rOxy=calcNIRSspectra(oxy_Data,fs);
    rDeoxy=calcNIRSspectra(deoxy_Data,fs);

    
    if settings.generateFiguresRAW
        %display [oxy-Hb] spectra
        p1 = rOxy{1}.p;
        f1 = rOxy{1}.f;
        Color='r';
        idx = find(f1<=dispFreq);
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
        hold on

        %display [deoxy-Hb] spectra
        p1 = rDeoxy{1}.p;
        f1 = rDeoxy{1}.f;
        Color='b';
        idx = find(f1<=dispFreq);
        plot(f1(idx), 10*log10(p1(idx)),'Color', Color,'LineWidth',1.5);
        xlabel('f [Hz]','FontSize',6);
    end
end
