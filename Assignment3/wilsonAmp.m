function[] =  wilsonAmp(thresholdPercent,fileEatingNon)
    load(fileEatingNon);
    wampMat = zeros(18,40);
    
    for i = 1:18
        for j = 1:40
            tempMat = consolidatedMat(i,(((j-1)*998)+1):(j*998));
            tempMat(isnan(tempMat)) = [];
            rmsMean = rms(tempMat);
            threshold = rmsMean * thresholdPercent;
            wamp = 0;
            for k=2:length(tempMat)
                wampTemp = abs(tempMat(k)-tempMat(k-1));
                if wampTemp>threshold
                    wamp = wamp+1;
                end
            end
            wampMat(i,j)=wamp;
        end
    end
    if strcmp(fileEatingNon,"consolidatedMatEating.mat")==1
        fileName = 'Eating';
    else
        fileName = 'NonEating';
    end
    fileName = strcat("wilsonAmpData/",fileName,num2str(thresholdPercent),".mat");
    save(fileName,'wampMat');
end