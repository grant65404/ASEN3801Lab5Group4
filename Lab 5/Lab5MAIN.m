clc
clear
close all

run("ttwistor.m")

%% Part 1
%% Part 2.1

control_input_array = zeros(4,1); %elevator, aileron, rudder, throttle
aircraft_state_array = zeros(12,1);
aircraft_state_array(3) = -1609.34; %m
aircraft_state_array(7) = 21; %m/s
time = [0,200];
aircraft_surfaces = zeros(4,1);
wind_inertial = [0 0 0]';
[T,a,P,density] = atmoscoesa(-aircraft_state_array(3));

[time,aircraft_state] = ode45(@(time,aircraft_state) AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters),time,aircraft_state_array);
aircraft_state_vector = aircraft_state';

PlotAircraftSim(time,aircraft_state_vector,control_input_array,1:6,'r-');

%% Part 2.2

%controls
control_input_array = zeros(4,1); %elevator, aileron, rudder, throttle

%aircraft surfaces
aircraft_surfaces = zeros(4,1);
aircraft_surfaces(1) = 0.1079; %rad
aircraft_surfaces(4)= 0.3182; 

%initial conditions
aircraft_state_array = zeros(12,1);
aircraft_state_array(3) = -1800; %m
aircraft_state_array(5) = 0.02780; %rad
aircraft_state_array(7) = 20.99; %m/s
aircraft_state_array(9) = 0.5837; %m/s
time = [0,200];
wind_inertial = [0 0 0]';
[T,a,P,density] = atmoscoesa(-aircraft_state_array(3));

[time,aircraft_state] = ode45(@(time,aircraft_state) AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters),time,aircraft_state_array);
aircraft_state_vector = aircraft_state';

PlotAircraftSim(time,aircraft_state_vector,control_input_array,7:12,'r-');

%% Part 2.3

%controls
control_input_array = zeros(4,1); %elevator, aileron, rudder, throttle

%aircraft surfaces
aircraft_surfaces = zeros(4,1);
aircraft_surfaces(1) = deg2rad(5); %rad
aircraft_surfaces(2) = deg2rad(2); %rad
aircraft_surfaces(3) = deg2rad(-13); %rad
aircraft_surfaces(4)= 0.3;%unitless

%initial conditions
aircraft_state_array = zeros(12,1);
aircraft_state_array(3) = -1800; %m
aircraft_state_array(4) = deg2rad(15); %rad
aircraft_state_array(5) = deg2rad(-12); %rad
aircraft_state_array(6) = deg2rad(270); %rad
aircraft_state_array(7) = 19; %m/s
aircraft_state_array(8) = 3; %m/s
aircraft_state_array(9) = -2; %m/s
aircraft_state_array(10) = deg2rad(0.08); %m/s
aircraft_state_array(11) = deg2rad(-0.2); %m/s
time = [0,200];
wind_inertial = [0 0 0]';
[T,a,P,density] = atmoscoesa(-aircraft_state_array(3));

[time,aircraft_state] = ode45(@(time,aircraft_state) AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters),time,aircraft_state_array);
aircraft_state_vector = aircraft_state';

PlotAircraftSim(time,aircraft_state_vector,control_input_array,13:18,'r-');

%% Part 3

%%%%%%%%%%SAME INPUT AS 2.2%%%%%%%%%%
%controls
control_input_array = zeros(4,1); %elevator, aileron, rudder, throttle

%aircraft surfaces
aircraft_surfaces = zeros(4,1);
aircraft_surfaces(1) = 0.1079; %rad
aircraft_surfaces(4)= 0.3182; 

%initial conditions
aircraft_state_array = zeros(12,1);
aircraft_state_array(3) = -1800; %m
aircraft_state_array(5) = 0.02780; %rad
aircraft_state_array(7) = 20.99; %m/s
aircraft_state_array(9) = 0.5837; %m/s
time = [0,3];
wind_inertial = [0 0 0]';
[T,a,P,density] = atmoscoesa(-aircraft_state_array(3));
%%%%%%%%%%SAME INPUT AS 2.2%%%%%%%%%%

%doublet conditions
doublet_size = deg2rad(15); %rad
doublet_time = 0.25; %sec

[time,aircraft_state] = ode45(@(time,aircraft_state) AircraftEOMDoublet(time, aircraft_state, aircraft_surfaces, doublet_size, doublet_time, wind_inertial, density, aircraft_parameters),time,aircraft_state_array);
aircraft_state_vector = aircraft_state';

PlotAircraftSim(time,aircraft_state_vector,control_input_array,19:24,'r-');

%longer sim
time = [0,100];
[time,aircraft_state] = ode45(@(time,aircraft_state) AircraftEOMDoublet(time, aircraft_state, aircraft_surfaces, doublet_size, doublet_time, wind_inertial, density, aircraft_parameters),time,aircraft_state_array);
aircraft_state_vector = aircraft_state';

PlotAircraftSim(time,aircraft_state_vector,control_input_array,25:30,'r-');


