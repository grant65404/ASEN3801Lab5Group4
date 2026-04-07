function xdot = AircraftEOMJackBraun(time, aircraft_state, aircraft_surfaces, wind_inertial, aircraft_parameters)

xE = aircraft_state(1);
yE = aircraft_state(2);
zE = aircraft_state(3);
phi = aircraft_state(4);
theta = aircraft_state(5);
psi = aircraft_state(6);
uE = aircraft_state(7);
vE = aircraft_state(8);
wE = aircraft_state(9);
p = aircraft_state(10);
q = aircraft_state(11);
r = aircraft_state(12);

density = stdatmo(-zE);


% Store a rotation matrix
% Define the rotation matrix based on Euler angles
R = [cos(theta)*cos(psi), cos(theta)*sin(psi), -sin(theta);
    sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi), sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi), sin(phi)*cos(theta);
    cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi), cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi), cos(phi)*cos(theta)];

Rinv = inv(R);

xdot(1:3) = Rinv*[uE; vE; wE];

R2 = [1, sin(phi)*tan(theta), cos(phi)*tan(theta);
    0, cos(phi), -sin(phi);
    0, sin(phi)/cos(theta), cos(phi)/cos(theta)];

xdot(4:6) = R2*[p; q; r];


% Call for Aero Forces and Moments

[aeroForces, aeroMoments] = AeroForcesAndMoments(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);

xdot(7) = r*vE - q*wE -g*sin(theta) + (1/m)*(aeroForces(1));
xdot(8) = p*wE - r*uE +g*cos(theta)*sin(phi) + (1/m)*(aeroForces(2));
xdot(9) = q*uE - p*vE +g*cos(theta)*cos(phi) + (1/m) * (aeroForces(3));

% Store Inertia Values: 
Ix = aircraft_parameters.Ix;
Iy = aircraft_parameters.Iy;
Iz = aircraft_parameters.Iz;
Ixz = aircraft_parameters.Ixz;

L = aeroMoments(1);
M = aeroMoments(2);
N = aeroMoments(3);

tau = Ix*Iz - Ixz*Ixz;


xdot(10) = (Ixz(Ix-Iy+Iz)/tau)*p*q - ((Iz(Iz-Iy)+Ixz*Ixz)/tau)*q*r + ((Iz/tau)*L + (Ixz/tau)*N);
xdot(11) = ((Iz-Ix)/Iy)*p*r - (Izx/Iy)* (p*p - r*r) + (1/Iy)*M;
xdot(12) = ((Ix(Ix-Iy)+Ixz*Ixz)/tau)*p*q - (Ixz(Ix-Iy+Iz)/tau)*q*r + (Ixz/tau)*L + (Ix/tau)*N;


end