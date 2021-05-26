function [ani] = gen_ani(path, para, rate)
% Inputs: path (path array)
% Outputs: Animation

hold on;

s1 = subplot(2,4, [1 5]);
% s1.Position = s1.Position + [0 -0.5 0 2];
ani = animatedline('Marker','.', 'MarkerSize', 15);
% ani = animatedline(path(:,9), path(:,8), 'Color', 'k', 'Marker','x');
axis([-0.4705, -0.467, 51.3485, 51.3545])
% xlim([-0.4705 -0.467]); ylim([51.3485 51.3545])
pbaspect([1 1.5857 1])

subplot(2,4,2)
title('Distance covered')
xlim([0 max(path(:,1))]); ylim([0 max(path(:,5))])
xlabel('Time / s'); ylabel('Distance / m'); grid on;
dist_ani = animatedline('LineWidth', 1.5);

subplot(2,4,6)
title('Velocity')
xlim([0 max(path(:,1))]); ylim([0 max(path(:,3))])
xlabel('Time / s'); ylabel('Velocity / m/s'); grid on;
vel_ani = animatedline('LineWidth', 1.5);

subplot(2,4,3)
title('Input Voltage')
xlim([0 max(path(:,1))]); ylim([0 max(para(:,1))])
xlabel('Time / s'); ylabel('Input Voltage / V'); grid on;
vol_ani = animatedline('LineWidth', 1.5);

subplot(2,4,4)
title('Power consumed')
xlim([0 max(path(:,1))]); ylim([0 max(para(:,2))])
xlabel('Time / s'); ylabel('Power Consumed / W'); grid on;
epow_ani = animatedline('LineWidth', 1.5);

subplot(2,4,7)
title('Capacity')
xlim([0 max(path(:,1))]); ylim([0 max(para(:,4))])
xlabel('Time / s'); ylabel('Capacity / %'); grid on;
cap_ani = animatedline('LineWidth', 1.5);

subplot(2,4,8)
title('Energy Consumption')
xlim([0 max(path(:,1))]); ylim([0 max(para(:,3))])
xlabel('Time / s'); ylabel('Energy Consumption / Wh'); grid on;
cap_ani = animatedline('LineWidth', 1.5);


a = tic; % Timer
for i = 1:length(path)
    clearpoints(ani); delete(findall(gcf,'type','annotation'));
    addpoints(ani, path(i,9), path(i,8))
    addpoints(dist_ani, path(i,1), path(i,5));
    addpoints(vel_ani, path(i,1), path(i,3));
    addpoints(vol_ani, path(i,1), para(i,1));
    addpoints(epow_ani, path(i,1), para(i,2));
    addpoints(cap_ani, path(i,1), para(i,3));


    annotation('textbox',[.15 .4 .3 .3],'String',['t = ' num2str(path(i,1)) ' s'],'FitBoxToText','on');
    annotation('textbox',[.15 .35 .3 .3],'String',['v = ' num2str(path(i,3)) ' m/s'],'FitBoxToText','on');
    
    switch rate
        case 0 % Fast
            drawnow limitrate;
        case 1 % Real-time
            drawnow;
            pause(0.1);
    end
    
    if path(i,1) > 2 && path(i,3) <= 0
        break
    end
    
end
drawnow;

