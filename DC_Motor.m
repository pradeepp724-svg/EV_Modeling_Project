if ~exist('simlog_DC_Motor', 'var') || ...
        simlogNeedsUpdate(simlog_DC_Motor, 'DC_Motor') 
    sim('DC_Motor')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end


% Reuse figure if it exists, else create new figure
if ~exist('h1_DC_Motor', 'var') || ...
        ~isgraphics(h1_DC_Motor, 'figure')
    h1_DC_Motor = figure('Name', 'DC_Motor');
end
figure(h1_DC_Motor)
clf(h1_DC_Motor)

simlog_w = out.simlog_DC_Motor.DC_Motor.w.series.values('rpm');
simlog_trq = out.simlog_DC_Motor.Inertia.t.series.values('N*m');

simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_w, simlog_trq, 'LineWidth', 1)
hold off
grid on
title('Motor Characteristics: Torque vs. Speed Curves')
ylabel('Torque (N*m)')
xlabel('Speed (RPM)')

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_w, simlog_trq.*simlog_w*2*pi/60, 'LineWidth', 1)
hold off
grid on
title('Motor Characteristics: Power vs. Speed ')
ylabel('Power (W)')
xlabel('Speed (RPM)')

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_w simlog_trq



