% hw2floorheatingducts.m
% This Matlab script finds the steady-state temperature distribution in a
% floor slab with fluid channels, and it also performs a heat flux calculation.
% Form the matrix
A=eye(18); % start off with an identity matrix that is 18x18
A(1,[2 5]) = -[.5 .25]; % put .5 in (1,2) entry, put .25 in (1,5) entry
A(2,[1 3 6]) = -.25;
A(3,[2 4]) = -.25;
A(4,3) = -.5;
A(5,[1 6 7]) = -[.25 .5 .25];
A(6,[2 5 8]) = -.25;
A(7,[5 8 9]) = -[.25 .5 .25];
A(8,[6 7 10]) = -.25;
A(9,[7 10 11]) = -[.25 .5 .25];
A(10,[8 9 12]) = -.25;
A(11,[9 12 15]) = -[.25 .5 .25];
A(12,[10 11 13 16]) = -.25;
A(13,[12 14 17]) = -.25;
A(14,[13 18]) = -[.5 .25];
A(15,[11 16]) = -.5;
A(16,[15 12 17]) = -[.25 .5 .25];
A(17,[16 18 13]) = -[.25 .25 .5];
A(18,[14 17]) = -.5;

% Form the RHS vector
TA=20;
TD=80;
b=[TA; TA; TA+TD; TA+TD; 0; TD; 0; TD; 0; TD; 0; 0; TD; TD; 0; 0; 0; 0]/4;
% Solve the system of equations that governs the temperatures at
% grid points
T=A\b;
% Reform the vector of temperatures into a matrix for plotting
L=150; % in mm
temps=[ TA TA TA TA;
T(1) T(2) T(3) T(4);
T(5) T(6) TD TD;
T(7) T(8) TD TD;
T(9) T(10) TD TD;
T(11) T(12) T(13) T(14);
T(15) T(16) T(17) T(18)];
x=(0:3)*L/2; % x-coordinates
y=(0:6)*L/2; % y-coordinates
cplot=contourf(x,y,temps);
clabel(cplot);
hold on
axis equal
axis tight
title('Contour plot of steady state temperatures (scale in mm)')
set(gca,'YDir','reverse'); %flips to correct orientation
% calculate flux
k = 1.4; % W/(m.K)
% this value is in watts/meter and it is for a section of the heat
% exchanger that is 3*L/2 (225mm) wide and 1m depth into the page
Qtop=k*((TA-T(1))+2*(TA-T(2))+2*(TA-T(3))+TA-T(4))/2; % this is in watts/meter
% so to get the value of the heat flux to the air over a 4m^2
% square area, we would need to divide by 3*L/2 and multiply by 4
Qtop*4/((L*3/2)/1000) %(answer is now in watts)
% The resulting flux is negative because heat is leaving the system (and
% going into the air)