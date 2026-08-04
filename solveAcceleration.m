function acceleration = solveAcceleration(Mass,Position)
% Computes the gravitational acceleration acting on every body in
% using Newton's law of gravitation.
% INPUT:  Mass - Mass of all the bodies in a matrix form.
%         Position - X and Y co-ordinates of all the bodies in a matrix form.
% OUTPUT: accleration - the final acceleration calculated by the updated position
%         after the time interval

G =  1.4878*10^-34; % in (AU^3/(kg·day^2))

acceleration = zeros(length(Mass),2);  
for i =  1:length(Mass)
 for j  = 1:length(Mass)
     if i ~= j
XPosition = Position(j,1) - Position(i,1);
YPosition = Position(j,2) - Position(i,2);
PositionFinal = [XPosition YPosition];
         acceleration(i,:)  = acceleration(i,:) + ((G*Mass(j)/ (norm(PositionFinal)^2))*PositionFinal/norm(PositionFinal));
     end
 end
end 
end