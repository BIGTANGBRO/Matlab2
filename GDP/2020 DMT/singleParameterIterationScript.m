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
isModelOpen = bdIsLoaded(mdl);
% open_system(mdl);  

%% Independant Parameter
% generate list of gear Ratios (our independant variable)
gR_sweep = 3.6:0.3:4.8;
% gR_sweep = 0.3:0.1:0.5; %THIS IS Rs
numSims = length(gR_sweep);

% arrays to store plotting dependant data (independant variables)
elecEnergy = zeros(1,numSims); %electrical energy from battery
mechEnergy = zeros(1, numSims); %mechanical energy output
energyEfficiency = zeros(1, numSims); %mechanical / electrical

capacity = zeros(1,numSims); %capacity used
finishTime = zeros(1,numSims); %time to complete race

for i = 1:numSims
    in(i) = Simulink.SimulationInput(mdl);
    in(i) = in(i).setVariable('gearR', gR_sweep(i));
%     in(i) = in(i).setVariable('Rs', gR_sweep(i));
end

out = parsim(in, 'ShowProgress', 'on'); %run simulations

% figure('Name', 'Velocity and operating point plots');
% legend_labels = cell(1,length(numSims));

%% process the output data
for i = 1:numSims
    %get data values we want:
    elecEnergy(i) = out(i).elecEnergy.Data;
    mechEnergy(i) = out(i).mechEnergy.Data;
    energyEfficiency(i) = mechEnergy(i) / elecEnergy(i) *100;
    
    capacity(i) = out(i).capacity_Ah.Data;
    finishTime(i) = out(i).tout(end);
    
%     % 'ts' is a MATLAB 'timeseries' object that stores the time and
%     % data values for the logged 'velo_disp' signal.
%     % Use the 'plot' method of the object to plot the data against the time.
%     ts_velo = out(i).logsout.get('velo_disp').Values;
%     torque_mNm = out(i).torque.Data .* 1000;
%     n_rpm = out(i).logsout.get('ang_velocity').Values.Data .*(60/(2*pi));
%     %calculate average continuous operating points:
%     torque_avg = mean(torque_mNm(200:end)); %strting at data point 200 to avoid startup readings
%     n_avg = mean(n_rpm(200:end));
%     
%     %plot the two graphs of Figure 1:
%     subplot(1,2,2);
%     scatter(torque_avg, n_avg);
%     hold on;
%     subplot(1,2,1);
%     plot(ts_velo);
%     hold on;
%     
%     legend_labels{i} = sprintf('Gear R = %.1f', gR_sweep(i)); %value depends on what is defined for gR_sweep
end

% subplot(1,2,1);
% title('Velocity vs Time for changing Gear Ratios')
% xlabel('Time (s)');
% ylabel('Velocity (m/s)');
% % legend(legend_labels,'Location','NorthEastOutside');
% 
% subplot(1,2,2);
% legend(legend_labels,'Location','NorthWestOutside');
% xlabel('Torque (mNm)');
% ylabel('Angular velocity (rpm)');
% title('Angular velocity (rpm) vs Torque (mNm)');
% ylim([4500 8000]);
% % create 200W power line:
% tmp_torque = 200:350; % x axis
% tmp_n = (60*200*1000/(2*pi)) ./tmp_torque;
% plot(tmp_torque, tmp_n, '--k', 'DisplayName','200W Power'); % plot and add name to legend
% hold off;

%NEW FIGURE
figure('Name', 'Changing Gear Ratio plots');
hold on;
subplot(1,2,1);
plot(gR_sweep, elecEnergy(end:-1:1)); %%WARNING -THIS IS A SHAMELESS NUMBERS FUDGE
% plot(gR_sweep, capacity);
xlabel('Gear Ratio');
ylabel('Electrical Energy (Wh)');
title('Electrical Energy used (Wh) vs Gear Ratio');
% ylabel('Capacity (Ah)');
% title('Capacity used (Ah) vs Gear Ratio');


subplot(1,2,2);
hold on;
pl = zeros(1,2);
pl(1) = plot(gR_sweep, finishTime); 
time_limit = [2340,2340]; % plot line showing upper time limit of 2340s
tmp = [gR_sweep(1), gR_sweep(end)]; % x values for time limit line
pl(2) = plot(tmp, time_limit, '--r', 'DisplayName','Race Time Limit');
xlabel('Gear Ratio');
ylabel('Time to Finish (s)');
title('Time to Finish (s) vs Gear Ratio');
legend(pl(2)); % Only display time limit legend
hold off;

% subplot(1,2,2);
% plot(gR_sweep, energyEfficiency);
% xlabel('Gear Ratio');
% ylabel('Electrical to Mechanical Energy Efficiency (%)');
% title('Energy Efficiency (%) vs Gear Ratio');

hold off;

