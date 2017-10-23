function[average, variance, rmsValue, entropyVal] = getStatistics(row)
    average = calculateMean(row);
    variance = calculateVariance(row);
    rmsValue = calculateRMS(row);
    entropyVal = calculateEntropy(row);
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
