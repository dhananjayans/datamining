function [precision,recall,f1,auc] = SVM(trainData, testData)

    trainFeatures = trainData(:,2:end-1);
    trainlabel = trainData(:,end);

    disp(' SVM Begin training');
    model = fitcsvm(trainFeatures,trainlabel);
    disp('SVM Training done');

    disp('SVM Being test');
    testdata = testData(:,2:end-1);
    actuallabel = testData(:,end);
    [predictedlabel,scores] = predict(model,testdata);
    [precision,recall,f1,auc] = calculateAccuracy(actuallabel,predictedlabel,scores);
    disp('SVM End test');
end
