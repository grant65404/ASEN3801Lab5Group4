%Contributors: Colby Muchlinski
%Course Number: ASEN 3801
%FileName: ElevatorChange.m
%Created: 4/14/2026

function aircraft_surfaces_adjust = ElevatorChange(aircraft_surfaces,doublet_time,doublet_size)
%Inputs:
%aircraft_surfaces: the initial aircraft control surface states
%doublet_time: the time were the doublet occurs
%double_size: the amount of change in elevator angle due to the doublet

%Outputs:
%aircraft_surfaces_adjust: the adusted aircraft control surface states

%Methodology:
%Use an if statement to determine if before or after the doublet time, and
%apply the double appropiately depending on that time



pulse = [doublet_size;0;0;0];


if t <= doublet_time

 aircraft_surfaces_adjust = aircraft_surfaces + pulse;


elseif t > doublet_time && t <= 2*doublet_time

 aircraft_surfaces_adjust = aircraft_surfaces - pulse;


elseif t > 2*doublet_time


 aircraft_surfaces_adjust = aircraft_surfaces;
end






end