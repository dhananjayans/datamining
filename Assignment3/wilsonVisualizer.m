function[] =  dwtVisualizer(rowNum,threshold)
    fileName = "Eating";
    prefix = "wilsonAmpData/";
    fileName = strcat(prefix,fileName,num2str(threshold),".mat");
    load(fileName);
    eatingData = wampMat(rowNum,:);
    plot(eatingData);
    hold on;
    fileName = "NonEating";
    fileName = strcat(prefix,fileName,num2str(threshold),".mat");
    load(fileName);
    nonEatingData = wampMat(rowNum,:);
    plot(nonEatingData);
    fileName = strcat("wilsonImages/",num2str(rowNum),num2str(threshold),".png");
    print(fileName,'-dpng');
    hold off;
end