function[average, variance, rmsValue, entropyVal, wilsonAmp] = getStatistics(row)
    average = calculateMean(row);
    variance = calculateVariance(row);
    rmsValue = calculateRMS(row);
    entropyVal = calculateEntropy(row);
    wilsonAmp = calculateWilsonAmp(row);
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
    row(isnan(row)) = [];
    rmsMean = rms(row);
    threshold = 0.35 * rmsMean;
    for k = 2:length(row)
        wampTemp = abs(row(k)-row(k-1));
        if wampTemp>threshold
            wilsonAmp = wilsonAmp+1;
        end
    end
end