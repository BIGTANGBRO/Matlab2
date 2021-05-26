
a = csvread('drivingStrategy.csv'); %get throttle control data

%% motor characteristics
V_control = 24; % motor controller output voltage
nlc = 0.236; % no load current
R = 0.103; % motor internal resistance
L = 0.072e-3; % motor inductance
K = 0.0385; % motor constant
J = 5.48e-5; % motor inertia
b = K*nlc*60/(2*pi*5950)*10; % viscous damping (calcuated using no load speed values)
b = b +0.0001; %include the transmission viscous losses

%% Battery Model Parameters
V0 = 53.3; % full charge voltage (nominal = 46.8V)
AH0 = 6; % full charge capacity Ah (adjusted to match experimental battery discharge curves)
V1 = 47.8; % voltage at charge level AH1 ----- (using 3.4V at 2Ah capcaity)
AH1 = 3.1; % measured charge level at given voltage V1
Rs = 0.4; % series internal reisistance

%% other key parameters
gearR = 46/11; % exact
M = 120; % total vehicle plus driver mass
F_roll = 120 * 9.81 * 0.005; % (N) 120 kg mass estimate
F_drag = 0.5*1.2*0.089*0.42; % (N per (m/s)^2) - drag force = 0.5 * (density=1.2) * C_d * A * velo^2

startup_t = 50; %time taken to ramp up the input voltage to max





