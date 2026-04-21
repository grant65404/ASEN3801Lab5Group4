%Contributors: Grant Bechtel
%Course Number: ASEN 3801
%FileName: PlotAircraftSim.m
%Created: 4/07/2026

function PlotAircraftSim(time, aircraft_state_array, control_input_array,fig, col, bool, leg)
% if you want to save the plots, set bool to 1. default is no save. leg
% produces generalized legends for like multiple plot cases
arguments
        time;
        aircraft_state_array;
        control_input_array;
        fig = 1:1:6; % optional
        col = 'b'; % optional 
        bool = 0;   % optional
        leg = ""; % optional
    end
set(groot,'defaultAxesXGrid','on') % setting grids on for all plots
set(groot,'defaultAxesYGrid','on')
set(groot,'defaultAxesZGrid','on')

figure(fig(1)); % the first figure containing inertial position
sgtitle("Intertial Position") % large title for subplots
subplot(3,1,1);
plot(time, aircraft_state_array(1,:), col, linewidth=1.3); hold on;
title("x position");
xlabel("time (s)");
ylabel("dist. (m)");
subplot(3,1,2);
plot(time, aircraft_state_array(2,:), col, linewidth=1.3); hold on;
title("y position")
xlabel("time (s)");
ylabel("dist. (m)");
subplot(3,1,3);
plot(time,aircraft_state_array(3,:),col, linewidth=1.3); hold on; % negative z 
title("-z position")
xlabel("time (s)");
ylabel("dist. (m)");
if leg ~= "" % if the user inputs a legend name it places it in an ideal spot
    legend(leg,'Position',[0.633841768165843 0.899580306092237 0.205357139451163 0.0773809503941308])
end
if bool==true % if user wants to save plots, plots save
    f = gcf;
    f.WindowState = 'maximized'; % fullscreen plot
    pause(0.5); 
    exportgraphics(f, "figure"+ num2str(fig(1)) +".png", 'Resolution', 300);
end
figure(fig(2));
sgtitle("Euler Angles")
subplot(3,1,1);
plot(time, aircraft_state_array(4,:), col, linewidth=1.3); hold on;
title("Roll Angle")
xlabel("time (s)");
ylabel("\phi (rad)");
subplot(3,1,2);
plot(time, aircraft_state_array(5,:), col, linewidth=1.3); hold on;
title("Pitch Angle")
xlabel("time (s)");
ylabel("\theta (rad)");
subplot(3,1,3);
plot(time,aircraft_state_array(6,:),col, linewidth=1.3); hold on;
title("Yaw Angle")
xlabel("time (s)");
ylabel("\psi (rad)");
if leg ~= ""
    legend(leg,'Position',[0.633841768165843 0.899580306092237 0.205357139451163 0.0773809503941308])
end
if bool==true
    f = gcf;
    f.WindowState = 'maximized'; 
    pause(0.5); 
    exportgraphics(f, "figure"+num2str(fig(2))+".png", 'Resolution', 300);
end
figure(fig(3));
sgtitle("Intertial Velocity in Body Frame")
subplot(3,1,1);
plot(time, aircraft_state_array(7,:), col, linewidth=1.3); hold on;
title("x velocity")
xlabel("time (s)");
ylabel("u (m/s)");
subplot(3,1,2);
plot(time, aircraft_state_array(8,:), col, linewidth=1.3); hold on;
title("y velocity")
xlabel("time (s)");
ylabel("v (m/s)");
subplot(3,1,3);
plot(time,-aircraft_state_array(9,:),col, linewidth=1.3); hold on;
title("-z velocity")
xlabel("time (s)");
ylabel("w (m/s)");
if leg ~= ""
    legend(leg,'Position',[0.633841768165843 0.899580306092237 0.205357139451163 0.0773809503941308])
end
if bool==true
    f = gcf;
    f.WindowState = 'maximized'; 
    pause(0.5); 
    exportgraphics(f, "figure"+num2str(fig(3))+".png", 'Resolution', 300);
end
figure(fig(4))
sgtitle("Angular Velocity")
subplot(3,1,1);
plot(time, aircraft_state_array(10,:), col, linewidth=1.3); hold on;
title("Roll Rate")
xlabel("time (s)");
ylabel("p (rad/s)");
subplot(3,1,2);
plot(time, aircraft_state_array(11,:), col, linewidth=1.3); hold on;
title("Pitch Rate")
xlabel("time (s)");
ylabel("q (rad/s)");
subplot(3,1,3);
plot(time,aircraft_state_array(12,:),col, linewidth=1.3); hold on;
title("Yaw Rate")
xlabel("time (s)");
ylabel("r (rad/s)");
if leg ~= ""
    legend(leg,'Position',[0.633841768165843 0.899580306092237 0.205357139451163 0.0773809503941308])
end
if bool==true
    f = gcf;
    f.WindowState = 'maximized'; 
    pause(0.5); 
    exportgraphics(f, "figure"+num2str(fig(4))+".png", 'Resolution', 300);
end
figure(fig(5));
sgtitle("Control Inputs")
subplot(2,2,1);
plot(time,control_input_array(1,:)*180/pi, col, linewidth=1.3); hold on;
title("Elevator")
xlabel("time (s)");
ylabel("\delta_e (deg)");
subplot(2,2,2);
plot(time,control_input_array(2,:)*180/pi, col, linewidth=1.3); hold on;
title("Aileron")
xlabel("time (s)");
ylabel("\delta_a (deg)");
subplot(2,2,3);
plot(time,control_input_array(3,:)*180/pi, col, linewidth=1.3); hold on;
title("Rudder")
xlabel("time (s)");
ylabel("\delta_r (deg)");
subplot(2,2,4);
plot(time,control_input_array(4,:), col, linewidth=1.3); hold on;
title("Thrust")
xlabel("time (s)");
ylabel("\delta_t");
if leg ~= ""
    legend(leg,'Position',[0.485590278957453 0.476462444742479 0.0661458321536577 0.0379023873793621])
end
if bool==true
        f = gcf;
        f.WindowState = 'maximized'; 
        pause(0.5); 
        exportgraphics(f, "figure"+num2str(fig(5))+".png", 'Resolution', 300);
end
figure(fig(6));

plot3(aircraft_state_array(1,:),aircraft_state_array(2,:),-aircraft_state_array(3,:), col, linewidth=1.3)
hold on
plot3(aircraft_state_array(1,1),aircraft_state_array(2,1),-aircraft_state_array(3,2),'go','MarkerFaceColor','g'); % Mark Start
plot3(aircraft_state_array(1,end),aircraft_state_array(2,end),-aircraft_state_array(3,end),'ro','MarkerFaceColor','r'); % Mark Finish; hold on
title("Complete Recorded Flight Path")
xlabel("x pos (m)");
ylabel("y pos (m)");
zlabel("negative z pos (m)")
hold off
if leg ~= ""
    legend(leg,location="best")
end
if bool==true
    f = gcf;
    f.WindowState = 'maximized'; 
    pause(0.5); 
    exportgraphics(f, "figure"+num2str(fig(6))+".png", 'Resolution', 300);
end

end