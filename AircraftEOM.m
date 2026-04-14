function [var_dot] = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters)
%This function calculates the equations of motion for the fixed-wing aircraft with constant control
% surfaces. The inputs are time, the 12 x 1 aircraft state vector, the 4 x 1 control surface vector, the 3 x 1 inertial
% wind velocity in inertial coordinates, and the aircraft parameter structure. The output is the derivative of the
% state vector. 

x = aircraft_state(1);
y = aircraft_state(2);
z = aircraft_state(3);
phi = aircraft_state(4);
theta = aircraft_state(5);
psi = aircraft_state(6);
u = aircraft_state(7);
v = aircraft_state(8);
w = aircraft_state(9);
p = aircraft_state(10);
q = aircraft_state(11);
r = aircraft_state(12);

sigma_elevator = aircraft_surfaces(1);
sigma_aileron = aircraft_surfaces(2);
sigma_rudder = aircraft_surfaces(3);
sigma_throttle = aircraft_surfaces(4);

Va_x = wind_inertial(1);
Va_y = wind_inertial(2);
Va_z = wind_inertial(3);

%aircraft_parameters is already a struct

[aero_forces, aero_moments] = AeroForcesAndMoments(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);

    X = aero_forces(1);
    Y = aero_forces(2);
    Z = aero_forces(3);

    L = aero_moments(1);
    M = aero_moments(2);
    N = aero_moments(3);

    % Calculating Translation accels foir FWAC
    V = norm([u,v,w]);
    udot = r * v - q * w - aircraft_parameters.g * sin(theta) + (1/aircraft_parameters.m)*X;
    vdot = p * w - r * u + aircraft_parameters.g * sin(phi) * cos(theta) + (1/aircraft_parameters.m)*Y;
    wdot = q * u - p * v + aircraft_parameters.g * cos(phi) * cos(theta) +(1/aircraft_parameters.m)*Z;
   
    % Calculating rotation
    GAM  = aircraft_parameters.Ix*aircraft_parameters.Iz - aircraft_parameters.Ixz^2;
    G1   = aircraft_parameters.Ixz*(aircraft_parameters.Ix - aircraft_parameters.Iy + aircraft_parameters.Iz) / GAM;
    G2   = (aircraft_parameters.Iz*(aircraft_parameters.Iz - aircraft_parameters.Iy) + aircraft_parameters.Ixz^2) / GAM;
    G3   = aircraft_parameters.Iz / GAM;
    G4   = aircraft_parameters.Ixz / GAM;
    G5   = (aircraft_parameters.Iz - aircraft_parameters.Ix) / aircraft_parameters.Iy;
    G6   = aircraft_parameters.Ixz / aircraft_parameters.Iy;
    G7   = (aircraft_parameters.Ix*(aircraft_parameters.Ix - aircraft_parameters.Iy) + aircraft_parameters.Ixz^2) / GAM;
    G8   = aircraft_parameters.Ix / GAM;

    W = norm([p,q,r]);
    pdot = G1*p*q - G2*q*r + G3*L + G4*N;
    qdot = G5*p*r - G6*(p^2 - r^2) + (1/aircraft_parameters.Iy)*M;
    rdot = G7*p*q - G1*q*r + G4*L + G8*N;
    
    % Calculating Eueler accels
    phidot   = p + (q * sin(phi) * tan(theta)) + (r * cos(phi) * tan(theta));
    thetadot = q * cos(phi) - (r * sin(phi)); 
    psidot   = q * sin(phi) * sec(theta) + (r * cos(phi) * sec(theta));
    
    % Calculating inertial position derivs
    Rinertialtobody = angle2dcm(psi,theta,phi,'ZYX');
    Rbodytoinertial = Rinertialtobody' ;
    vel_inertial = Rbodytoinertial * [u; v; w];
    
    xdot = vel_inertial(1);
    ydot = vel_inertial(2);
    zdot = vel_inertial(3);
    
    % Assembling state vector 
    var_dot = [xdot; ydot; zdot; phidot; thetadot; psidot; udot; vdot; wdot; pdot; qdot; rdot];
end