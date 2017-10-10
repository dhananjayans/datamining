function[] = varFinder(rowNum)
    load("consolidatedMatEating.mat");
    rowNumFeature = consolidatedMat(rowNum,:);
    rowNumFeature(isnan(rowNumFeature)) = [];
    inferMatEating = mean(rowNumFeature);
    disp(strcat('Eating: ',num2str(inferMatEating)));
    load("consolidatedMatNonEating.mat");
    rowNumFeature = consolidatedMat(rowNum,:);
    rowNumFeature(isnan(rowNumFeature)) = [];
    inferMatNonEating = mean(rowNumFeature);
    disp(strcat('Non-Eating: ',num2str(inferMatNonEating)));
end