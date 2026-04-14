function xdot = GrantsAircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial,aircraft_parameters)
    density = stdatmo(-aircraft_state(3));
    [Fa, Ma] = AeroForcesAndMoments(aircraft_state,aircraft_surfaces,wind_inertial,density,aircraft_parameters);
    g = 9.81;
    X = Fa(1);Y = Fa(2);Z = Fa(3);L = Ma(1);M = Ma(2);N = Ma(3);
    ub = aircraft_state(7); vb = aircraft_state(8); wb = aircraft_state(9);
    phi = aircraft_state(4); theta = aircraft_state(5); psi = aircraft_state(6);
    velo_body = [ub;vb;wb];
    velo_vec = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi), cos(phi)*cos(psi)*sin(theta)+sin(phi)*sin(psi); ...
        cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi); ...
        -sin(theta),sin(phi)*cos(theta),cos(phi)*cos(theta)] * velo_body + wind_inertial;
    u = velo_vec(1); v = velo_vec(2); w = velo_vec(3);
    p = aircraft_state(10); q = aircraft_state(11); r = aircraft_state(12);
    ang_rat = [p;q;r];
    dpos = [cos(theta)*cos(psi), sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi), cos(phi)*cos(psi)*sin(theta)+sin(phi)*sin(psi); ...
        cos(theta)*sin(psi), sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi); ...
        -sin(theta),sin(phi)*cos(theta),cos(phi)*cos(theta)] * velo_vec;
    deul = [1, sin(phi)*tan(theta), cos(phi)*tan(theta);0,cos(theta),-sin(phi); ...
        0, sin(phi)*secd(theta), cos(phi)*secd(theta)] * ang_rat;
    dvel = [r*v-q*w;p*w-r*u;q*u-p*v] + aircraft_parameters.g*[-sin(theta);cos(theta)*sin(phi);cos(theta)*cos(phi)] ...
        + (1/aircraft_parameters.m)*[X;Y;Z];
    G = aircraft_parameters.Ix*aircraft_parameters.Iz - aircraft_parameters.Ixz^2;
    G1 = aircraft_parameters.Ixz * (aircraft_parameters.Iz - aircraft_parameters.Iy + aircraft_parameters.Iz)/G;
    G2 = (aircraft_parameters.Iz * (aircraft_parameters.Iz-aircraft_parameters.Iy) + aircraft_parameters.Ixz^2)/G;
    G3 = aircraft_parameters.Iz/G;
    G4 = aircraft_parameters.Ixz/G;
    G5 = (aircraft_parameters.Iz-aircraft_parameters.Ix)/aircraft_parameters.Iy;
    G6 = aircraft_parameters.Ixz/aircraft_parameters.Iy;
    G7 = (aircraft_parameters.Ix*(aircraft_parameters.Ix-aircraft_parameters.Iy)+aircraft_parameters.Ixz^2)/G;
    G8 = aircraft_parameters.Ix/G;
    dang = [G1*p*q - G2*q*r;G5*p*r-G6*(p^2 - r^2);G7*p*q-G1*q*r] + [G3*L+G4*N;M/aircraft_parameters.Iy;G4*L + G8*N];

    xdot(1:3) = dpos;
    xdot(4:6) = deul;
    xdot(7:9) = dvel;
    xdot(10:12) = dang;
    xdot = xdot';
end