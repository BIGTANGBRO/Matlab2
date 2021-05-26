function [RL] = gen_RL(RL_filename, linename)

% Inputs: Filename (Coordinates of racing line)
% Outputs: Array of discretised sections


% Import data of racing line coordinates
RL_data = importdata(RL_filename);

% Form discretised racing line (~1m)
RL = zeros(1,2);
for i = 2:length(RL_data)
    clear space
    d = sqrt( ((RL_data(i,1) - RL_data(i-1,1)) * 111e3)^2 + ...
        ((RL_data(i,2) - RL_data(i-1,2)) * 70e3)^2 );
    space(:,1) = linspace(RL_data(i-1,1), RL_data(i,1), ceil(d)+1);
    space(:,2) = linspace(RL_data(i-1,2), RL_data(i,2), ceil(d)+1);
    
    RL = vertcat(RL,space);
    
end
RL(1,:) = []; % Delete first row of zeros

% Check for duplicated points
j = 1;
while j < length(RL)
    if RL(j,1) == RL(j+1,1) && RL(j,2) == RL(j+1,2)
        RL(j,:) = [];
    end
    j = j + 1;
end


% Determine angle between each discretised point
for i = 2:length(RL)
    RL(i,3) = sqrt( ((RL(i,1) - RL(i-1,1)) * 111e3)^2 + ...
        ((RL(i,2) - RL(i-1,2)) * 70e3)^2 );
    d = abs( ( RL(i,1) - RL(i-1,1) ) * 111e3);
    if RL(i,1) > RL(i-1,1) && RL(i,2) > RL(i-1,2) % Northeast
        RL(i,4) = real( asin(d/RL(i,3)) );
    elseif RL(i,1) > RL(i-1,1) && RL(i,2) < RL(i-1,2) % Northwest
        RL(i,4) = real( pi - asin(d/RL(i,3)) );
    elseif RL(i,1) < RL(i-1,1) && RL(i,2) < RL(i-1,2) % Southwest
        RL(i,4) = real( pi + asin(d/RL(i,3)) );
    elseif RL(i,1) < RL(i-1,1) && RL(i,2) > RL(i-1,2) % Southeast
        RL(i,4) = real( 2*pi - asin(d/RL(i,3)) );
    end
RL(1,3) = RL(2,3); RL(1,4) = RL(2,4);
    
    % Set zero angles to previous values
    if RL(i,4) == 0
        if RL(i,1) > RL(i-1,1) && RL(i,2) == RL(i-1,2) % North
            RL(i,4) = pi/2;
        elseif RL(i,1) < RL(i-1,1) && RL(i,2) == RL(i-1,2) % South
            RL(i,4) = 3*pi/2;
        elseif RL(i,1) == RL(i-1,1) && RL(i,2) > RL(i-1,2) % East
            RL(i,4) = 0;
        elseif RL(i,1) == RL(i-1,1) && RL(i,2) < RL(i-1,2) % West
            RL(i,4) = pi;
        end
    end
end

% Plot IRL
plot(RL(:,2),RL(:,1),'k-.', 'DisplayName',[linename]);


end

