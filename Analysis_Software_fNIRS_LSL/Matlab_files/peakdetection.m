function [f_peak default] = peakdetection(signal, f, f_bereich) 

default = 0;
idx1 = find(f >= f_bereich(1));
idx2 = find(f <= f_bereich(2));

f_LF = f(idx1(1):idx2(end));
Pw_LF = signal(idx1(1):idx2(end));

Pw_LF_alt=Pw_LF;
one_Pw_LF=diff(Pw_LF);
two_Pw_LF=diff(one_Pw_LF);


aa=[];
for i=2:1:length(one_Pw_LF)-1
   if one_Pw_LF(i-1)<=0
       if one_Pw_LF(i+1)>=0
           aa=[aa,i];
       end
   end
   if one_Pw_LF(i-1)>=0
       if one_Pw_LF(i+1)<=0
           aa=[aa,i];
       end
   end
end

aaa=[];

for ii=1:1:length(aa)
   if two_Pw_LF(aa(ii))<=0
       aaa=[aaa,aa(ii)];
   end
end

if size(aaa,1)==0
%    aaa=1;
   
   default = f_LF-0.1;
   [mini aaa] = min(abs(default));
   default = 1;
end

amount=Pw_LF(aaa(1));
EF_peak=aaa(1);
for iii=2:1:length(aaa)
   if Pw_LF(aaa(iii))>=amount
       EF_peak=aaa(iii);
       amount=Pw_LF(EF_peak);
   end
end

f_peak = f_LF(EF_peak);
