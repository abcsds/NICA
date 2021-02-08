%find peak

function [EF_peak]=findpeak(Pw_LF, one_Pw_LF, two_Pw_LF)

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
    aaa=1;
end

amount=Pw_LF(aaa(1));
EF_peak=aaa(1);
for iii=2:1:length(aaa)
    if Pw_LF(aaa(iii))>=amount
        EF_peak=aaa(iii);
        amount=Pw_LF(EF_peak);
    end
end