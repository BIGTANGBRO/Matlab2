function [ ] = main
% Call various numerical solvers to obtain a numerical solution of 
% the scalar ode in Exercise 4, Tutorial Sheet 1
% Dr Thulasi Mylvaganam, 02/2019 

%% Define problem 
omega = 2; 
f = @(t,x) -x + sin(omega*t)% Define the function f 
tf = 20 % final time 
tspan = [0, tf] % define time span 
h = 2; % Stepsize 
y0 = 10; 

%% Call explicit Euler to generate solution with large stepsize 
[t,y] = explicitEuler(f,tspan,y0,h)

% Plot result 
figure(1) 
hold on 
box on 
grid on 
plot(t, y, 'ro--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in red (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)

%% Call explicit Euler again with smaller stepsize 
h = 0.5
clearvars t y % Clear t and y to store the new numerical solution 

[t,y] = explicitEuler(f,tspan,y0,h)
figure(1) 
plot(t, y, 'go--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in green (circular markers)

%% Call 4th-order Runge-Kutta  with large stepsize 
h = 0.5
clearvars t y % Clear t and y to store the new numerical solution 

[t,y] = RungeKutta4(f,tspan,y0,h)
figure(1) 
plot(t, y, 'bs--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in blue (square marker)
figure(2) 
hold on 
box on 
grid on 
plot(t(1:floor(length(t)/4)), y(1:floor(length(t)/4)), 'bs--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in red (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)
%% Call explicit Euler again with even stepsize 
h = 0.1
clearvars t y % Clear t and y to store the new numerical solution 

[t,y] = explicitEuler(f,tspan,y0,h)
figure(2) 
plot(t(1:floor(length(t)/4)), y(1:floor(length(t)/4)), 'mo--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in magenta (circulal marker)
end

