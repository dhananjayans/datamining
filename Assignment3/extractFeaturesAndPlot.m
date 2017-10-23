function[] = extractFeaturesAndPlot(eatingMatrix, nonEatingMatrix)
    eatingMatrix = eatingMatrix(:,3:end);
    nonEatingMatrix = nonEatingMatrix(:,3:end);
    noOfFeatures = 18;
    [meanEatingMat, varianceEatingMat, rmsEatingMat, entropyEatingMat] = getFeatureValues(eatingMatrix);
    [meanNonEatingMat, varianceNonEatingMat, rmsNonEatingMat, entropyNonEatingMat] = getFeatureValues(nonEatingMatrix);
    for i=1:noOfFeatures
        displayBoxPlot(meanEatingMat(i,:), meanNonEatingMat(i,:), i, 'Mean');
        displayBoxPlot(varianceEatingMat(i,:), varianceNonEatingMat(i,:), i, 'Variance');
        displayBoxPlot(rmsEatingMat(i,:), rmsNonEatingMat(i,:), i, 'RMS');
        displayBoxPlot(entropyEatingMat(i,:), entropyNonEatingMat(i,:), i, 'Entropy');
    end
end

function[] = displayBoxPlot(eatingRow, nonEatingRow, featureIndex, metricType)
    featureName = getFeatureName(featureIndex);
    boxplot(eatingRow', nonEatingRow', {'Eating','Non-Eating'});
    title(featureName);
    imageName = strcat('BoxPlotImages/',featureName,'_',metricType,'.png');
    saveas(gcf, imageName);
end

function[featureName] = getFeatureName(index)
   featureNames = [{'Orientation X'}, {'Orientation Y'}, {'Orientation Z'}, {'Orientation W'}, {'Accelerometer X'}, {'Accelerometer Y'}, {'Accelerometer Z'}, {'Gyroscope X'}, {'Gyroscope Y'}, {'Gyroscope Z'}, {'EMG 1'}, {'EMG 2'}, {'EMG 3'}, {'EMG 4'}, {'EMG 5'}, {'EMG 6'}, {'EMG 7'}, {'EMG 8'}]; 
   featureName  = featureNames(index);
end