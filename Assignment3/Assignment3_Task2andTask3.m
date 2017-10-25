%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      Task2       %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Function to plot 18 Sensors times 6 metrics (Mean,Entropy,Variance,WilsonAmplitude,ZeroCrossing,RMS)
%extractFeaturesAndPlot(EatingActionCSV,NoneatingActionCSV);

load('EatingActionCSV.mat');
load('NoneatingActionCSV.mat');

disp('   ');
disp('Running Task 2');
[trainingTable] = prepareTrainingData(EatingActionCSV,NoneatingActionCSV);
disp('Task 2 completed - Refer to Report for chosen 5 feature box plots')
disp('   ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      Task3       %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('   ');
disp('Running Task 3');
performPCAandPlot(trainingTable);
disp('Task 3 completed - Kindly view the Transformed Feature matrix plots displayed(1 Scatter Plot and 3 Box Plots)')
disp('   ');