function[] = generateHistograms()
    actionType = 'Noneating';
    load('NoneatingActionCSV.mat');
    noOfSensorFeatures = 18;
    NoneatingActionCSV = NoneatingActionCSV(:,3:end);
    noOfRowsAndCols = size(NoneatingActionCSV);
    disp(noOfRowsAndCols);
    consolidatedMat = NaN(noOfSensorFeatures, 1);
    i=1;
    while i<noOfRowsAndCols(1)
        consolidatedMat = [consolidatedMat'; NoneatingActionCSV(i:i+noOfSensorFeatures-1,:)']';
        i = i+noOfSensorFeatures;
    end
    consolidatedMat = consolidatedMat(:,2:end);
%     disp((consolidatedMat));
%     save('consolidatedMatNonEating.mat', 'consolidatedMat');
    for i=1:noOfSensorFeatures
        imageName = strcat(actionType,'_',num2str(i),'.png');
        histogram(consolidatedMat(i,:));
        saveas(gcf, imageName);
    end
    
    
    

    