function [] = OutputData(filename,ActionCSV)
currentFolder = pwd;
OutputPath = fullfile(currentFolder,filename);
Output = fopen(OutputPath,'w');
[r,c] = size(ActionCSV);
disp(strcat('Writing data into :- ',filename,' file'));
introcomment1 = 'Data in 2nd column represents the sensor values'; 
introcomment2 = 'The key-value for each IMU sensor is 1 -> Orientation X,  2 -> Orientation Y, 3 -> Orientation Z, 4 -> Orientation W, 5 -> Accelerometer X, 6 -> Accelerometer Y, 7 -> Accelerometer Z, 8 -> Gyroscope X, 9 -> Gyroscope Y, 10 ->Gyroscope Z.';
introcomment3 = 'The key-value for each EMG sensor is 11 -> EMG 1, 12 -> EMG 2, 13 -> EMG 3, 14 -> EMG 4, 15 -> EMG 5,16 -> EMG 6, 17 -> EMG 7, and 18 -> EMG 8';
fprintf(Output,'%s',introcomment1);
fprintf(Output,'\n');
fprintf(Output,'%s',introcomment2);
fprintf(Output,'\n');
fprintf(Output,'%s',introcomment3);
fprintf(Output,'\n');
for iteri = 1:r
    line = int2str(ActionCSV(iteri,1));
    for iterj = 2:1000
        if ~isnan(ActionCSV(iteri,iterj))
            line = strcat(line,',',num2str(ActionCSV(iteri,iterj)));
        end
    end
    fprintf(Output,'%s',line);
    fprintf(Output,'\n');
end
fclose(Output);
end