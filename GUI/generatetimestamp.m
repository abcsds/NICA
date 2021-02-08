function timeStamp = generatetimestamp

format shortg
c = clock;

timeStamp = [num2str(c(1)) '-' num2str(c(2)) '-' num2str(c(3)) '_' num2str(c(4)) '-' num2str(c(5)) '-' ...
    num2str(round(c(6)))];
