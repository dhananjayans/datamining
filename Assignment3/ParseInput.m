function [EatingActionCSV,NoneatingActionCSV] = ParseInput(VideoPath,Assignment2Path,EMG_filePath,IMU_filePath)

Video = VideoReader(VideoPath);
EMG_file = csvread(EMG_filePath);
IMU_file = csvread(IMU_filePath);
    
EatingActionFrameRange = csvread(Assignment2Path);
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

EatingActionEMG = parseEMGfile(row,numFrames,EatingActionFrameRange,EMG_file,Video);
NoneatingActionEMG = parseEMGfile(row,numFrames,NoneatingActionFrameRange,EMG_file,Video);

EatingActionIMU = parseIMUfile(row,numFrames,EatingActionFrameRange,IMU_file,Video);
NoneatingActionIMU = parseIMUfile(row,numFrames,NoneatingActionFrameRange,IMU_file,Video);

EatingActionCSV = joinEMGandIMU(EatingActionEMG,EatingActionIMU);
NoneatingActionCSV = joinEMGandIMU(NoneatingActionEMG,NoneatingActionIMU);
end

function [ActionEMG] = parseEMGfile(row,numFrames,ActionFrameRange,EMG_file,Video)

[EMG_row,EMG_col] = size(EMG_file);
LastTimestampEMG = EMG_file(EMG_row,1);
ActionEMG = nan(1000,(row * (EMG_col - 1)));

sensorDesc = 11;
actionCounter = 1;
for iter = 1:(row * (EMG_col - 1))
    if sensorDesc == 19
        sensorDesc = 11;
        actionCounter = actionCounter + 1;
    end
    ActionEMG(1,iter) = actionCounter;
    ActionEMG(2,iter) = sensorDesc;
    sensorDesc = sensorDesc + 1;
end

ActionNo = 1;
for iter = 1:row
    ApproxStartTimestampEMG = LastTimestampEMG - ((numFrames - ActionFrameRange(iter,1))/Video.FrameRate)*1000;
    ApproxEndTimestampEMG = LastTimestampEMG - ((numFrames - ActionFrameRange(iter,2))/Video.FrameRate)*1000;
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
    ActionEMG(3:3 + (endpos - startpos),ActionNo:ActionNo+7) = EMG_file(startpos:endpos,2:9);
    ActionNo = ActionNo + 8;
end

ActionEMG = ActionEMG';
end
function [ActionIMU] = parseIMUfile(row,numFrames,ActionFrameRange,IMU_file,Video)

[IMU_row,IMU_col] = size(IMU_file);
LastTimestampIMU = IMU_file(IMU_row,1);
ActionIMU = nan(1000,(row * (IMU_col - 1)));

sensorDesc = 1;
actionCounter = 1;
for iter = 1:(row * (IMU_col - 1))
    if sensorDesc == 11
        sensorDesc = 1;
        actionCounter = actionCounter + 1;
    end
    ActionIMU(1,iter) = actionCounter;
    ActionIMU(2,iter) = sensorDesc;
    sensorDesc = sensorDesc + 1;
end


ActionNo = 1;
for iter = 1:row
    ApproxStartTimestampIMU = LastTimestampIMU - ((numFrames - ActionFrameRange(iter,1))/Video.FrameRate)*1000;
    ApproxEndTimestampIMU = LastTimestampIMU - ((numFrames - ActionFrameRange(iter,2))/Video.FrameRate)*1000;
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
    ActionIMU(3:3 + (endpos - startpos),ActionNo:ActionNo+9) = IMU_file(startpos:endpos,2:11);
    ActionNo = ActionNo + 10;
end
ActionIMU = ActionIMU';
end
function [ActionCSV] = joinEMGandIMU(ActionEMG,ActionIMU)
[EMGsize_row,EMGsize_col] = size(ActionEMG);
[IMUsize_row,IMUsize_col] = size(ActionIMU);
ActionCSV = nan(EMGsize_row +IMUsize_row,1000);

EACount = 1;
IMUCount = 1;
EMGCount = 1;
for iter = 1:ActionEMG(EMGsize_row,1)
    ActionCSV(EACount:EACount+9,1:1000) = ActionIMU(IMUCount:IMUCount+9,1:1000);
    ActionCSV(EACount+10:EACount+17,1:1000) = ActionEMG(EMGCount:EMGCount+7,1:1000);
    EACount = EACount + 18;
    IMUCount = IMUCount + 10;
    EMGCount = EMGCount + 8;
end
end
