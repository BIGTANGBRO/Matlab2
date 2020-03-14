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

plot(SimTimeManual,SimAltitudeManual,'r');
hold on
plot(SimTimeControl,SimAltitudeControl,'g');
hold on
plot(SimTimeAuto,SimAltitudeAuto,'b');
grid on
xlabel('time');
ylabel('Altitude');
legend('Manual','Augmented Manual','Automatic');
hold off

plot(SimTimeManual,SimDeviationManual,'r');
hold on
plot(SimTimeControl,SimDeviationControl,'g');
hold on
plot(SimTimeAuto,SimDeviationAuto,'b');
xlabel('time');
ylabel('Deviation')
legend('Manual','Augmented Manual','Automatic');
grid on
hold off

