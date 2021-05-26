close all;
%% initialisation
run('MotorSpecsForSimscape.m'); % parameter values

% sim function arguments contained within parameters struct:
paramNameValStruct.TimeOut = 15; % if the execution gets stuck, end sim after 10 seconds

% run simulation using parameters struct to configure the model
out = sim('PowertrainV4.slx', paramNameValStruct); 

% torque_mNm = getdatasamples(simOut.Torque, :) .* 1000;
torque_mNm = out.torque.Data .* 1000;
n_rpm = out.logsout.get('ang_velocity').Values.Data .*(60/(2*pi));

velo = out.logsout.get('velo_disp').Values.Data;
avgerageVelocity = mean(velo);

%get key data values
capacity_Ah = out.capacity_Ah.Data;
elecEnergy_Wh = out.elecEnergy.Data;
mechEnergy_Wh = out.mechEnergy.Data;
elecToMechEfficiency = (mechEnergy_Wh / elecEnergy_Wh) *100;

curr = out.logsout.get('current_disp').Values.Data;
averageCurrent_A = mean(curr);

distance_m = out.finalDist.Data;
finishTime_s = out.tout(end);
avgerageElecPower_W = elecEnergy_Wh * 3600 / finishTime_s;


figure('Name', 'Motor Speed vs Torque');
n = 200;
plot(torque_mNm, n_rpm);
% plot(torque_mNm(n:end), n_rpm(n:end)); % start at n to remove initial startup readings
xlabel('Torque (mNm)');
ylabel('Motor Speed (rpm)');

% simOut = sim('PowertrainV1.slx');


%% create a table summarising plots:
T=table(finishTime_s, avgerageVelocity, averageCurrent_A, avgerageElecPower_W, capacity_Ah, elecEnergy_Wh, elecToMechEfficiency)

import mlreportgen.dom.*;
T.Style = {
    RowHeight('0.75in'), ...
    Border('solid','Green','6pt'), ...
    ColSep('double','DarkGreen','3pt'), ...
    RowSep('single','DarkGreen')};

% n=linspace(nls,0,10)'; %rotational speed
% I=linspace(nlc,sC,10)'; %current
% T=linspace(0,sT,10)'; %torque
% P_mech=n.*T;
% P_elec=I*24;
% eff=(P_mech./P_elec)*100;

% T=table(T,n,I,P_elec,P_mech,eff)
