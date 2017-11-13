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
    transformed = trainingData(:,2:8)*eigenVectors;
    transformed = transformed(:,1:3);
    scatter3(transformed(1:1500,1),transformed(1:1500,2),transformed(1:1500,3),5,[0,0,1]);
    hold on;
    scatter3(transformed(1501:3000,1),transformed(1501:3000,2),transformed(1501:3000,3),5,[1,0,0]);
    title('Transformed Data using eigen vectors');
    pause(5);
    hold off;
    
%     Plot
    labels = {'GXW', 'GYW', 'GZW', 'OXV', 'OYV', 'OZV', 'OwV'};
%    sizeEig =size(eigenVectors);
%    for i=1:sizeEig(2)
%        bar(eigenVectors(:,i)');
%        set(gca,'xticklabel',labels);
%        imageName = strcat('Task3PlotImages/','EigenVect',num2str(i),'.png');
%        saveas(gcf, imageName);
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

        
    