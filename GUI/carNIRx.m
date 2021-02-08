function [oxy_signal, deoxy_signal]=carNIRx(oxy_signal, deoxy_signal, NIRx, settings)

   ME=[];
    
   try
       OptodeFailure=settings.optodeFail.cellArray;
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

    probesetValue = 0;

    switch settings.probeset.value
        case 1
            probesetValue = 12;
        case 2
            probesetValue = 24;
        case 3
            probesetValue = 38;
        case 4
            probesetValue = 47;
        case 5
            probesetValue = 50;
        case 6
            probesetValue = 99;
        case 7
            probesetValue = 777;
        case 8
            probesetValue = 888;
    end

    for g= 1: length(ReplaceCh) 
        if ReplaceCh(g) <= probesetValue
          ReplaceCh_=[ReplaceCh_, ReplaceCh(g)];
        end
    end

    ReplaceCh=ReplaceCh_;


    CAR_ch=[1:1:size(oxy_signal,2)];
    CAR_ch(ReplaceCh)=[];

    %%%%%%%%%
    %Exclch%%
    %%%%%%%%%

    CAR_ch(find(settings.channels.exclude == 1))=[];

    mean_oxy_signal=mean(oxy_signal(:,CAR_ch),2);
    mean_deoxy_signal=mean(deoxy_signal(:,CAR_ch),2);
    for tt=1:size(oxy_signal,2)
    oxy_signal(:,tt)=oxy_signal(:,tt)-mean_oxy_signal(:,1);
    deoxy_signal(:,tt)=deoxy_signal(:,tt)-mean_deoxy_signal(:,1);
    end

end