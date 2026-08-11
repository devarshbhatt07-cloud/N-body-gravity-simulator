% Inputting the Initial Data- Mass, Position, Velocity, Names, Color and Marker of the celestial bodies into vectors.

conv = 86400/149597870.7;

Mass = [1.989*10^30;
     3.3*10^23;
     4.87*10^24;
     5.97*10^24;
     6.42*10^23;
     1.9*10^27;
     5.68*10^26;
     8.68*10^25;
     1.02*10^26];

Velocity = [0,0;
     2.981,-44.205;
    -3.102,-34.891;
     28.911,-5.402;
    -8.544,24.112;
    -11.011,-6.115;
    -1.503,9.444;
    -5.911,2.810;
    -0.189, 5.311] * conv;

Position = [0,0;
    -0.38871,-0.11024;  
    -0.71880,0.06540;
    -0.18903,-0.99752;
     1.29881, 0.57332;
    -2.79943,4.45561;
     9.37894,1.14421;
     9.31102,17.07115;
     29.84110,1.01994];

Names = {'Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune'};
Colors = [
     1.0 1.0 0.0;      % Body 1
     0.5 0.5 0.5;      % Body 2
     1.0 0.6 0.0;      % Body 3
     0.0 0.4 1.0;      % Body 4
     1.0 0.0 0.0;      % Body 5
     0.8 0.5 0.2;      % Body 6
     0.9 0.8 0.4;      % Body 7
     0.4 1.0 1.0;      % Body 8
     0.2 0.2 1.0       % Body 9
     ];

MarkerIndicator = {'p','.','.','.','.','.','.','.','.'};

% Initializing cycle count, time interval of a single cycle (1 day) and text to display cycle count
% in graph.

dt = 1;
cyclecount = 0;
InitialText = [];

% Creating and formatting a figure for the N-Body simulation.

fig = figure;
axis([-35 35 -35 35]);
grid on
title('Solar System Simulator (Euler Model)','Color', 'w')
xlabel('Distance From the Sun in AU (x axis)')
ylabel('Distance From the Sun in AU (y axis)')
set(gca, 'Color', 'k');
set(gcf, 'Color', 'k'); 
set(gca, 'XColor', 'w', 'YColor', 'w'); 
grid on;
set(gca, 'GridColor', 'w');
hold on


% Creating a FOR loop to plot initial positions and text of the bodies.

for i = 1:length(Mass)
PlanetPlot(i) = plot(Position(i,1),Position(i,2),'Marker',MarkerIndicator{i}, 'Color',Colors(i,:),'MarkerSize',5);
PlanetLabel(i) = text(Position(i,1),Position(i,2),Names{i},'Color','w','FontSize',5);
orbit(i)  = animatedline('Color', Colors(i,:),'LineStyle', '-', 'LineWidth', 0.5);
end

% Creating a WHILE loop that constantly updates the position of the bodies
% till the given time limit.

while cyclecount ~=1000 && isvalid(fig)
delete(InitialText)
cyclecount = cyclecount + 1;

% Computing the gravitational acceleration acting on every body.

Acceleration = solveAcceleration(Mass,Position);
Position = Position + Velocity*dt;
Velocity = Velocity + Acceleration*dt;

% Creating a FOR loop inside the while loop to update the position of all
% the bodies in the system.

for i = 1:length(Mass)
PlanetPlot(i).XData = Position(i,1);
PlanetPlot(i).YData = Position(i,2);
PlanetLabel(i).Position = [Position(i,1),Position(i,2)];
addpoints(orbit(i),Position(i,1),Position(i,2))
end

% Calculating the Energy and storing it into a matrix.

Energy(cyclecount) = calculateEnergy(Mass,Position,Velocity);

% Creating a text to indicate number of cycles passed.

InitialText = text(0.02, 0.98, ['Number of RK1 (Euler) cycle: ', num2str(cyclecount)], 'Units', 'Normalized', 'FontSize', 10, 'Color', 'w');
drawnow
end

% Creating and formatting another figure for the energy of the system.

figure;
grid on
hold on
set(gca, 'Color', 'k');
set(gcf, 'Color', 'k'); 
set(gca, 'XColor', 'w', 'YColor', 'w'); 
axis([0 cyclecount -6.91*10^22 -6.89 *10^22 ]) 
xlabel('Number of Cycles passed')
ylabel('Total Mechanical Energy of the system in (Kg*AU^2)/ Day^2')
GraphTitle = sprintf('Energy Graph of the Euler System at %d  cycles',cyclecount);
title(GraphTitle,'Color','w')
plot(1:cyclecount,Energy,'-w')
  
