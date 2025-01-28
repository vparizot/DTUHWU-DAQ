%% DTU/HWU 2024-2025 Clinic Team 
% Data Visualization Script
% vparizot@g.hmc.edu
% 

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
