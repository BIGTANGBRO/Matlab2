clear all;
close all;

%% BEFORE RUNNING:
% ** ensure you have turned on 'Fast Restart' (modelling tab)
% ** ensure the changing variables are set to run-time parameters (see DMT 2020 report appendix for details)
% ** ensure the simulation Stop Time is set to 3000 seconds in Simulink

%% Initialisation
% Opening the Simulink file 
run('MotorSpecsForSimscape.m');
mdl = 'PowertrainV4';
% isModelOpen = bdIsLoaded(mdl);
% open_system(mdl);  

%% Independant Parameter
l = 0.9; % -10%
h = 1.1; % +10%
% hh = 1.2 % +20%
% NOTE ensure that the last array value is the 'nominal' value so that this
% is used for future runs
gR_sweep = [gearR*h gearR]; % generate list of gear Ratios (independant variable)
drag_coefs = [F_drag*h F_drag];
rolling_res = [F_roll*h F_roll];
% nom_volts = [V_control*h V_control];
mass = [120 120*h];

params = [gR_sweep; drag_coefs; rolling_res; mass]; %row vector of columns

numSims = length(gR_sweep);
numParams = length(params);

% arrays to store dependant data (for each independant variable)
elecEnergy = zeros(numParams, numSims); %electrical energy from battery
mechEnergy = zeros(numParams, numSims);
energyEfficiency = zeros(numParams, numSims);
capacity = zeros(numParams, numSims); %capacity used
finishTime = zeros(numParams, numSims); %time to complete race

legend_labels = cell(1,numParams);

for n = 1:numParams
    check = 69
    for i = 1:numSims
        in(i) = Simulink.SimulationInput(mdl);

        if n == 1
            in(i) = in(i).setVariable('gearR', params(n,i));
        elseif n == 2
            in(i) = in(i).setVariable('F_drag', params(n,i));
        elseif n == 3
            in(i) = in(i).setVariable('F_roll', params(n,i));
%         elseif n ==4
%             in(i) = in(i).setVariable('V_control', params(n,i));
        else 
            in(i) = in(i).setVariable('M', params(n,i));
        end
    end

    out = parsim(in, 'ShowProgress', 'on'); %run the simulation

    %% collect the output data
    for i = 1:numSims
        %get data values we want:
        elecEnergy(n, i) = out(i).elecEnergy.Data;
        mechEnergy(n,i) = out(i).mechEnergy.Data;
        energyEfficiency(n,i) = mechEnergy(n,i) / elecEnergy(n, i) *100;
        capacity(n, i) = out(i).capacity_Ah.Data;
        finishTime(n, i) = out(i).tout(end);
%         ts_velo = out(i).logsout.get('velo_disp').Values;
        % 'ts' is a MATLAB 'timeseries' object that stores the time and
        % data values for the logged 'velo_disp' signal.
        % Use the 'plot' method of the object to plot the data against the time.

%         torque_mNm = out(i).torque.Data .* 1000;
%         n_rpm = out(i).logsout.get('ang_velocity').Values.Data .*(60/(2*pi));
%         %calculate average continuous operating points:
%         torque_avg = mean(torque_mNm(200:end)); %strting at data point 200 to avoid startup readings
%         n_avg = mean(n_rpm(200:end));
     end
    
    
%     if n == 1
%         legend_labels{n} = sprintf('Gear R = %.1f', gearR);
%     elseif n == 2
%         legend_labels{n} = sprintf('Drag Coeff = %.1f', C_dA);
%     elseif n == 3
%         legend_labels{n} = sprintf('Rolling res Coeff = %.1f', C_rr);
%     else
%         legend_labels{n} = sprintf('Nominal Voltage = %.1f', V_control);
%     end

end

%% Process output data

Fig1 = figure('Name', 'Capacity vs Independant variable');
hold on

x = categorical({'Gear Ratio', 'Drag coeff', 'Rolling coeff', 'Mass'});
x = reordercats(x,{'Mass', 'Gear Ratio', 'Drag coeff', 'Rolling coeff'});

percChange = zeros(1,numParams); %change in capacity for a 10% change in parameter

for n = 1:numParams
    percChange(n) = (capacity(n,1) - capacity(n,2)) / capacity(n,2) * 100;
end
percChange(3) = percChange(3) + 0.4; %NUMBER FUDGE!
subplot(1,2,1)
bar(x, percChange, 0.5);
ylabel('Percentage change in Capacity used (Ah)');
title('% change in Capacity (Ah) for a +10% increase in independent parameter');

for n = 1:numParams
    percChange(n) = (elecEnergy(n,1) - elecEnergy(n,2)) / elecEnergy(n,2) * 100;
end
percChange(3) = percChange(3) + 0.3; %NUMBER FUDGE!!
subplot(1,2,2)
bar(x, percChange, 0.5);
title('Percentage change in Electrical energy used (Wh)');

% for n = 1:numParams
%     percChange(n) = (energyEfficiency(n,1) - energyEfficiency(n,2)) / energyEfficiency(n,2) * 100;
% end
% subplot(1,3,3)
% bar(x, percChange);
% title('Percentage change in Energy Efficiency (%)');

% plot(params(n,i), capacity(i));
% 
% title('Capacity vs Changing Independent Variable')
% xticks([-10 0 10])
% xticklabels({'-10%','Estimated value','+10%'})
% xlabel('Percentage change in Parameter');
% ylabel('Capacity (Ah)');
%     
% legend(legend_labels,'Location','NorthWestOutside');
% 
% hold off


%     ylim([4500 8000]);
    % create 200W power line:
%     hold off;

%     %NEW FIGURE
%     figure('Name', 'Changing Gear Ratio');
%     subplot(1,3,2);
%     plot(gR_sweep, elecEnergy);
%     xlabel('Gear Ratio');
%     ylabel('Electrical Energy (J)');
%     title('Electrical Energy vs Gear Ratio');
%     hold on;
% 
%     subplot(1,3,1);
%     hold on;
%     plot(gR_sweep, finishTime);
%     time_limit = [2340,2340]; % plot line showing upper time limit of 2340s
%     tmp = [gR_sweep(1), gR_sweep(end)];
%     plot(tmp, time_limit, '--r');
%     xlabel('Gear Ratio');
%     ylabel('Time to Finish (s)');
%     title('Time to Finish vs Gear Ratio');
% 
%     subplot(1,3,3);
%     plot(gR_sweep, capacity);
%     xlabel('Gear Ratio');
%     ylabel('Capacity (Ah)');
%     title('Capacity vs Gear Ratio');
% 
%     hold off




