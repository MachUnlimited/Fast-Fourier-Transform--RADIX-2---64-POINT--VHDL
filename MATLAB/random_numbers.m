clc,close all,clear all;

min_value = -2;
max_value = 2;
random_number = min_value + (max_value - min_value) * rand(128, 1);


fileID = fopen('random_numbers_matlab.txt','w'); % FOR MATLAB INPUT
for i = 1:128
    fprintf(fileID, ("  """ + dec2bin(typecast(single(random_number(i)),'uint32'),32)+""";" )+"\n");
end


fclose(fileID);


fileID = fopen('random_numbers_vhdl.txt','w'); %% FOR VHDL INPUT
for i = 1:128
    if mod(i,2) == 0
        fprintf(fileID, ("" + dec2bin(typecast(single(random_number(i)),'uint32'),32)+""";" )+"\n");
    else
        fprintf(fileID, ("""" + dec2bin(typecast(single(random_number(i)),'uint32'),32)));
    end

end

%% RANDOM NUMBERS GENERATOR %% 