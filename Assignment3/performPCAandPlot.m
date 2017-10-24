function[] = performPCAandPlot(trainingData)
    subTrain = trainingData(:,2:8);
    classLabels = trainingData(:,9);
    covarianceMat = nancov(subTrain);
    [eigenVectors, eigenValues] = eig(covarianceMat);
    
    disp('Eigen Values are');
    disp(fliplr(diag(eigenValues)'));
    
    disp('Corresponding Eigen Vectors (columnwise) are');
    eigenVectors = fliplr(eigenVectors);
    disp(eigenVectors);
    
%     Plot

%     Select 3 Vectors
    noOfDims = 3;
    reducedEigenVectors = eigenVectors(:,1:noOfDims);
    pcaProjectedData = subTrain * reducedEigenVectors;
    
%     [pcaEig] = pca(subTrain);
%     pcaProjectedData = subTrain*pcaEig;
    
    for i=1:noOfDims
        plotGraphs(pcaProjectedData(:,i), classLabels, i);
    end
end

function[] = plotGraphs(feature, classLabels, vrId)
    noOfEating = sum(classLabels);
    eatingFeatures = feature(1:noOfEating,:);
    nonEatingFeatures = feature(noOfEating+1:end,:);
    boxplot([eatingFeatures, nonEatingFeatures], {'Eating','Non-Eating'});
    title(strcat('Post PCA Feature No. ', num2str(vrId)));
    imageName = strcat('Task3PlotImages/','PCA_Feature1',num2str(vrId),'.png');
    saveas(gcf, imageName);
    pause(1);
end

        
    