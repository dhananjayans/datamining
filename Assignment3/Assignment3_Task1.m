%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%      Task1       %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

currentfolder = pwd;
AnnotationPath = strcat(pwd,'\Data\Annotation\');
EMG_PathAllGroups = strcat(pwd,'\Data\EMG\');
IMU_PathAllGroups = strcat(pwd,'\Data\IMU\');
Videos_PathAllGroups = strcat(pwd,'\Data\Videos\');
AnnotationFiles = dir(fullfile(AnnotationPath,'*.txt')); 
disp('Parsing Begun of File# :-1');
disp(strcat('Name of File :-',AnnotationFiles(1).name));
Annotpath = strcat(AnnotationPath,AnnotationFiles(1).name);
GroupId = strsplit(AnnotationFiles(1).name,'.');
Group = GroupId(1,1);
Videodummymatrix = strcat(Videos_PathAllGroups,Group,'.mp4');
EMGdummymatrix = strcat(EMG_PathAllGroups,Group,'_EMG.txt');
IMUdummymatrix = strcat(IMU_PathAllGroups,Group,'_IMU.txt');
[EatingActionCSV,NoneatingActionCSV] = ParseInput(char(Videodummymatrix),Annotpath,char(EMGdummymatrix),char(IMUdummymatrix)); 
disp('Completed Parsing File# :-1');
disp('  ');

FileCount = 2;
for File = 2:size(AnnotationFiles)
    disp(strcat('Parsing Begun of File# :-',num2str(FileCount)));
    disp(strcat('Name of File :-',AnnotationFiles(File).name));
    Annotpath = strcat(AnnotationPath,AnnotationFiles(File).name);
    GroupId = strsplit(AnnotationFiles(File).name,'.');
    Group = GroupId(1,1);
    Videodummymatrix = strcat(Videos_PathAllGroups,Group,'.mp4');
    EMGdummymatrix = strcat(EMG_PathAllGroups,Group,'_EMG.txt');
    IMUdummymatrix = strcat(IMU_PathAllGroups,Group,'_IMU.txt');
    
    [EatingActionCSVnew,NoneatingActionCSVnew] = ParseInput(char(Videodummymatrix),Annotpath,char(EMGdummymatrix),char(IMUdummymatrix)); 
    EatingActionCSV = vertcat(EatingActionCSV,EatingActionCSVnew);
    NoneatingActionCSV = vertcat(NoneatingActionCSV,NoneatingActionCSVnew);
    disp(strcat('Completed Parsing File# :-',num2str(FileCount)));
    FileCount = FileCount + 1;
    disp('  ');
end

OutputData('EatingActionCSV.csv',EatingActionCSV);
OutputData('NoneatingActionCSV.csv',NoneatingActionCSV);

save('EatingActionCSV.mat','EatingActionCSV');
save('NoneatingActionCSV.mat','NoneatingActionCSV');
