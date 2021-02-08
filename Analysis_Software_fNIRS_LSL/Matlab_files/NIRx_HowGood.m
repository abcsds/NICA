function [NIRx]=NIRx_HowGood(NIRx)


%%%%%%%%%%%%%%
%load spectra%
%%%%%%%%%%%%%%

 %[raw]   
 meanOxyspecdirty=NIRx.Data.Spectra.raw(:,1);
 meanDeoxyspecdirty=NIRx.Data.Spectra.raw(:,2);
 %[clean]
 meanOxyspecclean=NIRx.Data.Spectra.cleaned(:,1);
 meanDeoxyspecclean=NIRx.Data.Spectra.cleaned(:,2);
 %[Base]
 Base=NIRx.Data.Spectra.Base;
 
 
%Boarder
Mayer=NIRx.Data.Spectra.FWindowMayer;
Resp=NIRx.Data.Spectra.FWindowResp;
Puls=NIRx.Data.Spectra.FWindowPuls;
maxShow=NIRx.settings.dispFreq;

allOther1=[0 Mayer(1)];
allOther2=[Mayer(2) Resp(1)];
allOther3=[Resp(2) Puls(1)];

idxOther1a = find(Base>=allOther1(1));
idxOther1 = idxOther1a(find(Base(idxOther1a)<=allOther1(2)));

idxOther2a = find( Base>=allOther2(1));
idxOther2 = idxOther2a(find(Base(idxOther2a)<=allOther2(2)));

idxOther3a = find( Base>=allOther3(1));
idxOther3 = idxOther3a(find(Base(idxOther3a)<=allOther3(2)));

idxOther = [idxOther1; idxOther2; idxOther3];

idx6a = find(Base<=maxShow); %Puls
idx6 = find(Base(idx6a)>=Puls(1));

idx5a = find(Base<=Puls(1)); % between Puls and Resp
idx5 = find(Base(idx5a)>=Resp(2));

idx4a = find(Base<=Resp(2)); % Resp
idx4 = find(Base(idx4a)>=Resp(1));

idx3a = find(Base<=Resp(1)); % between Resp and Mayer
idx3 = find(Base(idx3a)>=Mayer(2));

idx2a = find(Base<=Mayer(2)); % Mayer
idx2 = find(Base(idx2a)>=Mayer(1));


idx1 = find(Base<=Mayer(1)); %Below Mayer


PO1 = meanOxyspecdirty(idx1);
PCO1 = meanOxyspecclean(idx1); 
FO1 = Base(idx1);
PO2 = meanOxyspecdirty(idx2); 
PCO2 = meanOxyspecclean(idx2); 
FO2 = Base(idx2);
PO3 = meanOxyspecdirty(idx3); 
PCO3 = meanOxyspecclean(idx3); 
FO3 = Base(idx3);
PO4 = meanOxyspecdirty(idx4);
PCO4 = meanOxyspecclean(idx4); 
FO4 = Base(idx4);
PO5 = meanOxyspecdirty(idx5);
PCO5 = meanOxyspecclean(idx5);
FO5 = Base(idx5);
PO6 = meanOxyspecdirty(idx6);
PCO6 = meanOxyspecclean(idx6);
FO6 = Base(idx6);

PD1 = meanDeoxyspecdirty(idx1); 
PCD1 = meanDeoxyspecclean(idx1);
FD1 = Base(idx1);
PD2 = meanDeoxyspecdirty(idx2);
PCD2 = meanDeoxyspecclean(idx2);
FD2 = Base(idx2);
PD3 = meanDeoxyspecdirty(idx3);
PCD3 = meanDeoxyspecclean(idx3);
FD3 = Base(idx3);
PD4 = meanDeoxyspecdirty(idx4); 
PCD4 = meanDeoxyspecclean(idx4);
FD4 = Base(idx4);
PD5 = meanDeoxyspecdirty(idx5);
PCD5 = meanDeoxyspecclean(idx5); 
FD5 = Base(idx5);
PD6 = meanDeoxyspecdirty(idx6);
PCD6 = meanDeoxyspecclean(idx6); 
FD6 = Base(idx6);

PotherClean = meanOxyspecclean(idxOther);
PotherDirty = meanOxyspecdirty(idxOther);
PotherdClean = meanDeoxyspecclean(idxOther);
PotherdDirty = meanDeoxyspecdirty(idxOther);





figure
plot(FO1,10*log10(PO1),'r:','LineWidth',1.5,'Color',[1 0.6 0.6]);
hold on
plot(FO2,10*log10(PO2),'LineStyle','-','LineWidth',1.5,'Color',[1 0.6 0.6]);
plot(FO3,10*log10(PO3),'LineStyle',':','LineWidth',1.5,'Color',[1 0.6 0.6]);
plot(FO4,10*log10(PO4),'LineStyle','-','LineWidth',1.5,'Color',[1 0.6 0.6]);
plot(FO5,10*log10(PO5),'LineStyle',':','LineWidth',1.5,'Color',[1 0.6 0.6]);
plot(FO6,10*log10(PO6),'LineStyle','-','LineWidth',1.5,'Color',[1 0.6 0.6]);

plot(FD1,10*log10(PD1),'LineStyle',':','LineWidth',1.5,'Color',[0.8 0.8 1]);
plot(FD2,10*log10(PD2),'LineStyle','-','LineWidth',1.5,'Color',[0.8 0.8 1]);
plot(FD3,10*log10(PD3),'LineStyle',':','LineWidth',1.5,'Color',[0.8 0.8 1]);
plot(FD4,10*log10(PD4),'LineStyle','-','LineWidth',1.5,'Color',[0.8 0.8 1]);
plot(FD5,10*log10(PD5),'LineStyle',':','LineWidth',1.5,'Color',[0.8 0.8 1]);
plot(FD6,10*log10(PD6),'LineStyle','-','LineWidth',1.5,'Color',[0.8 0.8 1]);


plot(FO1,10*log10(PCO1),'r:','LineWidth',1.5);
hold on
plot(FO2,10*log10(PCO2),'r','LineWidth',1.5);
plot(FO3,10*log10(PCO3),'r:','LineWidth',1.5);
plot(FO4,10*log10(PCO4),'r','LineWidth',1.5);
plot(FO5,10*log10(PCO5),'r:','LineWidth',1.5);
plot(FO6,10*log10(PCO6),'r-','LineWidth',1.5);

plot(FD1,10*log10(PCD1),'b:','LineWidth',1.5);
plot(FD2,10*log10(PCD2),'b','LineWidth',1.5);
plot(FD3,10*log10(PCD3),'b:','LineWidth',1.5);
plot(FD4,10*log10(PCD4),'b','LineWidth',1.5);
plot(FD5,10*log10(PCD5),'b:','LineWidth',1.5);
plot(FD6,10*log10(PCD6),'b-','LineWidth',1.5);



%Reduktion:
%[oxy]
percmayer=(((mean(PO2)-mean(PCO2))/mean(PO2))*100);
percresp=(((mean(PO4)-mean(PCO4))/mean(PO4))*100);
percpuls=(((mean(PO6)-mean(PCO6))/mean(PO6))*100);
%Stability:
stability = (((mean(PotherDirty)-mean(PotherClean))/mean(PotherDirty))*100);

%[deoxy]
percdmayer=(((mean(PD2)-mean(PCD2))/mean(PD2))*100);
percdresp=(((mean(PD4)-mean(PCD4))/mean(PD4))*100);
percdpuls=(((mean(PD6)-mean(PCD6))/mean(PD6))*100);

%Stability:
dstability = (((mean(PotherdDirty)-mean(PotherdClean))/mean(PotherdDirty))*100);



%%%%%%neuer ansatz%%%%%%
Oxy_raw_neu=mean(PotherDirty)/(mean(PO2)+mean(PO4)+mean(PO6));
Oxy_clean_neu=mean(PotherClean)/(mean(PCO2)+mean(PCO4)+mean(PCO6));
Oxy_improvement=((Oxy_clean_neu/Oxy_raw_neu)-1)*100;

Deoxy_raw_neu=mean(PotherdDirty)/(mean(PD2)+mean(PD4)+mean(PD6));
Deoxy_clean_neu=mean(PotherdClean)/(mean(PCD2)+mean(PCD4)+mean(PCD6));
Deoxy_improvement=((Deoxy_clean_neu/Deoxy_raw_neu)-1)*100;
%%%%%%/neuer ansatz%%%%%%


% return
%Mayer
%[oxy]
one_Pw_LF=diff(PO2);
two_Pw_LF=diff(one_Pw_LF);

[peakidx_mayer]=findpeak(PO2, one_Pw_LF, two_Pw_LF);

disp(' ')
disp('Peak Mayer (EF): ')
FPeakMayer=FO2(peakidx_mayer)

plot(FO2(peakidx_mayer),10*log10(PO2(peakidx_mayer)),'ko');
%[deoxy]
one_Pw_LF=diff(PD2);
two_Pw_LF=diff(one_Pw_LF);

[peakidx_dmayer]=findpeak(PD2, one_Pw_LF, two_Pw_LF);

FPeakdMayer=FO2(peakidx_dmayer);

plot(FD2(peakidx_dmayer),10*log10(PD2(peakidx_dmayer)),'ko');



%Resp
%[oxy]
one_Pw_LF=diff(PO4);
two_Pw_LF=diff(one_Pw_LF);

[peakidx_resp]=findpeak(PO4, one_Pw_LF, two_Pw_LF);

disp(' ')
disp('Peak Resp (EF): ')
FPeakresp=FO4(peakidx_resp)

plot(FO4(peakidx_resp),10*log10(PO4(peakidx_resp)),'ko');

%[oxy]
one_Pw_LF=diff(PD4);
two_Pw_LF=diff(one_Pw_LF);

[peakidx_dresp]=findpeak(PD4, one_Pw_LF, two_Pw_LF);

FPeakdresp=FD4(peakidx_dresp);

plot(FD4(peakidx_dresp),10*log10(PD4(peakidx_dresp)),'ko');

%Puls
%[oxy]
one_Pw_LF=diff(PO6);
two_Pw_LF=diff(one_Pw_LF);

[peakidx_puls]=findpeak(PO6, one_Pw_LF, two_Pw_LF);

disp(' ')
disp('Peak Puls (EF): ')
FPeakpuls=FO6(peakidx_puls)

plot(FO6(peakidx_puls),10*log10(PO6(peakidx_puls)),'ko');

%[deoxy]
one_Pw_LF=diff(PD6);
two_Pw_LF=diff(one_Pw_LF);

[peakidx_dpuls]=findpeak(PD6, one_Pw_LF, two_Pw_LF);


FPeakdpuls=FD6(peakidx_dpuls);

plot(FD6(peakidx_dpuls),10*log10(PD6(peakidx_dpuls)),'ko');

%Für signifikanzberechnzung:

mayermeanoxyschdirty=[];
mayermeanoxyschclean=[];
resprmeanoxyschdirty=[];
respmeanoxyschclean=[];
pulsmeanoxyschdirty=[];
pulsmeanoxyschclean=[];

othermeanoxyschdirty=[];
othermeanoxyschclean=[];

mayermeandeoxyschdirty=[];
mayermeandeoxyschclean=[];
resprmeandeoxyschdirty=[];
respmeandeoxyschclean=[];
pulsmeandeoxyschdirty=[];
pulsmeandeoxyschclean=[];

othermeandeoxyschdirty=[];
othermeandeoxyschclean=[];

    Oxy_raw_neu_ch=[];
    Oxy_clean_neu_ch=[];
    Oxy_improvement_ch=[];
    
    Deoxy_raw_neu_ch=[];
    Deoxy_clean_neu_ch=[];
    Deoxy_improvement_ch=[];

for wheel=1:1:size(NIRx.Data.Spectra.allChraw,3)
    mayermeanoxyschdirty=[mayermeanoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idx2,1,wheel))];
    mayermeanoxyschclean=[mayermeanoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idx2,1,wheel))];
    resprmeanoxyschdirty=[resprmeanoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idx4,1,wheel))];
    respmeanoxyschclean=[respmeanoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idx4,1,wheel))];
    pulsmeanoxyschdirty=[pulsmeanoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idx6,1,wheel))];
    pulsmeanoxyschclean=[pulsmeanoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idx6,1,wheel))];
    
    othermeanoxyschdirty=[othermeanoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idxOther,1,wheel))];
    othermeanoxyschclean=[othermeanoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idxOther,1,wheel))];

    mayermeandeoxyschdirty=[mayermeandeoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idx2,2,wheel))];
    mayermeandeoxyschclean=[mayermeandeoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idx2,2,wheel))];
    resprmeandeoxyschdirty=[resprmeandeoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idx4,2,wheel))];
    respmeandeoxyschclean=[respmeandeoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idx4,2,wheel))];
    pulsmeandeoxyschdirty=[pulsmeandeoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idx6,2,wheel))];
    pulsmeandeoxyschclean=[pulsmeandeoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idx6,2,wheel))];
    
    othermeandeoxyschdirty=[othermeandeoxyschdirty, mean(NIRx.Data.Spectra.allChraw(idxOther,2,wheel))];
    othermeandeoxyschclean=[othermeandeoxyschclean, mean(NIRx.Data.Spectra.allChcleaned(idxOther,2,wheel))];
    
    
    %%%%%neuer ansatz%%%%%%
 Oxy_raw_neu_ch= [Oxy_raw_neu_ch, mean(NIRx.Data.Spectra.allChraw(idxOther,1,wheel))/(mean(NIRx.Data.Spectra.allChraw(idx2,1,wheel))+mean(NIRx.Data.Spectra.allChraw(idx4,1,wheel))+ mean(NIRx.Data.Spectra.allChraw(idx6,1,wheel)))];
 Oxy_clean_neu_ch=[Oxy_clean_neu_ch, mean(NIRx.Data.Spectra.allChcleaned(idxOther,1,wheel))/(mean(NIRx.Data.Spectra.allChcleaned(idx2,1,wheel))+mean(NIRx.Data.Spectra.allChcleaned(idx4,1,wheel))+mean(NIRx.Data.Spectra.allChcleaned(idx6,1,wheel)))];
 Oxy_improvement_ch=[Oxy_improvement_ch,((Oxy_clean_neu_ch(end)/Oxy_raw_neu_ch(end))-1)*100];

 
 Deoxy_raw_neu_ch= [Deoxy_raw_neu_ch, mean(NIRx.Data.Spectra.allChraw(idxOther,1,wheel))/(mean(NIRx.Data.Spectra.allChraw(idx2,1,wheel))+mean(NIRx.Data.Spectra.allChraw(idx4,1,wheel))+ mean(NIRx.Data.Spectra.allChraw(idx6,1,wheel)))];
 Deoxy_clean_neu_ch=[Deoxy_clean_neu_ch, mean(NIRx.Data.Spectra.allChcleaned(idxOther,1,wheel))/(mean(NIRx.Data.Spectra.allChcleaned(idx2,1,wheel))+mean(NIRx.Data.Spectra.allChcleaned(idx4,1,wheel))+mean(NIRx.Data.Spectra.allChcleaned(idx6,1,wheel)))];
 Deoxy_improvement_ch=[Deoxy_improvement_ch,((Deoxy_clean_neu_ch(end)/Deoxy_raw_neu_ch(end))-1)*100];
end

Alpha=0.01;

[hmayer,pmayer] = ttest(mayermeanoxyschdirty,mayermeanoxyschclean,Alpha,'both');
[hresp,presp] = ttest(resprmeanoxyschdirty,respmeanoxyschclean,Alpha,'both');
[hpuls,ppuls] = ttest(pulsmeanoxyschdirty,pulsmeanoxyschclean,Alpha,'both');

[hother,pother] = ttest(othermeanoxyschdirty,othermeanoxyschclean,Alpha,'both');

[hdemayer,pdemayer] = ttest(mayermeandeoxyschdirty,mayermeandeoxyschclean,Alpha,'both');
[hderesp,pderesp] = ttest(resprmeandeoxyschdirty,respmeandeoxyschclean,Alpha,'both');
[hdepuls,pdepuls] = ttest(pulsmeandeoxyschdirty,pulsmeandeoxyschclean,Alpha,'both');

[hdeother,pdeother] = ttest(othermeandeoxyschdirty,othermeandeoxyschclean,Alpha,'both');


text(Mayer(1),10*log10(PO1(1)),['Mayer:  ','EF_M_a_y_e_r = ',num2str(FPeakMayer),' Hz, ', 'Reduction = ',num2str(percmayer), '%, p = ',num2str(pmayer)],'FontSize',12,'FontWeight','bold');
text(Resp(1),10*log10(PO3(1)),['Resp:  ','EF_r_e_s_p = ',num2str(FPeakresp),' Hz, ', 'Reduction = ',num2str(percresp), '%, p = ',num2str(presp)],'FontSize',12,'FontWeight','bold');
text(Puls(1),10*log10(PO6(1)),['Puls:  ','EF_p_u_l_s = ',num2str(FPeakpuls),' Hz, ', 'Reduction = ',num2str(percpuls), '%, p = ',num2str(ppuls)],'FontSize',12,'FontWeight','bold');
text(Resp(2),10*log10(PO4(end))+2,['Stability:  ', 'Reduction = ',num2str(stability), '%, p = ',num2str(pother)],'FontSize',12,'FontWeight','bold');

ylabel('Power spectrum ','FontSize',16,'FontWeight','bold')
xlabel('f (Hz)','FontSize',16,'FontWeight','bold')

title([NIRx.settings.Subj, '   Spectrum [Oxy-Hb] und [Deoxy-Hb]; SNR Improvement O:',num2str(Oxy_improvement),'% D:',num2str(Deoxy_improvement),'%'],'FontSize',12,'FontWeight','demi','Interpreter','none')



%Results
%[Oxy]
NIRx.Data.Spectra.Results.Oxy.FPMayer=FPeakMayer;
NIRx.Data.Spectra.Results.Oxy.FPResp=FPeakresp;
NIRx.Data.Spectra.Results.Oxy.FPPuls=FPeakpuls;
NIRx.Data.Spectra.Results.Oxy.RedMayer=percmayer;
NIRx.Data.Spectra.Results.Oxy.RedResp=percresp;
NIRx.Data.Spectra.Results.Oxy.RedPuls=percpuls;
NIRx.Data.Spectra.Results.Oxy.RedStability=stability;
NIRx.Data.Spectra.Results.Oxy.meanSNRImprovement=Oxy_improvement;
NIRx.Data.Spectra.Results.Oxy.SNRImprovement=Oxy_improvement_ch;
NIRx.Data.Spectra.Results.Oxy.pMayer=pmayer;
NIRx.Data.Spectra.Results.Oxy.pResp=presp;
NIRx.Data.Spectra.Results.Oxy.pPuls=ppuls;
NIRx.Data.Spectra.Results.Oxy.pStability=pother;
%[Deoxy]
NIRx.Data.Spectra.Results.Deoxy.FPMayer=FPeakdMayer;
NIRx.Data.Spectra.Results.Deoxy.FPResp=FPeakdresp;
NIRx.Data.Spectra.Results.Deoxy.FPPuls=FPeakdpuls;
NIRx.Data.Spectra.Results.Deoxy.RedMayer=percdmayer;
NIRx.Data.Spectra.Results.Deoxy.RedResp=percdresp;
NIRx.Data.Spectra.Results.Deoxy.RedPuls=percdpuls;
NIRx.Data.Spectra.Results.Deoxy.RedStability=dstability;
NIRx.Data.Spectra.Results.Deoxy.meanSNRImprovement=Deoxy_improvement;
NIRx.Data.Spectra.Results.Deoxy.SNRImprovement=Deoxy_improvement_ch;
NIRx.Data.Spectra.Results.Deoxy.pMayer=pdemayer;
NIRx.Data.Spectra.Results.Deoxy.pResp=pderesp;
NIRx.Data.Spectra.Results.Deoxy.pPuls=pdepuls;
NIRx.Data.Spectra.Results.Deoxy.pStability=pdeother;

NIRx=NIRx;
end
    
    