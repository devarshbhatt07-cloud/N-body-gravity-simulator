function [UpdatedPosition, UpdatedVelocity] = rk4calculator(Mass,Position,Velocity)
% Computes the updated position and velocity after every cycle of the Runge-Kutta 4th order numerical integrator.  
% INPUT:  Mass - Mass of all the bodies in a matrix form.
%         Position - X and Y co-ordinates of all the bodies in a vector form.
%         Velocity - Velocity of the bodies in a vector form.
% OUTPUT: UpdatedPosition- the final position calculated after the time
%         interval
%         UpdatedVelocity - the final velocity calculated after the time
%         interval 


dt = 1;

% Finding k1 

Positionk1 = Position; 
Velocityk1 = Velocity;
Accelerationk1 = solveAcceleration(Mass,Positionk1);

% Finding k2
Positionk2 = Positionk1 + Velocityk1*dt/2;
Velocityk2 = Velocityk1 + Accelerationk1*dt/2;
Accelerationk2 = solveAcceleration(Mass,Positionk2);

% Finding k3
Positionk3 = Positionk1 + Velocityk2*dt/2;
Velocityk3 = Velocityk1 + Accelerationk2*dt/2;
Accelerationk3 = solveAcceleration(Mass,Positionk3);

% Finding k4
Positionk4 = Positionk1 + Velocityk3*dt;
Velocityk4 = Velocityk1 + Accelerationk3*dt;
Accelerationk4 = solveAcceleration(Mass,Positionk4);

% Final Updated Values 
UpdatedPosition = Position + dt/6*(Velocityk1 + 2*Velocityk2 + 2*Velocityk3 + Velocityk4);
UpdatedVelocity = Velocity + dt/6*(Accelerationk1 + 2*Accelerationk2 + 2*Accelerationk3 + Accelerationk4);

end