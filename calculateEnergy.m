function Energy = calculateEnergy(Mass,Position,Velocity)
% Computes the total mechanical energy of the N-body system. 
% INPUT:  Mass - Mass of all the bodies in a matrix form.
%         Position - X and Y co-ordinates of all the bodies in a vector form.
%         Velocity - Velocity of the bodies in a vector form.
% OUTPUT: Energy - Total Mechanical Energy ( Kinetic Energy + Potential
%         Energy)

G =  1.4878* 10^-34; % In AU not meters
PotentialEnergy = 0;
KineticEnergy = 0;

for i =  1:length(Mass)
KineticEnergy = KineticEnergy + ((1/2)*Mass(i)*(norm(Velocity(i,:))^2));
 for j  = 1:length(Mass)
     if i < j
XPosition = Position(j,1) - Position(i,1);
YPosition = Position(j,2) - Position(i,2);
PositionFinal = [XPosition YPosition];
PotentialEnergy = PotentialEnergy + (-G*Mass(i)*Mass(j)/(norm(PositionFinal)));
     end
 end

end
Energy = KineticEnergy + PotentialEnergy; 

end