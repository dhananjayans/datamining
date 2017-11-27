function [precision,recall,f1,auc] = SVM(train,test)

traindata = train(:,1:end-1);
trainlabel = train(:,end);

disp(" SVM Begin training");
model = fitcsvm(traindata,trainlabel);
disp("SVM Training done");

disp("SVM Being test");
testdata = test(:,1:end-1);
actuallabel = test(:,end);
[predictedlabel,scores] = predict(model,testdata);
[precision,recall,f1,auc] = calculateAccuracy(actuallabel,predictedlabel,scores);
disp("SVM End test");
end
