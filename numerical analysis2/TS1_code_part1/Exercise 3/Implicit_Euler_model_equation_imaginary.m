% Script to implement Excplicit Euler to solve the model problem, namely  
% the initial value problem y' = f(y,t), y(0) = y0 
% 20/01/2019 Thulasi Mylvaganam 

close all; 
clear all; 

%% DEFINE PROBLEM  

y0 = 10;  % The initial value y(0) 
tf = 20; % The final time (up to which we want to integrate the ODE)
% Below, we specify the ODE 
% Here we define the model problem  y' = ly 
l =i;   % Here we specify l to be imaginary 
        % (hence, we know Explicit Euler will be unstable)
        % You can experiment with changing l to see when we have numerical
        % stability and we we don't. 

%% PARAMETERS FOR THE NUMERICAL SOLUTION 
% The parameters (time step, etc) for the numerical solution. 
% Can be varied to explore the effects this has on accuracy and numerical
% stability  

h1 = 1 % uniform time step 
h2 = 0.1; % uniform time step 


%% NUMERICAL SOLUTION (EXPLICIT EULER) 
% The array y is the numerical solution of the equation 

%% spte size = h1 
% Initialise 
y_num1(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num1 = 0:h1:tf;  % Initial time (t = 0 in this case) 


for i = 1:length(t_num1)     
    t_num1(i+1) = t_num1(i)+h1; % Save "sample times" in an array 
    % Implicit euler: y_i+1 = y_i + hf(y_i+1, t_i+1) 
    % In this case y' = l*y 
    % Thus, to determine y_i+1 we have to solve the following equation
     y_num1(i+1) = ((1-h1*l)^-1)*y_num1(i); % Euler method  
end 

% Plot numerical solution in red 
figure(1) 
hold on 
box on 
grid on 
plot3(t_num1, real(y_num1), imag(y_num1), 'ro--','MarkerSize',10, 'LineWidth', 3)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
ylabel('$real(y)$','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
zlabel('$imag(y)$','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
set(gca,'FontSize',30)

%% spte size = h2 
% Initialise 
clearvars y_num1 t_num1 
y_num1(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num1 = 0:h2:tf;  % Initial time (t = 0 in this case) 


for i = 1:length(t_num1)     
    t_num1(i+1) = t_num1(i)+h2; % Save "sample times" in an array 
    % Implicit euler: y_i+1 = y_i + hf(y_i+1, t_i+1) 
    % In this case y' = l*y 
    % Thus, to determine y_i+1 we have to solve the following equation
     y_num1(i+1) = ((1-h2*l)^-1)*y_num1(i); % Euler method  
end 

% Plot numerical solution in red 
figure(1) 
hold on 
box on 
grid on 
plot3(t_num1, real(y_num1), imag(y_num1), 'bo--','MarkerSize',10, 'LineWidth', 3)

%% EXACT SOLUTION 
% The exact solution (known for the model problem) 
 y_sol = @(t) y0*exp(l*t) % this is the exact solution of the problem 
 N = 1000; 
 t_exact = linspace(0, tf, N); % creates a vector of N time instants 
                               % (uniformly spaced) 
 y_exact = y_sol(t_exact)      % Samples of the exact solution  
 
 % Plot exact solution (in blue) to compare with the numerical solution (in
 % red)
 
figure(1) 
plot3(t_exact, real(y_exact), imag(y_exact), 'k','LineWidth',3)


