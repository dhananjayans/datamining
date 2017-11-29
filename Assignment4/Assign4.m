function [] = Assign4
baseName = 'DataMats/GroupWise/Group_'
valMatrix = zeros(34,12);
secondQuestAnswers = zeros(23,12);
load('EatingActionCSV.mat');
load('NoneatingActionCSV.mat');
trainMat = [];
testMat = [];
interMat = [];
% Call methods group wise
% Store it in matrix
for i = 1:33
    
    if(i<10)
        eatingName = strcat(baseName,'0',num2str(i),'/Eating/Eating.mat');
        nonEatingName = strcat(baseName,'0',num2str(i),'/NonEating/NonEating.mat');
        
    else
        eatingName = strcat(baseName,num2str(i),'/Eating/Eating.mat');
        nonEatingName = strcat(baseName,num2str(i),'/NonEating/NonEating.mat');
    end
    eatingMat = load(eatingName);
    nonEatingMat = load(nonEatingName);
    if i==12
        interMat = [];
    end
    if(i<11)
        interMat = generateFeatureMatrix(eatingMat.result,nonEatingMat.result);
        trainMat = vertcat(trainMat,interMat);
    else
        interMat = generateFeatureMatrix(eatingMat.result,nonEatingMat.result);
        testMat = vertcat(testMat,interMat);
    end
    
    [train,test] = prepareTrainingAndTestData(eatingMat.result,nonEatingMat.result);
    [p,r,f,a] = DecisionTree(train,test, strcat('ROC curve for Decision Tree Phase 1, Group: ', num2str(i)));
    valMatrix(i,1:4) = [p r f a];
    [p,r,f,a] = SVM(train, test, strcat('ROC curve for SVM Phase 1, Group: ', num2str(i)));
    valMatrix(i,5:8) = [p r f a];
    [p,r,f,a] = NeuralNet(train, test, strcat('ROC curve for Neural Network Phase 1, Group: ', num2str(i)));
    valMatrix(i,9:12) = [p r f a];
    disp(valMatrix(i,:));
end


for i = 1:33
    
    if(i<10)
        eatingName = strcat(baseName,'0',num2str(i),'/Eating/Eating.mat');
        nonEatingName = strcat(baseName,'0',num2str(i),'/NonEating/NonEating.mat');
        
    else
        eatingName = strcat(baseName,num2str(i),'/Eating/Eating.mat');
        nonEatingName = strcat(baseName,num2str(i),'/NonEating/NonEating.mat');
    end
    eatingMat = load(eatingName);
    nonEatingMat = load(nonEatingName);
    if i==12
        interMat = [];
    end
    if(i>10)
        interMat = generateFeatureMatrix(eatingMat.result,nonEatingMat.result);
        [p,r,f,a] = DecisionTree(trainMat,interMat, strcat('ROC curve for Decision Tree Phase 2, Group: ', num2str(i)));
        secondQuestAnswers(i-10,1:4) = [p r f a];
        [p,r,f,a] = SVM(trainMat, interMat, strcat('ROC curve for SVM Phase 2, Group: ', num2str(i)));
        secondQuestAnswers(i-10,5:8) = [p r f a];
        [p,r,f,a] = NeuralNet(trainMat,interMat, strcat('ROC curve for Neural Network Phase 2, Group: ', num2str(i)));
        secondQuestAnswers(i-10,9:12) = [p r f a];
    end
end
save('firstVals.mat', 'valMatrix');
save('secondVals.mat', 'secondQuestAnswers');
end