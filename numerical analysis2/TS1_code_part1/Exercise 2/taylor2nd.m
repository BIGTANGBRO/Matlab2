% Script to implement the second order Taylor series method and explicit 
% Euler to solve the model problem, namely the initial value problem
% y' = l*y, y(0) = y0 
% 20/01/2019 Thulasi Mylvaganam 

close all; 
clear all; 

%% DEFINE PROBLEM  
l = -1;  % l corresponds to lambda in the lectures
y0 = 1;  % The initial value y(0) 
tf =25 ; % The final time (up to which we want to integrate the ODE)

h = 0.5 % Step size for numerical schemes 

%% Numerical solution using 2nd order Taylor series method 


% Initialise for numerical solution using explicit Euler 
y_num1(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num1 = 0:h:tf;  % Time grid, starting at t = 0 to t = tf with uniform stepsize h1


for i = 1:length(t_num1) -1 
     y_num1(i+1) = y_num1(i) + h*l*y_num1(i) + ((h^2)/2)*(l^2)*y_num1(i); % second order Taylor series method  
     t_num1(i+1) = t_num1(i)+h; % Save "sample times" in an array 
end 
N1 = i+1; % Total number of steps (saved for plotting graphs later) 

% Plot numerical solution in red with stepsize = h1 
figure(1) 
hold on 
box on 
grid on 
plot(t_num1, y_num1, 'bo--','MarkerSize',10, 'LineWidth', 3)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
ylabel('$y$','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
 set(gca,'FontSize',30)
%% Numerical solution using explicit Euler (with same step size) 

% Initialise for numerical solution using explicit Euler 
y_num2(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num2 = 0:h:tf;  % Time grid, starting at t = 0 to t = tf with uniform stepsize h1


for i = 1:length(t_num1) -1 
     ydot = l*y_num2(i); % The is the ODE (y' = l*y) 
     y_num2(i+1) = y_num2(i) + h*ydot; % Euler method 
     t_num2(i+1) = t_num2(i)+h; % Save "sample times" in an array 
end 
N1 = i+1; % Total number of steps (saved for plotting graphs later) 

% Plot numerical solution in red with stepsize = h1 
figure(1) 
hold on 
box on 
grid on 
plot(t_num2, y_num2, 'ro--','MarkerSize',10, 'LineWidth', 3)




%%  Exact solution 
% The exact solution (known for the model problem) 
 y_sol = @(t) y0*exp(l*t) % this is the exact solution of the problem 
 N = 500; 
 t_exact = linspace(0, tf, N); % creates a vector of N time instants 
                               % (uniformly spaced) 
 y_exact = y_sol(t_exact)      % Samples of the exact solution  
 
 % Plot exact solution (in black) to compare with the numerical solutions
figure(1) 
plot(t_exact, y_exact, 'k','LineWidth',3)