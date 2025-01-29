%{
DACVisualization.m
Modified: January 2025
Author: Victoria Parizot
Email: vparizot@g.hmc.edu

Denmark Technical University/Heriot-Watt 2024-2025 Clinic Team Data Acquisition Sketch

Purpose: Data Acquisition for the current, windvane, and anemometer sensors of the power 
         electronics of the VAWT. Runs on a Teensy 4.2 and reads the voltage output from 
         the sensors and logs sensor data in desired units.  

%}

%% convert time to s
time = linspace(0,10);


clf;
figure(1);
sgtitle('DTU/HWU Clinic: Weather Characteristics vs Time');

%% Plot Current (Current [A] vs time)
subplot(3,1,1);
hold on;
Current = sin(time);
plot(time, Current, '-b.');
% scatter(time, Current, 10, "filled");
title('Current vs Time');
xlabel('time (s)');
ylabel('Current [A]');
hold off;

%% Plot Annemometer (windspeed [m/s] vs time)
subplot(3,1,2);
hold on;
windSpeed = cos(time);
plot(time,windSpeed, '-g.');
% scatter(time, windSpeed, 10, "filled");
title('Windspeed vs Time');
xlabel('Time (s)');
ylabel('Wind Speed [m/s]');
hold off;

%% Plot Windvane (Direction vs time)

subplot(3,1,3);
hold on;
direction = 3*sin(time);
plot(time,direction, '-r.');
% scatter(time, direction, 10, "filled");
title('Direction vs Time');
xlabel('time (s)');
ylabel('Direction');
hold off;
