function[trainingTable] = prepareTrainingData(eatingMatrix, nonEatingMatrix)
    eatingMatrix = eatingMatrix(1:27000,3:end);
    nonEatingMatrix = nonEatingMatrix(1:27000,3:end);
    noOfSensors = 18;
    [meanEatingMat, varianceEatingMat, rmsEatingMat, entropyEatingMat, wilsonEatingMat, vCrossEatingMat] = getFeatureValues(eatingMatrix);
    [meanNonEatingMat, varianceNonEatingMat, rmsNonEatingMat, entropyNonEatingMat, wilsonNonEatingMat, vCrossNonEatingMat] = getFeatureValues(nonEatingMatrix);
    featureMappings = getFeatureNameMappings();
 
%     Taking Wilson AMP for Gyro
    gyroXVals_Eating = wilsonEatingMat(featureMappings('Gyroscope X'),:);
    gyroYVals_Eating = wilsonEatingMat(featureMappings('Gyroscope Y'),:);
    gyroZVals_Eating = wilsonEatingMat(featureMappings('Gyroscope Z'),:);
    
    gyroXVals_NonEating = wilsonNonEatingMat(featureMappings('Gyroscope X'),:);
    gyroYVals_NonEating = wilsonNonEatingMat(featureMappings('Gyroscope Y'),:);
    gyroZVals_NonEating = wilsonNonEatingMat(featureMappings('Gyroscope Z'),:);
    
%     Taking Variance for Orientation
    orientationX_Eating = varianceEatingMat(featureMappings('Orientation X'),:);
    orientationY_Eating = varianceEatingMat(featureMappings('Orientation Y'),:);
    orientationZ_Eating = varianceEatingMat(featureMappings('Orientation Z'),:);
    orientationW_Eating = varianceEatingMat(featureMappings('Orientation W'),:);
    
    orientationX_NonEating = varianceNonEatingMat(featureMappings('Orientation X'),:);
    orientationY_NonEating = varianceNonEatingMat(featureMappings('Orientation Y'),:);
    orientationZ_NonEating = varianceNonEatingMat(featureMappings('Orientation Z'),:);
    orientationW_NonEating = varianceNonEatingMat(featureMappings('Orientation W'),:);
    
    noOfEatingExamples = size(eatingMatrix);
    noOfEatingExamples = noOfEatingExamples(1)/noOfSensors;
    noOfNonEatingExamples = size(nonEatingMatrix);
    noOfNonEatingExamples = noOfNonEatingExamples(1)/noOfSensors;
    totalNoOfExamples = noOfEatingExamples + noOfNonEatingExamples;
    
    sampleIDArr = 1:totalNoOfExamples;

%   Eating 1 Non-Eating 0
    classLabelsEating = ones(1, noOfEatingExamples);
    classLabelsNonEating = zeros(1, noOfNonEatingExamples);
    classLabels = [classLabelsEating, classLabelsNonEating];
    
%     ID, Gyro-X NWAMP, Gyro-Y NWAMP, Gyro-Z NWAMP, Orientation-X
%     Variance, Orientation-Y Variance, Orientation-Z Variance,
%     Orientation-w Variance, Class labels (1 eating, 0 non eating)
    trainingTable = [sampleIDArr', [gyroXVals_Eating,gyroXVals_NonEating]', [gyroYVals_Eating,gyroYVals_NonEating]', [gyroZVals_Eating, gyroZVals_NonEating]', [orientationX_Eating, orientationX_NonEating]', [orientationY_Eating, orientationY_NonEating]', [orientationZ_Eating, orientationZ_NonEating]', [orientationW_Eating, orientationW_NonEating]', classLabels']; 
    save('trainingTable.mat', 'trainingTable');
    
%   Box plots for Gyro X,Z and Orientation X,Y,Z
    displayBoxPlot(gyroXVals_Eating, gyroXVals_NonEating, 'Gyroscope X using Normalized WAMP');
    displayBoxPlot(gyroZVals_Eating, gyroZVals_NonEating, 'Gyroscope Z using Normalized WAMP');
    
    displayBoxPlot(orientationX_Eating, orientationX_NonEating, 'Orientation X using Variance');
    displayBoxPlot(orientationY_Eating, orientationY_NonEating, 'Orientation Y using Variance');
    displayBoxPlot(orientationZ_Eating, orientationZ_NonEating, 'Orientation Z using Variance');
end

function[] = displayBoxPlot(eatingRow, nonEatingRow, graphLabel)
    boxplot([eatingRow', nonEatingRow'], {'Eating','Non-Eating'});
    title(graphLabel);
    imageName = strcat('Task2PlotImages/',graphLabel,'.png');
    saveas(gcf, imageName);
    pause(3.5);
end

function[mapping] = getFeatureNameMappings()
   featureNames = {'Orientation X', 'Orientation Y', 'Orientation Z', 'Orientation W', 'Accelerometer X', 'Accelerometer Y', 'Accelerometer Z', 'Gyroscope X', 'Gyroscope Y', 'Gyroscope Z', 'EMG 1', 'EMG 2', 'EMG 3', 'EMG 4', 'EMG 5', 'EMG 6', 'EMG 7', 'EMG 8'}; 
   featureIndices = 1:18;
   mapping = containers.Map(featureNames, featureIndices);
end