function [ ] = main
% Call trapezoidal method to obtain a numerical solution of 
% the scalar ode in Exercise 5, Tutorial Sheet 1
% Dr Thulasi Mylvaganam, 02/2019 

%% Define problem 
R = 100e3; 
C = 100e-6; 
Vin = @(t) sin(t) + 0.5*sin(400*t); 

% d(Vout)/dt = Vin/RC - Vout/RC = f(t, Vout) 
f = @(t,Vout)  Vin(t)/(R*C) - Vout/(R*C);% Define the function f 
tf = 50 % final time 
tspan = [0, tf] % define time span 

Vout_0 = 10; % Initial condition 

%% Call trapezoidal method to run with a "large" stepsize 
h = 10; % Stepsize 
[t,Vout] = trapezoidal(f,tspan,Vout_0,h)

% Plot result 
figure(1) 
hold on 
box on 
grid on 
plot(t, Vout, 'ro--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in red (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)

%% Call trapezoidal method to solve with a "very small" stepsize 

h = .1 % stepsize 
clearvars t Vout % Clear t and y to store the new numerical solution 

[t,Vout] = trapezoidal(f,tspan,Vout_0,h)

figure(1) 
plot(t, Vout, 'go--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in green (circular markers)
%% Call trapezoidal method to solve with an "small" stepsize 

h = 2 % stepsize 
clearvars t Vout % Clear t and y to store the new numerical solution 

[t,Vout] = trapezoidal(f,tspan,Vout_0,h)

figure(1) 
plot(t, Vout, 'bo--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in blue (circular markers)

figure(2) 
hold on 
box on 
grid on 
plot(t, Vout, 'bo--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in blue (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)

%% Call 4th-order Runge-Kutta  with the "small" stepsize 
h = 2
clearvars t Vout % Clear t and y to store the new numerical solution 
[t,Vout] = RungeKutta4(f,tspan,Vout_0,h)
figure(2) 
plot(t, Vout, 'ks--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in black (square marker)
figure(2) 
hold on 
box on 
grid on 

%% Call explicit Euler again with even stepsize 
h = 2
clearvars t y % Clear t and y to store the new numerical solution 

[t,Vout] = explicitEuler(f,tspan,Vout_0,h)
figure(2) 
plot(t, Vout, 'ms--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in magenta (square marker)
end

