function[meanMat, varianceMat, rmsMat, entropyMat] = getFeatureValues(actionMatrix)
    noOfRowsAndColumns = size(actionMatrix);
    noOfFeatures = 18;
    noOfSamples  = noOfRowsAndColumns(1)/noOfFeatures;
    
    meanMat     = NaN(noOfFeatures, noOfSamples);
    varianceMat = NaN(noOfFeatures, noOfSamples);
    rmsMat      = NaN(noOfFeatures, noOfSamples);
    entropyMat  = NaN(noOfFeatures, noOfSamples);
    
    for i=1:noOfRowsAndColumns(1)
        featureIndex = mod(i, noOfFeatures);
        sampleIndex  = ceil(i/noOfFeatures);
        
        sample = actionMatrix(i,:);
        [avg, variance, rmsValue, entropyVal]= getStatistics(sample);
        
        meanMat(featureIndex, sampleIndex)      = avg;
        varianceMat(featureIndex, sampleIndex)  = variance;
        rmsMat(featureIndex, sampleIndex)       = rmsValue;
        entropyMat(featureIndex, sampleIndex)   = entropyVal;
        
    end
end
        
        
        