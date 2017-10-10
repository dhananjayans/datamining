function [] = OutputData(filename,ActionCSV)
OutputPath = fullfile('C:\Users\Joel\Desktop\ASU_Stuff\Sem3\DM\Project\Assignment3\',filename);                                 
Output = fopen(OutputPath,'w');
[r,c] = size(ActionCSV);
disp(strcat('Writing data into ',filename,' file'));
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