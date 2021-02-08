function [head_oxy, head_deoxy, head_oxy_std, head_deoxy_std]=Optodenfehler_NIRx(head_oxy, head_deoxy, head_oxy_std, head_deoxy_std, NIRx, D)

if NIRx.settings.OptodeFailure
       try
           OptodeFailure=D{1,1}.OptodeFailure;
           OFInk=1;
       catch MEOF
           OFInk=0;
       end

    if OFInk
        if ~isempty(OptodeFailure)
            fprintf('Optode Failure activated: ch ')
            for k = 1 : length(OptodeFailure)
                ReplaceCh = OptodeFailure{k}{1};
                if ReplaceCh <= NIRx.settings.probeset
                    fprintf('%2d ',ReplaceCh)
                    SurroundCh = OptodeFailure{k}{2};
                    tmp1=[];tmp2=[];tmp3=[];tmp4=[];
                    for l = 1 : length(SurroundCh)
                        tmp1(l,:)=head_oxy(:,SurroundCh(l));
                        tmp2(l,:)=head_deoxy(:,SurroundCh(l));
                        tmp3(l,:)=head_oxy_std(:,SurroundCh(l));
                        tmp4(l,:)=head_deoxy_std(:,SurroundCh(l));
                    end
                    head_oxy(:,ReplaceCh) = mean(tmp1,1);
                    head_deoxy(:,ReplaceCh) = mean(tmp2,1);
                    head_oxy_std(:,ReplaceCh) = mean(tmp3,1);
                    head_deoxy_std(:,ReplaceCh) = mean(tmp4,1);
                end
            end
            disp(' ')
        end
    end
end
end