function[average, variance, rmsValue, entropyVal, wilsonAmp, valCrossing] = getStatistics(row)
    row(isnan(row)) = [];
    rowSize = size(row);
    if rowSize(2) >= 1
        average     = calculateMean(row);
        variance    = calculateVariance(row);
        rmsValue    = calculateRMS(row);
        entropyVal  = calculateEntropy(row);
        wilsonAmp   = calculateWilsonAmp(row);
        valCrossing = vCrossing(row);
    else
        average     = NaN;
        variance    = NaN;
        rmsValue    = NaN;
        entropyVal  = NaN;
        wilsonAmp   = NaN;
        valCrossing = NaN;
    end
end

function [average] = calculateMean(row)
    average = mean(row);
end

function [variance] = calculateVariance(row)
    variance = var(row);
end

function [rmsValue] = calculateRMS(row)
    rmsValue = rms(row);
end

function [entropyVal] = calculateEntropy(row)
    entropyVal = entropy(row);
end

function [wilsonAmp] = calculateWilsonAmp(row)
    wilsonAmp = 0;
    % row(isnan(row)) = [];
    rmsMean = rms(row);
    lengthOfRow = size(row);
    threshold = 0.35 * rmsMean;
    for k = 2:length(row)
        wampTemp = abs(row(k)-row(k-1));
        if wampTemp>threshold
            wilsonAmp = wilsonAmp+1;
        end
    end
    wilsonAmp = wilsonAmp/lengthOfRow(2);
end

function [noOfTimes] = vCrossing(row)
    noOfTimes = 0;
    cutOffValue = 0;
    lengthOfRow = size(row);
    for k = 2:length(row)
        if min(row(k),row(k-1)) <= cutOffValue && max(row(k),row(k-1)) > cutOffValue
            noOfTimes = noOfTimes+1;
        end
    end
    noOfTimes = noOfTimes/lengthOfRow(2);
end
    