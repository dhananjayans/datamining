%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%    SPOON    %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

VideoPathSpoon = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\spoon\1503699291032.mp4';
Assignment2PathSpoon = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\1503699291032.txt';

EMGSpoon_filePath = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\spoon\1503699291032_EMG.txt';
IMUSpoon_filePath = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\spoon\1503699291032_IMU.txt';

[EatingActionCSVSpoon,NoneatingActionCSVSpoon] = ParseInput(VideoPath,Assignment2PathSpoon,EMGSpoon_filePath,IMUSpoon_filePath); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%    FORK     %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

VideoPathFork = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\fork\1503698678322.mp4';
Assignment2PathFork = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\1503698678322.txt';

EMGFork_filePath = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\fork\1503698678322_EMG.txt';
IMUFork_filePath = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\fork\1503698678322_IMU.txt';

[EatingActionCSVFork,NoneatingActionCSVFork] = ParseInput(VideoPath,Assignment2PathFork,EMGFork_filePath,IMUFork_filePath); 

[r1,c1] = size(EatingActionCSVSpoon);
[r2,c2] = size(EatingActionCSVFork);
for iter = 1:r2
    EatingActionCSVFork(iter,1) = EatingActionCSVFork(iter,1) + EatingActionCSVSpoon(r1,1);
    NoneatingActionCSVFork(iter,1) = NoneatingActionCSVFork(iter,1) + NoneatingActionCSVSpoon(r1,1);
end


EatingActionCSV = vertcat(EatingActionCSVSpoon,EatingActionCSVFork);
NoneatingActionCSV = vertcat(NoneatingActionCSVSpoon,NoneatingActionCSVFork);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

OutputData('EatingActionCSV.csv',EatingActionCSV);
OutputData('NoneatingActionCSV.csv',NoneatingActionCSV);

save('EatingActionCSV.mat','EatingActionCSV');
save('NoneatingActionCSV.mat','NoneatingActionCSV');



