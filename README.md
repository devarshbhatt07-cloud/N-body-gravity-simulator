## Contents

-Overview

-Features

-Physics Model

-Numerical Methods

-Energy Analysis

-Results (In-Progress)

-Usage (In-Progress)

-Conclusion (In-Progress)

-Limitations

-Future Improvements

-Author and Acknowledgments

-References (In-Progress)

## **Overview**

This project executes an N-body gravitational simulator in MATLAB using Newtonian gravity. Each body experiences the gravitational acceleration produced by every other body in the system.
The simulator is designed to examine differences in accuracy of stellar and planetary orbits amongst three numerical integration methods - Euler Method, Symplectic Euler and Fourth-order Runge-Kutta (RK4) by comparing the total mechanical energy of the system, analyzing the celestial orbits after 1000 days or 1000 numerical integrator cycles. The underlying functions are written to support N-body configurations by changing the mass, position, and velocity arrays. 

## **Features** 
 
- N-body Newtonian gravitational interactions
- Euler numerical integration
- Symplectic Euler numerical integration
- Fourth-order Runge-Kutta (RK4) integration
- Real-time orbital visualization
- Total mechanical energy calculation
- Timestep comparison

## **Physics Model**

Newton’s Law of Universal Gravitation states that every object exerts a gravitational force to other objects. The magnitude of the gravitational force is defined as GMm/r^2 where M and m are two distinct bodies and r is the distance between them. Acceleration due to gravity is defined as GM/r^2 faced by m. The total acceleration of each body is obtained by summing the contributions from every other body in the system. It is done by the user defined function - solveAcceleration in the simulator.   
In a solar system, celestial bodies move constantly, and thus change the distance between the two objects. This constant change in distance causes constant change in the gravitational force. This calls for a way to accurately approximate the displacement of a body in space. Several numerical integration methods have been developed to do just that. 
The simulation compares three of them -

1)Euler

2)Symplectic Euler

3)Runge Kutta 4th Order 

## **Units**

Before getting into the mathematics of these integrators, it is important to know the units used in the calculation-

| Quantity | Unit |
|---|---|
| Mass | kg |
| Position | AU |
| Velocity | AU/day |
| Acceleration | AU/day² |
| Time | days |
| Gravitational constant | AU³/(kg·day²) |
| Energy | kg·AU²/day² | 

The units are changed from the SI system due to the enormity of the numerical values. For example, the distance between the Sun and the planets is in metres in the SI system, but to make the calculation easier, it is measured in Astronomical Units (AU) : the distance between the Sun and Earth.
The unit of time was changed to day to observe the changes in the solar system over a large period of time. 
Subsequently units for Acceleration,Gravitational constant, Velocity and Energy were changed according to AU and days.

The change in units doesn’t change the look of the graphs nor does it change the calculation. It was done only to grasp the enormous figures in a simpler way.
 
## **Numerical Method**

To understand the math and physics behind the integrators, let’s first understand the terminology used.

**Sinitial** - Initial position of the body

**Sfinal**  - Final position of the body (What we are approximating)

**Vinitial** - Initial velocity of the body

**Vfinal** - Final velocity of the body 

**Ainitial** - Initial Acceleration of the body 

**Afinal** - Final Acceleration of the body 

**Δt** - Time step ( time step used in this simulator is 1 day)

**Note:** To use Newtonian Formulas,  acceleration is assumed to be constant during the time step.

## **Euler Method**

The Euler method is the first in the Runge Kutta Family. It approximates the final position by using Newtonian physics with initial conditions in this specific order -

Sfinal =  Sinitial + Vinitial *Δt

Vfinal = Vinitial  + Ainitial *Δt

Afinal  = GM/(Sfinal)^2

—Then cycle repeats—

In the Euler Method, each variable is approximated by using the initial value before the timestep. After every timestep, the final values become the initial values for the next time step calculations. It is not very accurate since acceleration is kept constant during the time interval but in reality it constantly changes. This accumulates error everytime the cycle runs and makes the objects drift outward from their true orbits. Since the objects drift outward the total mechanical energy of the system increases and goes more towards 0 since it's a bounded system and currently the total energy is in negative as per conventions.

Following images depict the orbits of the solar system (inner planets) and the total mechanical energy of the system after 1000 days in simple Euler Method.

<img width="959" height="447" alt="Screenshot 2026-08-11 052310" src="https://github.com/user-attachments/assets/ef86a895-ab3f-4bc0-b46e-18d2acec2bc1" />

<img width="959" height="446" alt="Screenshot 2026-08-11 052119" src="https://github.com/user-attachments/assets/d160d86f-824e-49d9-86b7-a8766ed943fb" />

## **Symplectic Euler**

Symplectic Euler Method is also a first order integrator in the Runge Kutta family. However, it has a small distinction in the order it calculates its values. In this project, ‘position first’ form has been used as it calculates the position first but then it updates acceleration. Then that acceleration is used to update the velocity. 
In this form velocity is updated using the final acceleration instead of the initial acceleration. This reduces the error as velocity is based off of the final conditions after the timestep.  

Sfinal =  Sinitial + Vinitial *Δt

Afinal  = GM/(Sfinal)^2

Vfinal = Vinitial  + Afinal *Δt

Following images depict the orbits of the solar system (Inner Planets) and the total mechanical energy of the system after 1000 days in the Symplectic Euler Method.

<img width="959" height="449" alt="Screenshot 2026-08-11 045620" src="https://github.com/user-attachments/assets/02e5c29f-172e-47ec-9ba1-4ebe2dbc7970" />

<img width="959" height="446" alt="Screenshot 2026-08-11 045517" src="https://github.com/user-attachments/assets/684201d9-aa03-4f38-9fa9-6619219ba1c1" />



## **Runge Kutta - 4th Order Method**

Runge Kutta - 4th Order or RK4 method calculates its final position and velocity differently. RK4 evaluates the system at four stages within a single time step: the starting point, two separate evaluations at the midpoint, and the final point. It calculates position, acceleration and velocity for these points and uses it in the initial position to calculate the final position and likewise for velocity. The intermediate states are estimated using the current derivatives, and the four derivative evaluations are then combined using a weighted average. 

**Note:** K indicates the point in the timestep. There are three stopping points but it is visited four times since the middle point is visited twice.


SK1  = Sinitial (Starting Point)

VK1  = Vinitial (Starting Point)

AK1  = solveAcceleration(Mass,SK1);


SK2 =  Sinitial + Vinitial *Δt/2 (Middle Point)

VK2 =  Vinitial + Ainitial *Δt/2 (Middle Point)

AK2l  = solveAcceleration(Mass,SK2 );


SK3 =  Sinitial  +  VK2*Δt/2 (Middle Point revisited from starting point with new acceleration)

VK3 =  Vinitial  +  AK2*Δt/2 (Middle Point revisited from starting point with new acceleration)

AK3  = solveAcceleration(Mass,SK3 );

SK4 =  Sinitial  + VK3*Δt (Final Point)

VK4 =  Vinitial  + AK3*Δt (Final Point)

AK4  = solveAcceleration(Mass,SK4 );

Sfinal  = Sinitial + Δt* ⅙ * ( Vinitial+ 2*VK2+ 2* VK3+ VK4)

Vfinal  = Vinitial +  Δt*⅙ * ( Ainitial+ 2* AK2+ 2*AK3+ AK4)

Following images depict the orbits of the solar system (Inner Planets) and the total mechanical energy of the system after 1000 days in the RK4 Method.

<img width="959" height="446" alt="Screenshot 2026-08-11 045835" src="https://github.com/user-attachments/assets/15f7360f-4707-4cf0-a66f-d071d62a8204" />

<img width="959" height="446" alt="Screenshot 2026-08-11 044634" src="https://github.com/user-attachments/assets/b026ba65-abf1-4a6f-9f5e-5bb0a7d26e76" />

## **Energy Calculation**

This project centers total mechanical energy to compare the three numerical integration models. The total mechanical energy is the summation of Kinetic and Potential Energy of the system.

Energytotal = Kinetic Energy + Potential Energy

Kinetic Energy of the entire system was calculated by summing individual kinetic energy of every body -

K= ∑​ ½ * M * V^2

Summation was done using a FOR loop with variables i and j where i<j so each pair's potential energy is counted only once.
For Potential Energy a nested FOR loop was used to get all the pairs of celestial bodies and then summed up to get the total Potential Energy.

U = ∑​​GM​m/(rrelative)

**Note:** The values used here ( V and rrelative ) are the updated velocity and position calculated in the integrator cycle.
After calculating the total mechanical energy, it is graphed at the end of each integrator file after energy of each cycle has been accumulated inside a single vector.. 

## **Project Structure**

| File | Description |
|---|---|
| `FinalEuler.m` | Runs the N-body simulation using Euler integration |
| `FinalSymplecticEuler.m` | Runs the simulation using Symplectic Euler |
| `FinalRK4.m` | Runs the simulation using RK4 |
| `solveAcceleration.m` | Calculates gravitational acceleration on each body |
| `calculateEnergy.m` | Calculates total kinetic + potential energy |
| `rk4calculator.m` | Performs one RK4 integration step |

## **Limitations**

There are several limitations to this to project which needs to be addressed- 
- The simulation is currently two-dimensional.
- Relativistic effects are not included.
- The direct N-body calculation scales poorly as the number of bodies increases.
- The Solar System initial conditions are provided as an example configuration rather than a high-precision ephemeris solution.
  
## **Future Improvements**

Potential improvements include:

- Relative error measurements
- Orbital eccentricity calculations
- Larger N-body systems
- Vectorization of the gravitational calculation
- Adaptive time step integration
- Three-dimensional simulations

## Conclusion

This project demonstrates the implementation and comparison of several numerical integration methods for an N-body gravitational system. 

## Author and Acknowledgement

**Author -**

Devarsh Bhatt

Aerospace Engineering at North Carolina State University

**Acknowledgement -**

Krishang Parikh

Thank you for your feedback, discussions, and help while developing this project.

 


  

