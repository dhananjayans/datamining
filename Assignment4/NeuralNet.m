function [precision,recall,f1,auc] = NeuralNet(train,test)

traindata = train(:,1:end-1);
trainlabel = train(:,end);

disp("Begin training");
disp("Creating a 2 layered neural net with one hidden layer");
net = feedforwardnet(10);
net = configure(net,traindata);
res = train(net,traindata);
disp("Training done");

disp("Being test");
testdata = test(:,1:end-1);
actuallabel = test(:,end);
[predictedlabel,scores] = predict(model,testdata);
[precision,recall,f1,auc] = calculateAccuracy(actuallabel,predictedlabel,scores);
disp("End test");
end
