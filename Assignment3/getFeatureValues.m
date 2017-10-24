function[meanMat, varianceMat, rmsMat, entropyMat, wilsonMat] = getFeatureValues(actionMatrix)
    noOfRowsAndColumns = size(actionMatrix);
    noOfFeatures = 18;
    noOfSamples  = noOfRowsAndColumns(1)/noOfFeatures;
    
    meanMat     = NaN(noOfFeatures, noOfSamples);
    varianceMat = NaN(noOfFeatures, noOfSamples);
    rmsMat      = NaN(noOfFeatures, noOfSamples);
    entropyMat  = NaN(noOfFeatures, noOfSamples);
    wilsonMat   = NaN(noOfFeatures, noOfSamples);
    
    for i=1:noOfRowsAndColumns(1)
        featureIndex = mod(i, noOfFeatures);
        if featureIndex == 0
            featureIndex = noOfFeatures; 
        end
        sampleIndex  = ceil(i/noOfFeatures);
        
        sample = actionMatrix(i,:);
        [avg, variance, rmsValue, entropyVal, wilsonAmp]= getStatistics(sample);
        meanMat(featureIndex, sampleIndex)      = avg;
        varianceMat(featureIndex, sampleIndex)  = variance;
        rmsMat(featureIndex, sampleIndex)       = rmsValue;
        entropyMat(featureIndex, sampleIndex)   = entropyVal;
        wilsonMat(featureIndex, sampleIndex)    = wilsonAmp;
        
    end
end
        
        
        