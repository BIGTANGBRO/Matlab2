clear
clc

%%Nyquist plot
inphaseA=load("inphase_A.mat");
inphaseA=table2array(inphaseA.vibrationlabS2);
inphaseD=load("inphase_D.mat");
inphaseD=table2array(inphaseD.vibrationlabS2);
inphaseV=load("inphase_V.mat");
inphaseV=table2array(inphaseV.vibrationlabS2);
outofphaseA=load("outofphase_A.mat");
outofphaseA=table2array(outofphaseA.vibrationlabS2);
outofphaseD=load("outofphase_D.mat");
outofphaseD=table2array(outofphaseD.vibrationlabS2);
outofphaseV=load("outofphase_V.mat");
outofphaseV=table2array(outofphaseV.vibrationlabS2);

X_A=load("X_A.mat");
X_A=table2array(X_A.vibrationlabS2);
Y_A=load("Y_A.mat");
Y_A=table2array(Y_A.vibrationlabS2);

X_V=load("X_V.mat");
X_V=table2array(X_V.vibrationlabS2);
Y_V=load("Y_V.mat");
Y_V=table2array(Y_V.vibrationlabS2);

X_D=load("X_D.mat");
X_D=table2array(X_D.vibrationlabS2);
Y_D=load("Y_D.mat");
Y_D=table2array(Y_D.vibrationlabS2);

frequency=load('fre.mat');
frequency=table2array(frequency.vibrationlabS2);

plot(inphaseA,outofphaseA,'b.-');
hold on
plot(X_A,Y_A,'k-');
grid on
title("Polar accleration plot");
xlabel('In phase');
ylabel('Out of phase');
hold off

plot(inphaseV,outofphaseV,'r.-');
hold on
plot(X_V,Y_V,'k-');
grid on
title("Polar velocity plot");
xlabel('In phase');
ylabel('Out of phase');
hold off

plot(inphaseD,outofphaseD,'g.-');
hold on
plot(X_D,Y_D,'k-');
grid on
title("Polar displacement plot");
xlabel('In phase');
ylabel('Out of phase');
hold off
%%
%%response plot
amp_A=load("amp_A.mat");
amp_A=table2array(amp_A.vibrationlabS2);

amp_V=load("amp_V.mat");
amp_V=table2array(amp_V.vibrationlabS2);

amp_D=load("amp_D.mat");
amp_D=table2array(amp_D.vibrationlabS2);

plot(frequency,amp_A,'b.-');
grid on
title("Accleration");
xlabel('Frequency(rad/s)');
ylabel('Magitude');

plot(frequency,amp_V,'r.-');
grid on
title("Velocity");
xlabel('Frequency(rad/s)');
ylabel('Magitude');

plot(frequency,amp_D,'g.-');
grid on
title("Displacement");
xlabel('Frequency(rad/s)');
ylabel('Magitude');
%%
%%Phase plot
phase_A=load('phase_A.mat');
phase_A=table2array(phase_A.vibrationlabS2);

phase_V=load('phase_V.mat');
phase_V=table2array(phase_V.vibrationlabS2);

phase_D=load('phase_D.mat');
phase_D=table2array(phase_D.vibrationlabS2);

plot(frequency,phase_A,'b.-');
hold on
plot(frequency,phase_V,'r*-');
hold on
plot(frequency,phase_D,'go-');
grid on
xlabel('Frequency(rad/s)');
ylabel('Phase/rad');
legend('Acceleration','Velocity','Displacement');
hold off
























