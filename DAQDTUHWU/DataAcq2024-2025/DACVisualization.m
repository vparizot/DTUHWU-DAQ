%{
DACVisualization.m
Modified: January 2025
Author: Victoria Parizot
Email: vparizot@g.hmc.edu

Denmark Technical University/Heriot-Watt 2024-2025 Clinic Team Data Acquisition Sketch

Purpose: Data Acquisition for the current, windvane, and anemometer sensors of the power 
         electronics of the VAWT. Runs on a Teensy 4.2 and reads the voltage output from 
         the sensors and logs sensor data in desired units.  

Used HMC E80 Source Code for Matlabbing: https://github.com/HMC-E80/E80/blob/main/MATLAB/logreader.m
%}

clear;
clf;

%% import data from coolTerm txt file
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = [" ", ","];

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "VarName4", "VarName5"];
opts.SelectedVariableNames = ["VarName4", "VarName5"];
opts.VariableTypes = ["string", "string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3"], "EmptyFieldRule", "auto");

% Import the data
dtuTest003 = readtable("/Users/vparizot/Downloads/dtu-hwu-DAQ/DAQDTUHWU/DataAcq2024-2025/dtuTest003", opts);
dtuTest003data = dtuTest003.Variables

Current = dtuTest003data(1:3:end, 2); %amps
direction = dtuTest003data(2:3:end, 2)'; 
windSpeed =  dtuTest003data(3:3:end, 2)';
time = 1:1:206;

%% TODO: Import from SD card 
%{ 
filenum = '003'; % file number for the data you want to read
infofile = strcat('INF', filenum, '.TXT');
datafile = strcat('LOG', filenum, '.BIN');

% map from datatype to length in bytes
dataSizes.('float') = 4;
dataSizes.('ulong') = 4;
dataSizes.('int') = 4;
dataSizes.('int32') = 4;
dataSizes.('uint8') = 1;
dataSizes.('uint16') = 2;
dataSizes.('char') = 1;
dataSizes.('bool') = 1;

% read from info file to get log file structure
fileID = fopen(infofile);
items = textscan(fileID,'%s','Delimiter',',','EndOfLine','\r\n');
fclose(fileID);
[ncols,~] = size(items{1});
ncols = ncols/2;
varNames = items{1}(1:ncols)';
varTypes = items{1}(ncols+1:end)';
varLengths = zeros(size(varTypes));
colLength = 256;
for i = 1:numel(varTypes)
    varLengths(i) = dataSizes.(varTypes{i});
end
R = cell(1,numel(varNames));

% read column-by-column from datafile
fid = fopen(datafile,'rb');
for i=1:numel(varTypes)
    %# seek to the first field of the first record
    fseek(fid, sum(varLengths(1:i-1)), 'bof');
    
    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' varTypes{i}], colLength-varLengths(i));
    eval(strcat(varNames{i},'=','R{',num2str(i),'};'));
end
fclose(fid);
%}


figure(1);
sgtitle('DTU/HWU Clinic: Weather Characteristics vs Time');

%% Plot Current (Current [A] vs time)
subplot(3,1,1);
hold on;
plot(time, Current, '-b.');
% scatter(time, Current, 10, "filled");
title('Current vs Time');
xlabel('time (s)');
ylabel('Current [A]');
hold off;

%% Plot Annemometer (windspeed [m/s] vs time)
subplot(3,1,2);
hold on;
plot(time,windSpeed, '-g.');
% scatter(time, windSpeed, 10, "filled");
title('Windspeed vs Time');
xlabel('Time (s)');
ylabel('Wind Speed [m/s]');
hold off;

%% Plot Windvane (Direction vs time)

subplot(3,1,3);
hold on;
plot(time,direction, '-r.');
% scatter(time, direction, 10, "filled");
title('Direction vs Time');
xlabel('time (s)');
ylabel('Direction [Degrees]');
hold off;
