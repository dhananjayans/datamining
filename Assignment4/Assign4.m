function [] = Assign4
baseName = "DataMats/GroupWise/Group_";
valMatrix = zeros(34,10);
load("EatingActionCSV.mat");
load("NoneatingActionCSV.mat");

% Call methods group wise
% Store it in matrix
for i = 1:2
    if(i<10)
        eatingName = strcat(baseName,"0",num2str(i),"/Eating/Eating.mat");
        nonEatingName = strcat(baseName,"0",num2str(i),"/NonEating/NonEating.mat");
    else
        eatingName = strcat(baseName,num2str(i),"/Eating/Eating.mat");
        nonEatingName = strcat(baseName,num2str(i),"/NonEating/NonEating.mat");
    end
    eatingMat = load(eatingName);
    nonEatingMat = load(nonEatingName);
    [train,test] = prepareTrainingAndTestData(eatingMat.result,nonEatingMat.result);
    valMatrix(i,1:3) = DecisionTree(train,test); 
    valMatrix(i,4:6) = SVM(train,test); 
    valMatrix(i,7:9) = NeuralNet(train,test);
end

[train,test] = prepareTrainingAndTestData(EatingActionCSV,NoneatingActionCSV);
% Call methods for overall
% Store it in matrix
valMatrix(34,1:3) = DecisionTree(train,test); 
valMatrix(34,4:6) = SVM(train,test); 
valMatrix(34,7:9) = NeuralNet(train,test);


end