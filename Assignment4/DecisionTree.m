function [precision,recall,f1,auc] = DecisionTree(train,test)

traindata = train(:,1:end-1);
trainlabel = train(:,end);

disp("DT Begin training");
tree = fitctree(traindata,trainlabel);
disp("DT Training done");

disp("Being test");
testdata = test(:,1:end-1);
actuallabel = test(:,end);
[predictedlabel,scores,nodes,cnum] = predict(tree,testdata);
[precision,recall,f1,auc] = calculateAccuracy(actuallabel,predictedlabel,scores);
disp("DT End test");
end
