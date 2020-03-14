%pilot diagram
clear 
clc

load('manual_log2.1.mat')
SimTimeManual = SimTime;
SimAltitudeManual = SimAltitude;
SimDeviationManual = SimDeviation;


load('control_variables2.4.mat')
SimTimeControl = SimTime;
SimAltitudeControl = SimAltitude;
SimDeviationControl = SimDeviation;

load('autopilot_variables2.5.mat')
SimTimeAuto = SimTime;
SimAltitudeAuto = SimAltitude;
SimDeviationAuto = SimDeviation;

plot(SimTimeManual,SimAltitudeManual);
hold on
plot(SimTimeControl,SimAltitudeControl);
hold on
plot(SimTimeAuto,SimAltitudeAuto);
hold off

plot(SimTimeManual,SimDeviationManual);
hold on
plot(SimTimeControl,SimDeviationControl);
hold on
plot(SimTimeAuto,SimDeviationAuto);
hold off

