function [precision,recall,f1,auc] = NeuralNet(trainData,testData)
    trainFeatures = trainData(:,1:end-1);
    trainlabel = trainData(:,end);

    disp('Begin training');
    disp('Creating a 2 layered neural net with one hidden layer');
    net = feedforwardnet(10);
    %net = configure(net,traindata);
%     disp(trainFeatures');
%     disp(trainlabel');
    [net,tr] = train(net,trainFeatures',trainlabel');
    disp('Training done');

    disp('Being test');
    testdata = testData(:,1:end-1);
    actuallabel = testData(:,end);
    predictedOutputs = net(testdata');
    predictedClasses = predictClasses(predictedOutputs);
    scores = buildScoresMat(predictedOutputs);
%     disp(net(testdata'));
%     [predictedlabel,scores] = predict(net, testdata');
    [precision,recall,f1,auc] = calculateAccuracy(actuallabel,predictedClasses',scores');
    disp('End test');
end

function [predictedClasses] = predictClasses(scores)
    nowOfExamples = size(scores);
    predictedClasses = zeros(1, nowOfExamples(2));
    for i=1:nowOfExamples(2)
        if scores(i) >= 0.5
            predictedClasses(i) = 1;
        end
    end
end

function [scoresMat] = buildScoresMat(scoresRow)
    numofScores = size(scoresRow);
    scoresMat = zeros(1,numofScores(2));
    for i=1:numofScores(2)
        scoresMat(i) = 1 - scoresRow(i);
    end
    scoresMat = [scoresMat; scoresRow];
end