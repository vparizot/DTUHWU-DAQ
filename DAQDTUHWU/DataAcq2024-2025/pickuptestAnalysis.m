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
dtuTest1 = readtable("/Users/vparizot/Downloads/dtu-hwu-DAQ/DAQDTUHWU/DataAcq2024-2025/pickupTests/test3", opts);
dtuTest1data = dtuTest1.Variables;

Current = -1.*dtuTest1data(1:3:end, 2); %amps
direction = dtuTest1data(2:3:end, 2); 
windSpeed =  dtuTest1data(3:3:end, 2);
timeCurrent = 1:1:length(Current);
timeSpeed = 1:1:length(windSpeed);
timeDir = 1:1:length(direction);