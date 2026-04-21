function aircraft_surfaces_adjust = ElevatorChange(aircraft_surfaces,doublet_time,doublet_size, time)


pulse = [doublet_size;0;0;0];


if time <= doublet_time
 aircraft_surfaces_adjust = aircraft_surfaces + pulse;


elseif time > doublet_time && time <= 2*doublet_time
 aircraft_surfaces_adjust = aircraft_surfaces - pulse;


elseif time > 2*doublet_time
 aircraft_surfaces_adjust = aircraft_surfaces;

end


end