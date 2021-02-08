function [ges_head_oxy, ges_head_deoxy]=Add_CAR_NIRx(ges_head_oxy, ges_head_deoxy,NIRx,D)

% return
for i=1:1:size(ges_head_oxy,3)
    ME=[];
        try
           OptodeFailure=D{1,1}.OptodeFailure;
           OFInk=1;
       catch ME
           OFInk=0;
       end

    
        CAR_ch_f=[];
        ReplaceCh=[];
        ReplaceCh_=[];
        if OFInk
          for k = 1 : length(OptodeFailure)
            ReplaceCh = [ReplaceCh, OptodeFailure{k}{1}];
          end
        end
        %%%%%%%%%
        %Exclch%%
        %%%%%%%%%
        CAR_ch=[1:1:size(ges_head_oxy,2)];
        CAR_ch(NIRx.settings.ExCh)=[];
        
        mean_ges_head_oxy=mean(ges_head_oxy(:,CAR_ch,i),2);
        mean_ges_head_deoxy=mean(ges_head_deoxy(:,CAR_ch,i),2);
        
        for tt=1:size(ges_head_oxy,2)
        ges_head_oxy(:,tt,i)=ges_head_oxy(:,tt,i)-mean_ges_head_oxy(:,1);
        ges_head_deoxy(:,tt,i)=ges_head_deoxy(:,tt,i)-mean_ges_head_deoxy(:,1);
        end
end
   


end