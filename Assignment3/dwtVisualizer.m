function[] =  dwtVisualizer(rowNum )
    load("consolidatedMatEating.mat");
    rowNumFeature = consolidatedMat(rowNum,:);
    rowNumFeature(isnan(rowNumFeature)) = [];
    [lo,hi] = wfilters('bior3.5','d');
    [ca,cd] = dwt(rowNumFeature,lo,hi);
    plot(ca);
    fileName = strcat("dwtImages/",num2str(rowNum), "Eating");
    print(fileName,'-dpng');
    figure;
    load("consolidatedMatNonEating.mat");
    rowNumFeature = consolidatedMat(rowNum,:);
    rowNumFeature(isnan(rowNumFeature)) = [];
    [ca,cd] = dwt(rowNumFeature,lo,hi);
    plot(ca);
    fileName = strcat("dwtImages/",num2str(rowNum), "NonEating");
    print(fileName,'-dpng');
end