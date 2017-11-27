function [predictedlabel,scores,actuallabel] = SVM(train,test)

traindata = train(:,1:end-1);
trainlabel = train(:,end);

disp("Begin training");
model = fitcsvm(traindata,trainlabel);
disp("Training done");

disp("Being test");
testdata = test(:,1:end-1);
actuallabel = test(:,end);
[predictedlabel,scores] = predict(model,testdata);

disp("End test");
end