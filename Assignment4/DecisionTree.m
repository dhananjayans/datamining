function [predictedlabel,scores,nodes,cnum,actuallabel] = DecisionTree(train,test)

traindata = train(:,1:end-1);
trainlabel = train(:,end);

disp("Begin training");
tree = fitctree(traindata,trainlabel);
disp("Training done");

disp("Being test");
testdata = test(:,1:end-1);
actuallabel = test(:,end);
[predictedlabel,scores,nodes,cnum] = predict(tree,testdata);
disp("End test");
end