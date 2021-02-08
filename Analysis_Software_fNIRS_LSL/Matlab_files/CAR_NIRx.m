function [oxy_signal, deoxy_signal]=CAR_NIRx(oxy_signal, deoxy_signal, NIRx, D)
ME=[];
    if NIRx.settings.CAR
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

        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%Überprüfung ob alle Kanäle verwendet werden%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for g= 1: length(ReplaceCh) 
            if ReplaceCh(g) <= NIRx.settings.probeset
              ReplaceCh_=[ReplaceCh_, ReplaceCh(g)];
            end
        end
        
        ReplaceCh=ReplaceCh_;


        CAR_ch=[1:1:size(oxy_signal,2)];
        CAR_ch(ReplaceCh)=[];
        
        %%%%%%%%%
        %Exclch%%
        %%%%%%%%%
        
        CAR_ch(NIRx.settings.ExCh)=[];

        mean_oxy_signal=mean(oxy_signal(:,CAR_ch),2);
        mean_deoxy_signal=mean(deoxy_signal(:,CAR_ch),2);
        for tt=1:size(oxy_signal,2)
        oxy_signal(:,tt)=oxy_signal(:,tt)-mean_oxy_signal(:,1);
        deoxy_signal(:,tt)=deoxy_signal(:,tt)-mean_deoxy_signal(:,1);
        end
    end


end