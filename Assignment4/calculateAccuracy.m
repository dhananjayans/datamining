function[Precision, Recall, F1, AUC] = calculateAccuracy(actualClasses, PredictedClasses, scoresMat)
    confusionMatrix = confusionmat(actualClasses', PredictedClasses');
    scores = scoresMat(:,2);
    TP = confusionMatrix(2,2);
    FP = confusionMatrix(1,2);
    TN = confusionMatrix(1,1);
    FN = confusionMatrix(2,1);
    Precision = TP/(TP+FP);
    Recall = TP/(TP+FN);
    F1 = 2*Recall*Precision/(Precision+Recall);
    TPR = Recall;
    FPR = FP/(FP+TN);
    [X,Y,T,AUC] = perfcurve(actualClasses', scores',1);
    plot(X,Y);
    xlabel('False positive rate');
    ylabel('True positive rate');
    title('ROC Curve');
end