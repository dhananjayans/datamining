function[trainingDataSet, testDataSet] = prepareTrainingAndTestData(eatingMatrix, nonEatingMatrix)
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
    dataTable = [sampleIDArr', [gyroXVals_Eating,gyroXVals_NonEating]', [gyroYVals_Eating,gyroYVals_NonEating]', [gyroZVals_Eating, gyroZVals_NonEating]', [orientationX_Eating, orientationX_NonEating]', [orientationY_Eating, orientationY_NonEating]', [orientationZ_Eating, orientationZ_NonEating]', [orientationW_Eating, orientationW_NonEating]', classLabels']; 
%     save('dataTable', 'dataTable');
    [trainingDataSet, testDataSet] = sampleDataSet(dataTable);
end

function [trainingSubset, testSubset] = sampleDataSet(dataMatrix)
    trainingDataPercent = 0.6;
    dataSetSize = size(dataMatrix);
    noOfRows = dataSetSize(1);
    randomOrdering = randperm(noOfRows);
    trainingSize = round(trainingDataPercent*noOfRows);
    trainingSubset = dataMatrix(randomOrdering(1:trainingSize),:);
    testSubset = dataMatrix(randomOrdering(trainingSize+1:end),:);
end

function[mapping] = getFeatureNameMappings()
   featureNames = {'Orientation X', 'Orientation Y', 'Orientation Z', 'Orientation W', 'Accelerometer X', 'Accelerometer Y', 'Accelerometer Z', 'Gyroscope X', 'Gyroscope Y', 'Gyroscope Z', 'EMG 1', 'EMG 2', 'EMG 3', 'EMG 4', 'EMG 5', 'EMG 6', 'EMG 7', 'EMG 8'}; 
   featureIndices = 1:18;
   mapping = containers.Map(featureNames, featureIndices);
end

% function[Precision, Recall, F1, AUC] = calculateAccuracy(actualClasses, PredictedClasses, scoresMat)
%     confusionMatrix = confusionmat(actualClasses', PredictedClasses');
%     scores = scoresMat(:,2);
%     TP = confusionMatrix(2,2);
%     FP = confusionMatrix(1,2);
%     TN = confusionMatrix(1,1);
%     FN = confusionMatrix(2,1);
%     Precision = TP/(TP+FP);
%     Recall = TP/(TP+FN);
%     F1 = 2*Recall*Precision/(Precision+Recall);
%     TPR = Recall;
%     FPR = FP/(FP+TN);
%     [X,Y,T,AUC] = perfcurve(actualClasses', scores',1);
%     plot(X,Y);
%     xlabel('False positive rate');
%     ylabel('True positive rate');
%     title('ROC Curve');
% end