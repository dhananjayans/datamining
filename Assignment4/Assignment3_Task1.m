%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      Task1       %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

currentfolder = pwd;
dataFile = strcat(pwd,'\Data\summaryCopy.csv');
SummaryMat = csvread(dataFile);
[sum_Row,sum_Col] = size(SummaryMat);

AnnotationPath = strcat(pwd,'\Data\Annotation\');
EMG_PathAllGroups = strcat(pwd,'\Data\EMG\');
IMU_PathAllGroups = strcat(pwd,'\Data\IMU\');

disp('Parsing Begun of File# :-1');
disp(strcat('Name of File :-',mat2str(SummaryMat(1,2))));
numFrames = SummaryMat(1,3);
frameRate = SummaryMat(1,5);
AnnotFile = strcat(mat2str(SummaryMat(1,2)),'.txt');
Annotpath = strcat(AnnotationPath,AnnotFile);

;
EMGdummymatrix = strcat(EMG_PathAllGroups,mat2str(SummaryMat(1,2)),'_EMG.txt');
IMUdummymatrix = strcat(IMU_PathAllGroups,mat2str(SummaryMat(1,2)),'_IMU.txt');
[EatingActionCSVnew,NoneatingActionCSVnew] = ParseInput(numFrames,frameRate,char(Annotpath),char(EMGdummymatrix),char(IMUdummymatrix)); 
Group = mat2str(SummaryMat(1,2));
save(strcat(pwd,'\DataMats\Eating\',char(Group),'.mat'),'EatingActionCSVnew');
save(strcat(pwd,'\DataMats\NonEating\',char(Group),'.mat'),'NoneatingActionCSVnew');

disp('Completed Parsing File# :-1');
disp('  ');

FileCount = 2;
for File = 2:sum_Row
    numFrames = SummaryMat(File,3);
    frameRate = SummaryMat(File,5);
    AnnotFile = strcat(mat2str(SummaryMat(File,2)),'.txt');
    Annotpath = strcat(AnnotationPath,AnnotFile);
    Group = mat2str(SummaryMat(File,2));
    EMGdummymatrix = strcat(EMG_PathAllGroups,mat2str(SummaryMat(File,2)),'_EMG.txt');
    IMUdummymatrix = strcat(IMU_PathAllGroups,mat2str(SummaryMat(File,2)),'_IMU.txt');
    [EatingActionCSVnew,NoneatingActionCSVnew] = ParseInput(numFrames,frameRate,char(Annotpath),char(EMGdummymatrix),char(IMUdummymatrix)); 
    save(strcat(pwd,'\DataMats\Eating\',char(Group),'.mat'),'EatingActionCSVnew');
    save(strcat(pwd,'\DataMats\NonEating\',char(Group),'.mat'),'NoneatingActionCSVnew');
    
    %EatingActionCSV = vertcat(EatingActionCSV,EatingActionCSVnew);
    %NoneatingActionCSV = vertcat(NoneatingActionCSV,NoneatingActionCSVnew);
    disp(strcat('Completed Parsing File# :-',num2str(FileCount)));
    FileCount = FileCount + 1;
    disp('  ');
end

%OutputData('EatingActionCSV.csv',EatingActionCSV);
%OutputData('NoneatingActionCSV.csv',NoneatingActionCSV);

%save('EatingActionCSV.mat','EatingActionCSV');
%save('NoneatingActionCSV.mat','NoneatingActionCSV');
