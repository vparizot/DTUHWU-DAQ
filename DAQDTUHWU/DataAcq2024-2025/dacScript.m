
% Trials 9, 11, 12, 19, 20

close all;
clear;
clf;

output9 = DACVisualization("test9")
output11 = DACVisualization("test11")
output12 = DACVisualization("test12")
output19 = DACVisualization("test19")
output20 = DACVisualization("test20")

Current9 = output9(:,1);
windSpeed9 = output9(:,2);

Current11 = output11(:,1);
windSpeed11 = output11(:,2);

Current12 = output12(:,1);
windSpeed12 = output12(:,2);

Current19 = output19(:,1);
windSpeed19 = output19(:,2);

Current20 = output20(:,1);
windSpeed20 = output20(:,2);

x = [mean(windSpeed9), mean(windSpeed11), mean(windSpeed12), mean(windSpeed19), mean(windSpeed20)];
y = [mean(Current9), mean(Current11), mean(Current12), mean(Current19), mean(Current20)];
hold on 
figure(1);
scatter(x, y, "filled")
xlabel("Wind Speed [m/s]");
ylabel("Current [A]");
% scatter(windSpeed11, Current11)
% scatter(windSpeed12, Current12)
% scatter(windSpeed19, Current19)
% scatter(windSpeed20, Current20)
hold off



