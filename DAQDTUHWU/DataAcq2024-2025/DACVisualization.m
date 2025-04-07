%{
DACVisualization.m
Modified: January 2025
Author: Victoria Parizot
Email: vparizot@g.hmc.edu

Denmark Technical University/Heriot-Watt 2024-2025 Clinic Team Data Acquisition Sketch

Purpose: Data Acquisition for the current, windvane, and anemometer sensors of the power 
         electronics of the VAWT. Runs on a Teensy 4.2 and reads the voltage output from 
         the sensors and logs sensor data in desired units.  
febtest3- jovie and david spin crazy
febtest4 - mai spins slowly and consistently
febtest5 - mai and caden doing tachometer stuff
febtest6 --- drill test negative current

April6 test
no cloud cover, 70F, 

test1 - 15mph +-1.5

test2 - 20mph

test3 - 25mph

test 4 - 30mph

test5 - 35mph


test6 - 15mph

test7 - 20 paused cause of deflection

test8 - 20-22

test9 - 25

test10 - 30mph

test11 - 30-35
test12 - 35 mph (good test)
// fixed turbine

test13 - 30mph
test14 - 45

test 15 - 15-30

test 16 - 35mph
test17 - 

test 18 - slow stop sign then 40mph



Direction of road: 111 SE degrees

Used HMC E80 Source Code for Matlabbing: https://github.com/HMC-E80/E80/blob/main/MATLAB/logreader.m
%}

close all;
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

% Import the data feb11DAQtest2
dtuTest003 = readtable("/Users/vparizot/Downloads/dtu-hwu-DAQ/DAQDTUHWU/DataAcq2024-2025/pickupTests/test12", opts);
dtuTest003data = dtuTest003.Variables;

Current = dtuTest003data(1:3:end, 2); %amps
direction = dtuTest003data(2:3:end, 2); 
windSpeed =  dtuTest003data(3:3:end, 2);
timeCurrent = 1:1:length(Current);
timeSpeed = 1:1:length(windSpeed);
timeDir = 1:1:length(direction);

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
plot(timeCurrent(100:end), Current(100:end), '-b.');
% scatter(time, Current, 10, "filled");
title('Current vs Time');
xlabel('time (ms)');
ylabel('Current [A]');
hold off;

%% Plot Annemometer (windspeed [m/s] vs time)
subplot(3,1,2);
hold on;
plot(timeSpeed,windSpeed, '-g.');
% scatter(time, windSpeed, 10, "filled");
title('Windspeed vs Time');
xlabel('Time (ms)');
ylabel('Wind Speed [m/s]');
hold off;

%% Plot Windvane (Direction vs time)

subplot(3,1,3);
hold on;
plot(timeDir,direction, '-r.');
% scatter(time, direction, 10, "filled");
title('Direction vs Time');
xlabel('time (ms)');
ylabel('Direction [voltage]');
hold off;

%% 
figure(2);
windroseZhivomirov(direction,windSpeed);

% figure(3);
WindRosePereira(direction,windSpeed);

figure(4);
% https://www.mathworks.com/help/matlab/ref/compass.html
rad = direction*2*pi/360;
rad = rad-pi/2;
u = cos(rad) .* windSpeed; 
v = sin(rad) .* windSpeed; 
compass(u,v);
aveDir = sum(rad.*windSpeed)/sum(windSpeed);
w = mean(u); 
z = mean(v); 

% Generate the original plot.
compass(u,v);
hold on
c = compass(w,z,'ro-', 'top');
c.LineWidth = 2;
view(-90,90)

