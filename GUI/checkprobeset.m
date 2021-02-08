function NIRx = checkprobeset(NIRx,probesetValue)

    switch probesetValue
        case 1  % 12
            channels = 12;
            NIRx.hdr.Sources=5;
            NIRx.hdr.Detectors=4;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:channels);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:channels);
        case 2  % 24, reduktion des 38er adapt filt
            channels = 24;
            NIRx.hdr.Sources=9;
            NIRx.hdr.Detectors=24;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:channels);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:channels);
        case 3  % 38
            channels = 38;
            NIRx.hdr.Sources=9;
            NIRx.hdr.Detectors=24;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:channels);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:channels);
        case 4  % 47 
            channels = 47;
            NIRx.hdr.Sources=16;
            NIRx.hdr.Detectors=15;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:channels);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:channels);
        case 5  % 50, PSEUDO CASE
            channels = 50;
            NIRx.hdr.Sources=16;
            NIRx.hdr.Detectors=15;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:channels);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:channels);
        case 6  % 99, Laboratory new
            NIRx.hdr.Sources=9;
            NIRx.hdr.Detectors=8;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:24);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:24);
        case 7  %777, sportsfNIRS_old  
            NIRx.hdr.Sources=14;
            NIRx.hdr.Detectors=13;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:42);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:42);
    %         % If AFChnUse == 1
    %         NIRx.hdr.Sources=14;
    %         NIRx.hdr.Detectors=23;
    %         NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    %         NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
    %         NIRx.Data.wl760=NIRx.Data.wl760(:,1:52);
    %         NIRx.Data.wl830=NIRx.Data.wl830(:,1:52);
        case 8  %888, neu fNIRS_sports
            NIRx.hdr.Sources=16;
            NIRx.hdr.Detectors=22;
            NIRx.hdr.Gains{1,1}=NIRx.hdr.Gains{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.hdr.Mask{1,1}=NIRx.hdr.Mask{1,1}(1:NIRx.hdr.Sources,1:NIRx.hdr.Detectors);
            NIRx.Data.wl760=NIRx.Data.wl760(:,1:61);
            NIRx.Data.wl830=NIRx.Data.wl830(:,1:61);
    end
    
end
