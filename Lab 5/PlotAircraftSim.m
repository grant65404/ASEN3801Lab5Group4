function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col)
    
    % Determine case name from figure numbers to plot things neatly
    if fig(1) == 1
        casename = 'Case 2.1 (Only Forward Velocity)';
        elseif fig(1) == 7
            casename = 'Case 2.2: SLUF Flight';
        elseif fig(1) == 13
            casename = 'Case 2.3: Spiral Mode';
        elseif fig(1) == 19
            casename = 'Case 3.0: Doublet Short Sim';
        elseif fig(1) == 25
            casename = 'Case 3.0: Doublet Long Sim';
    end

    % seperating aircraft state vector and control inputs for plotting
    x = aircraft_state_array(1,:);
    y = aircraft_state_array(2,:);
    z = aircraft_state_array(3,:);
    phi = aircraft_state_array(4,:);
    theta = aircraft_state_array(5,:);
    psi = aircraft_state_array(6,:);
    u = aircraft_state_array(7,:);
    v = aircraft_state_array(8,:);
    w = aircraft_state_array(9,:);
    p = aircraft_state_array(10,:);
    q = aircraft_state_array(11,:);
    r = aircraft_state_array(12,:);
    
    sigma_elevator = control_input_array(1,:);
    sigma_aileron = control_input_array(2,:);
    sigma_rudder = control_input_array(3,:);
    sigma_throttle = control_input_array(4,:);
    
    % inertial position
    figure(fig(1));
    sgtitle(['Inertial Position - ' casename])
    subplot(311);
    plot(time, x, col); hold on;
    grid on;
    ylabel('X-Posiiton (m)')
    subplot(312);
    plot(time, y, col); hold on;
    grid on;
    ylabel('Y-Posiiton (m)')
    subplot(313);
    plot(time,z,col); hold on;
    grid on;
    ylabel('Z-Posiiton (m)')
    xlabel('Time (s)')
    
    % Euler Angles
    figure(fig(2));
    sgtitle(['Euler Angles - ' casename])
    subplot(311);
    plot(time,phi,col); hold on;
    grid on;
    ylabel('\phi Roll (rad)')
    subplot(312);
    plot(time,theta,col); hold on;
    grid on;
    ylabel('\theta Pitch (rad)')
    subplot(313);
    plot(time,psi,col); hold on;
    grid on;
    ylabel('\psi Yaw (rad)')
    xlabel('Time (s)')
    
    % Inertial Velocity in Body Frame
    figure(fig(3));
    sgtitle(['Body Velocity - ' casename])
    subplot(311);
    plot(time,u,col); hold on;
    grid on;
    ylabel('u-Velocity (m/s)')
    subplot(312);
    plot(time,v,col); hold on;
    grid on;
    ylabel('v-Velocity (m/s)')
    subplot(313);
    plot(time,w,col); hold on;
    grid on;
    ylabel('w-Velocity (m/s)')
    xlabel('Time (s)')
    
    % Angular Velocity
    figure(fig(4));
    sgtitle(['Angular Velocity - ' casename])
    subplot(311);
    plot(time,p,col); hold on;
    grid on;
    ylabel('p-Component (rad/s)')
    subplot(312);
    plot(time,q,col); hold on;
    grid on;
    ylabel('q-Component (rad/s)')
    subplot(313);
    plot(time,r,col); hold on;
    grid on;
    ylabel('r-Component (rad/s)')
    xlabel('Time (s)')

    % Control Inputs
    figure(fig(5));
    sgtitle(['Control Inputs - ' casename])
    subplot(411)
    plot(time, sigma_elevator, col); hold on;
    grid on;
    ylabel('sigma_elevator (deg)')
    subplot(412)
    plot(time, sigma_aileron, col); hold on;
    grid on;
    ylabel('sigma_aileron (deg)')
    subplot(413)
    plot(time, sigma_rudder, col); hold on;
    grid on;
    ylabel('sigma_rudder (deg)')
    subplot(414)
    plot(time, sigma_throttle, col); hold on;
    grid on;
    ylabel('sigma_throttle (fraction of 1)')
    xlabel('Time (s)')
    
    % 3D Path
    figure(fig(6));
    plot3(x, y, -z, col); hold on;
    
    plot3(aircraft_state_array(1,1), aircraft_state_array(2,1), -aircraft_state_array(3,1), 'go');
    
    plot3(aircraft_state_array(1,end), aircraft_state_array(2,end), -aircraft_state_array(3,end), 'ro');
    
    grid on
    xlabel('Inertial X-Position (m)')
    ylabel('Inertial Y-Position (m)')
    zlabel('Height [real world, flipped from inertial frame] (m)')
    title(['Aircraft 3D Path - ' casename])

    %%%%%% SAVES EVERYTHING AS A PDF
    % letter = ['A','B','C','D','E','F'];
    % for i = 1:6
    %     exportgraphics(figure(fig(i)), taskname+"_"+partname+"_"+graphcasename+"_"+letter(i)+".png", 'ContentType','image', 'Resolution', 200);
    % end
    %%%%%%%% ONLY UNCOMMENT TO HAVE 1 MILLION PDF's
end