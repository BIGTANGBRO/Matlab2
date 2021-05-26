function [path, RL_all] = gen_path(t, laps, RL, acc, vel)

% Inputs: t (time array), laps (no. of laps), strat (strategy no.), RL (Racing line array)
% Output: path (path array), RL_all (racing line coordinates of all laps)

% Create huge array for all laps
RL_all = zeros(1,4);
for k = 1:laps
    RL_all = [RL_all; RL];
end
RL_all(1,:) = []; % Delete first row of zeros


path = zeros(length(t), 9);
path(:,1) = t;

path(1,8) = RL_all(1,1);
path(1,9) = RL_all(1,2);


% strat = 1;

% Formulate path
for i = 2:length(t)
    
    % Strat 1: Constant acceleration of 7ms-1, maintain constant
    % velocity throughout all straights & corners
%     switch strat
%         case 1
% %             if t(i) < 2
% %                 vel = path(i-1,3);
% %             if t(i) <= 2
% %                 path(i,2) = 3.5; % a
% %             else
% %                 path(i,2) = 0;
% %             end
%             path(i,3) = path(i-1,3) + ( path(i,2) * ( path(i,1)-path(i-1,1) ) ); % v = u + at
%             path(i,4) =( path(i-1,3)*( path(i,1)-path(i-1,1) ) ) + ...
%                 ( 0.5*path(i,2)*( path(i,1)-path(i-1,1) )^2 ); % ds = u dt + 0.5a (dt)^2
%             path(i,5) = path(i-1,5) + path(i,4); % s_cul = s_prev + ds
%     end
    
    path(:,2) = acc; path(:,3) = vel; % Adding in acc and vel data from Simulink simulation
    
%     path(i,3) = path(i-1,3) + ( path(i,2) * ( path(i,1)-path(i-1,1) ) ); % v = u + at
    path(i,4) =( path(i-1,3)*( path(i,1)-path(i-1,1) ) ) + ...
                ( 0.5*path(i,2)*( path(i,1)-path(i-1,1) )^2 ); % ds = u dt + 0.5a (dt)^2
    path(i,5) = path(i-1,5) + path(i,4); % s_cul = s_prev + ds
    
    % Strat 2:
    
    

    % Calculate position of car wrt sector minor    
    pos = 1; lap = floor(path(i,5)/sum(RL(:,3)));
    d = path(i,5) - (lap*sum(RL(:,3))) - RL_all(pos,3);
    while d > 0 && pos < length(RL_all)-1
        d = d - RL_all(pos,3);
        pos = pos + 1;
    end
    
    % Check for completion of one lap
    spe_i = 0;
    if path(i,5) > 1 && mod(path(i,5),sum(RL(:,3))) < 1
        pos = 1;
        path(i,8) = RL(1,1);
        path(i,9) = RL(1,2);
        spe_i = i;
        fprintf('%d laps completed in %.2fs \n', [lap, path(i,1)])
    end
    
    % Calculate dx and dy
    path(i,6) = path(i,4) * cos(RL_all(pos,4)) / 70e3; % Delta x
    path(i,7) = path(i,4) * sin(RL_all(pos,4)) / 111e3; % Delta y
    
    if i ~= spe_i % Non-coincindental with start/finish line
        path(i,8) = path(i-1,8) + path(i,7); % Change in latitude (y)
        path(i,9) = path(i-1,9) + path(i,6); % Change in longitude (x)
    end
    
    
end



end

