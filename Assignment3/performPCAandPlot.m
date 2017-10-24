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
    labels = {'Gyro-X NWAMP', 'Gyro-Y NWAMP', 'Gyro-Z NWAMP', 'Orientation-X Variance', 'Orientation-Y Variance', 'Orientation-Z Variance', 'Orientation-w Variance'};
    sizeEig =size(eigenVectors);
    for i=1:sizeEig(2)
        bar(eigenVectors(:,i)');
        set(gca,'xticklabel',labels);
        imageName = strcat('Task3PlotImages/','EigenVect',num2str(i),'.png');
        saveas(gcf, imageName);
    end
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

        
    