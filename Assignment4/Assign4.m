function [] = Assign4
baseName = "DataMats/GroupWise/Group_";
valMatrix = zeros(34,12);
load("EatingActionCSV.mat");
load("NoneatingActionCSV.mat");
trainMat = [];
testMat = [];
interMat = [];
% Call methods group wise
% Store it in matrix
for i = 1:33
    if (i==10)
        continue;
    end
    if (i==12)
        continue;
    end
    if (i==13)
        continue;
    end
    if (i==27)
        continue;
    end
    if (i==31)
        continue;
    end
    
    if(i<10)
        eatingName = strcat(baseName,"0",num2str(i),"/Eating/Eating.mat");
        nonEatingName = strcat(baseName,"0",num2str(i),"/NonEating/NonEating.mat");
        
    else
        eatingName = strcat(baseName,num2str(i),"/Eating/Eating.mat");
        nonEatingName = strcat(baseName,num2str(i),"/NonEating/NonEating.mat");
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
    [p,r,f,a] = DecisionTree(train,test);
    valMatrix(i,1:4) = [p r f a];
    [p,r,f,a] = SVM(train,test);
    valMatrix(i,5:8) = [p r f a];
    [p,r,f,a] = NeuralNet(train,test);
    valMatrix(i,9:12) = [p r f a];
    disp(valMatrix(i,:));
end

% Call methods for overall
% Store it in matrix
[p,r,f,a] = DecisionTree(trainMat,testMat);
valMatrix(34,1:4) = [p r f a]; 
[p,r,f,a] = SVM(trainMat,testMat);
valMatrix(34,5:8) = [p r f a]; 
[p,r,f,a] = NeuralNet(train,test);
valMatrix(34,9:12) = [p r f a];
disp(valMatrix(34,:));
end