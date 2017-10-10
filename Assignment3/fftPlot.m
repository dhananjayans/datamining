function[] = fftPlot(rowNum,dimenred)
    load("consolidatedMatEating.mat");
    plot(abs(fft(consolidatedMat(rowNum,:),dimenred)));
    hold on;
    load("consolidatedMatNonEating.mat");
    plot(abs(fft(consolidatedMat(rowNum,:),dimenred)));
    imgName = strcat(num2str(rowNum),'_fft.png');
    saveas(gcf,fullfile('C:\Users\sdjcs\OneDrive\Documents\ASU\Subjects\DM\Project\datamining\Assignment3\FFTPlots',imgName),'png');
    hold off;
end

