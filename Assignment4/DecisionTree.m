function [precision,recall,f1,auc] = DecisionTree(trainData,testData,figTitle)
    trainFeatures = trainData(:,2:end-1);
    trainlabel = trainData(:,end);

    disp('DT Begin training');
    tree = fitctree(trainFeatures,trainlabel);
    disp('DT Training done');

    disp('Being test');
    testdata = testData(:,2:end-1);
    actuallabel = testData(:,end);
    [predictedlabel,scores,nodes,cnum] = predict(tree,testdata);
    [precision,recall,f1,auc] = calculateAccuracy(actuallabel,predictedlabel,scores,figTitle);
    disp('DT End test');
end
