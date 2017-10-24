function[] = extractFeaturesAndPlot(eatingMatrix, nonEatingMatrix)
    eatingMatrix = eatingMatrix(:,3:end);
    nonEatingMatrix = nonEatingMatrix(:,3:end);
    noOfFeatures = 18;
    [meanEatingMat, varianceEatingMat, rmsEatingMat, entropyEatingMat, wilsonEatingMat, vCrossEatingMat] = getFeatureValues(eatingMatrix);
    [meanNonEatingMat, varianceNonEatingMat, rmsNonEatingMat, entropyNonEatingMat, wilsonNonEatingMat, vCrossNonEatingMat] = getFeatureValues(nonEatingMatrix);
    for i=1:noOfFeatures
        displayBoxPlot(meanEatingMat(i,:), meanNonEatingMat(i,:), i, 'Mean');
        displayBoxPlot(varianceEatingMat(i,:), varianceNonEatingMat(i,:), i, 'Variance');
        displayBoxPlot(rmsEatingMat(i,:), rmsNonEatingMat(i,:), i, 'RMS');
        displayBoxPlot(entropyEatingMat(i,:), entropyNonEatingMat(i,:), i, 'Entropy');
        displayBoxPlot(wilsonEatingMat(i,:), wilsonNonEatingMat(i,:), i, 'Wilson');
        displayBoxPlot(vCrossEatingMat(i,:), vCrossNonEatingMat(i,:), i, 'ValueCrossing');
    end
end

function[] = displayBoxPlot(eatingRow, nonEatingRow, featureIndex, metricType)
    featureName = getFeatureName(featureIndex);
    boxplot([eatingRow', nonEatingRow'], {'Eating','Non-Eating'});
    title(metricType);
    %title(featureName);
    
    imageName = strcat('BoxPlotImages/',featureName{1},'_',metricType,'.png');
    saveas(gcf, imageName);
    %pause(1);
end

function[featureName] = getFeatureName(index)
   featureNames = [{'Orientation X'}, {'Orientation Y'}, {'Orientation Z'}, {'Orientation W'}, {'Accelerometer X'}, {'Accelerometer Y'}, {'Accelerometer Z'}, {'Gyroscope X'}, {'Gyroscope Y'}, {'Gyroscope Z'}, {'EMG 1'}, {'EMG 2'}, {'EMG 3'}, {'EMG 4'}, {'EMG 5'}, {'EMG 6'}, {'EMG 7'}, {'EMG 8'}]; 
   featureName  = featureNames(index);
end