

%[EatingActionCSV,NoneatingActionCSV] = ParseInput(VideoPath,Assignment2Path,); 

Path = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\spoon';
Filename = '1503699291032.mp4';

Video = VideoReader(fullfile(Path,Filename));

EMG_file = csvread('C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\spoon\1503699291032_EMG.txt');
IMU_file = csvread('C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\Content\spoon\1503699291032_IMU.txt');

SpoonDataPath = 'C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3';
SpoonDataFile = '1503699291032.txt';

EatingActionFrameRange = csvread(fullfile(SpoonDataPath,SpoonDataFile));
numFrames = ceil(Video.FrameRate*Video.Duration);

[row,col] = size(EatingActionFrameRange);
NoneatingActionFrameRange = nan(row,2);


for iter = 1:row
    NoneatingActionFrameRange(iter,1) = EatingActionFrameRange(iter,2) + 1;
    if iter ~= row
        NoneatingActionFrameRange(iter,2) = EatingActionFrameRange(iter+1,1) - 1;
    else
        NoneatingActionFrameRange(iter,2) = numFrames;
    end
end

[EMG_row,EMG_col] = size(EMG_file);
[IMU_row,IMU_col] = size(IMU_file);

LastTimestampEMG = EMG_file(EMG_row,1);
LastTimestampIMU = IMU_file(IMU_row,1);

EatingActionEMG = nan(1000,(row * (EMG_col - 1)));
NoneatingActionEMG = nan(1000,(row * (EMG_col - 1)));

EatingActionIMU = nan(1000,(row * (IMU_col - 1)));
NoneatingActionIMU = nan(1000,(row * (IMU_col - 1)));


%Eating Action EMG
sensorDesc = 11;
actionCounter = 1;
for iter = 1:(row * (EMG_col - 1))
    if sensorDesc == 19
        sensorDesc = 11;
        actionCounter = actionCounter + 1;
    end
    EatingActionEMG(1,iter) = actionCounter;
    EatingActionEMG(2,iter) = sensorDesc;
    sensorDesc = sensorDesc + 1;
end


ActionNo = 1;
for iter = 1:row
    ApproxStartTimestampEMG = LastTimestampEMG - ((numFrames - EatingActionFrameRange(iter,1))/Video.FrameRate)*1000;
    ApproxEndTimestampEMG = LastTimestampEMG - ((numFrames - EatingActionFrameRange(iter,2))/Video.FrameRate)*1000;
    for start = 1:EMG_row
       if EMG_file(start,1) > ApproxStartTimestampEMG
           break;
       end
    end
    startpos = start - 1;
    for start = startpos:EMG_row
       if EMG_file(start,1) > ApproxEndTimestampEMG
           break;
       end
    end
    endpos = start - 1;
    EatingActionEMG(3:3 + (endpos - startpos),ActionNo:ActionNo+7) = EMG_file(startpos:endpos,2:9);
    ActionNo = ActionNo + 8;
end

%Noneating Action EMG
sensorDesc = 11;
actionCounter = 1;
for iter = 1:(row * (EMG_col - 1))
    if sensorDesc == 19
        sensorDesc = 11;
        actionCounter = actionCounter + 1;
    end
    NoneatingActionEMG(1,iter) = actionCounter;
    NoneatingActionEMG(2,iter) = sensorDesc;
    sensorDesc = sensorDesc + 1;
end

ActionNo = 1;
for iter = 1:row
    ApproxStartTimestampEMG = LastTimestampEMG - ((numFrames - NoneatingActionFrameRange(iter,1))/Video.FrameRate)*1000;
    ApproxEndTimestampEMG = LastTimestampEMG - ((numFrames - NoneatingActionFrameRange(iter,2))/Video.FrameRate)*1000;
    for start = 1:EMG_row
       if EMG_file(start,1) > ApproxStartTimestampEMG
           break;
       end
    end
    startpos = start - 1;
    for start = startpos:EMG_row
       if EMG_file(start,1) > ApproxEndTimestampEMG
           break;
       end
    end
    endpos = start - 1;
    NoneatingActionEMG(3:3 + (endpos - startpos),ActionNo:ActionNo+7) = EMG_file(startpos:endpos,2:9);
    ActionNo = ActionNo + 8;
end


%Eating Action IMU
sensorDesc = 1;
actionCounter = 1;
for iter = 1:(row * (IMU_col - 1))
    if sensorDesc == 11
        sensorDesc = 1;
        actionCounter = actionCounter + 1;
    end
    EatingActionIMU(1,iter) = actionCounter;
    EatingActionIMU(2,iter) = sensorDesc;
    sensorDesc = sensorDesc + 1;
end


ActionNo = 1;
for iter = 1:row
    ApproxStartTimestampIMU = LastTimestampIMU - ((numFrames - EatingActionFrameRange(iter,1))/Video.FrameRate)*1000;
    ApproxEndTimestampIMU = LastTimestampIMU - ((numFrames - EatingActionFrameRange(iter,2))/Video.FrameRate)*1000;
    for start = 1:IMU_row
       if IMU_file(start,1) > ApproxStartTimestampIMU
           break;
       end
    end
    startpos = start - 1;
    for start = startpos:IMU_row
       if IMU_file(start,1) > ApproxEndTimestampIMU
           break;
       end
    end
    endpos = start - 1;
    EatingActionIMU(3:3 + (endpos - startpos),ActionNo:ActionNo+9) = IMU_file(startpos:endpos,2:11);
    ActionNo = ActionNo + 10;
end

%Noneating Action IMU
sensorDesc = 1;
actionCounter = 1;
for iter = 1:(row * (IMU_col - 1))
    if sensorDesc == 11
        sensorDesc = 1;
        actionCounter = actionCounter + 1;
    end
    NoneatingActionIMU(1,iter) = actionCounter;
    NoneatingActionIMU(2,iter) = sensorDesc;
    sensorDesc = sensorDesc + 1;
end


ActionNo = 1;
for iter = 1:row
    ApproxStartTimestampIMU = LastTimestampIMU - ((numFrames - NoneatingActionFrameRange(iter,1))/Video.FrameRate)*1000;
    ApproxEndTimestampIMU = LastTimestampIMU - ((numFrames - NoneatingActionFrameRange(iter,2))/Video.FrameRate)*1000;
    for start = 1:IMU_row
       if IMU_file(start,1) > ApproxStartTimestampIMU
           break;
       end
    end
    startpos = start - 1;
    for start = startpos:IMU_row
       if IMU_file(start,1) > ApproxEndTimestampIMU
           break;
       end
    end
    endpos = start - 1;
    NoneatingActionIMU(3:3 + (endpos - startpos),ActionNo:ActionNo+9) = IMU_file(startpos:endpos,2:11);
    ActionNo = ActionNo + 10;
end

EatingActionEMG = EatingActionEMG';
EatingActionIMU = EatingActionIMU';
NoneatingActionEMG = NoneatingActionEMG';
NoneatingActionIMU = NoneatingActionIMU';

[EMGsize_row,EMGsize_col] = size(   EatingActionEMG);
[IMUsize_row,IMUsize_col] = size(EatingActionIMU);
EatingActionCSV = nan(EMGsize_row +IMUsize_row,1000);
NoneatingActionCSV = nan(EMGsize_row +IMUsize_row,1000);

EACount = 1;
IMUCount = 1;
EMGCount = 1;
for iter = 1:actionCounter
    EatingActionCSV(EACount:EACount+9,1:1000) = EatingActionIMU(IMUCount:IMUCount+9,1:1000);
    EatingActionCSV(EACount+10:EACount+17,1:1000) = EatingActionEMG(EMGCount:EMGCount+7,1:1000);
    EACount = EACount + 18;
    IMUCount = IMUCount + 10;
    EMGCount = EMGCount + 8;
end

EACount = 1;
IMUCount = 1;
EMGCount = 1;
for iter = 1:actionCounter
    NoneatingActionCSV(EACount:EACount+9,1:1000) = NoneatingActionIMU(IMUCount:IMUCount+9,1:1000);
    NoneatingActionCSV(EACount+10:EACount+17,1:1000) = NoneatingActionEMG(EMGCount:EMGCount+7,1:1000);
    EACount = EACount + 18;
    IMUCount = IMUCount + 10;
    EMGCount = EMGCount + 8;
end

OutputFile = 'EatingCSV.csv';                                           
OutputPath = fullfile('C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\',OutputFile);                                 
Output = fopen(OutputPath,'w');

save('EatingActionCSV.mat','EatingActionCSV');
save('NoneatingActionCSV.mat','NoneatingActionCSV');

for iteri = 1:EMGsize_row + IMUsize_row
    line = int2str(EatingActionCSV(iteri,1));
    for iterj = 2:1000
        if ~isnan(EatingActionCSV(iteri,iterj))
            line = strcat(line,',',num2str(EatingActionCSV(iteri,iterj)));
        end
    end
    fprintf(Output,'%s',line);
    fprintf(Output,'\n');
end

fclose(Output);
