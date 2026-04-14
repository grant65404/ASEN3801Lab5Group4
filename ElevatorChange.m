function aircraft_surfaces_adjust = ElevatorChange(aircraft_surfaces,doublet_time,doublet_size)

pulse = [doublet_size;0;0;0];


if t <= doublet_time

 aircraft_surfaces_adjust = aircraft_surfaces + pulse;


elseif t > doublet_time && t <= 2*doublet_time

 aircraft_surfaces_adjust = aircraft_surfaces - pulse;


elseif t > 2*doublet_time


 aircraft_surfaces_adjust = airfract_surfaces;
end






end