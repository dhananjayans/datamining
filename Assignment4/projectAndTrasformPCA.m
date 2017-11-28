function[transformedData] = projectAndTrasformPCA(originalData)
    load('eigenVectors.mat');
    eigenMat = eigenVectors(:,1:3);
    originalFeatureMatrix = originalData(:,2:8);
    classLabels = originalData(:,9);
    exampleIds = originalData(:,1);
    
    reducedFeatureMatrix = originalFeatureMatrix*eigenMat;
    transformedData = horzcat(exampleIds, reducedFeatureMatrix, classLabels);
end