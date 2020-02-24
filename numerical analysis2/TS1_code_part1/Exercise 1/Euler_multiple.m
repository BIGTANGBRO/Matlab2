% Script to implement Excplicit Euler to solve the model problem, namely  
% the initial value problem y' = l*y, y(0) = y0 
% 20/01/2019 Thulasi Mylvaganam 

close all; 
clear all; 

%% DEFINE PROBLEM  
l = -1;  % l corresponds to lambda in the lectures
y0 = 1;  % The initial value y(0) 
tf =25 ; % The final time (up to which we want to integrate the ODE)


%% PARAMETERS FOR THE NUMERICAL SOLUTION 
% The parameters (time step, etc) for the numerical solution. 
% Can be varied to explore the effects this has on accuracy and numerical
% stability  

h1 = 2 % uniform time step (delta t) STABLE (Maximum stepsize)

% To compare different time steps simultaneously, you may wish to add
% alternative time steps h2, h3, etc here and repeat the numerical solution
% loop for these (in the next block). Note you will have to give t and y a
% a different name to do this. 
h2 =1;   % uniform time step (delta t) STABLE (but not accurate) 
h3 = 2.1;   % uniform time step (delta t) UNSTABLE 
%% NUMERICAL SOLUTION (EXPLICIT EULER) 
% The array y_numi is the numerical solution of the equation corresponding
% to the time step hi 

%% Stepsize = h1 
% Initialise for numerical solution with time step h1 
y_num1(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num1 = 0:h1:tf;  % Time grid, starting at t = 0 to t = tf with uniform stepsize h1


for i = 1:length(t_num1) -1 
     ydot = l*y_num1(i); % The is the ODE (y' = l*y) 
     y_num1(i+1) = y_num1(i) + h1*ydot; % Euler method 
     t_num1(i+1) = t_num1(i)+h1; % Save "sample times" in an array 
end 
N1 = i+1; % Total number of steps (saved for plotting graphs later) 

% Plot numerical solution in red with stepsize = h1 
figure(1) 
hold on 
box on 
grid on 
plot(t_num1, y_num1, 'ro--','MarkerSize',10, 'LineWidth', 3)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
ylabel('y','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)


%% Stepsize = h2 
% Initialise for numerical solution with time step h2 
y_num2(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num2 = 0:h2:tf; % Time grid, starting at t = 0 to t = tf with uniform stepsize h2
i = 1; % initialise counter 


for i=1:length(t_num2)-1
     ydot = l*y_num2(i); % The is the ODE (y' = l*y) 
     y_num2(i+1) = y_num2(i) + h2*ydot; % Euler method 
     t_num2(i+1) = t_num2(i)+h2; % Save "sample times" in an array 

end 
N2 = i+1; % Total number of steps (saved for plotting graphs later) 
% Plot numerical solution corresponding to time step = h2 in blue
figure(1)
hold on 
grid on 
box on 
plot(t_num2, y_num2, 'bo--','MarkerSize',10, 'LineWidth', 3)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
ylabel('y','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)


%% Stepsize = h3 
% Initialise for numerical solution with time step h3
y_num3(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num3 = 0:h3:tf % Time grid, starting at t = 0 to t = tf with uniform stepsize h3



for  i=1:length(t_num3)-1 
     ydot = l*y_num3(i); % The is the ODE (y' = l*y) 
     y_num3(i+1) = y_num3(i) + h3*ydot; % Euler method 
     t_num3(i+1) = t_num3(i)+h3; % Save "sample times" in an array   
end 
N3 = i+1; % Total number of steps (saved for plotting graphs later) 
% Plot numerical solution corresponding to time step = h3 in magenta
figure(1) 
plot(t_num3, y_num3, 'mo--','MarkerSize',10, 'LineWidth', 3)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
ylabel('y','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
set(gca,'FontSize',30)
%% EXACT SOLUTION 
% The exact solution (known for the model problem) 
 y_sol = @(t) y0*exp(l*t) % this is the exact solution of the problem 
 N = 500; 
 t_exact = linspace(0, tf, N); % creates a vector of N time instants 
                               % (uniformly spaced) 
 y_exact = y_sol(t_exact)      % Samples of the exact solution  
 
 % Plot exact solution (in black) to compare with the numerical solutions
figure(1) 
plot(t_exact, y_exact, 'k','LineWidth',3)

%% COMPARE NUMERICAL AND EXACT SOLUTION 

g_error1 = abs(y_num1(1:N1)-y_sol(t_num1)); % error at each time step 
g_error2 = abs(y_num2(1:N2)-y_sol(t_num2)); % error at each time step 
g_error3 = abs(y_num3(1:N3)-y_sol(t_num3)); % error at each time step 
figure(3) 
grid on 
box on 
hold on 
plot(1:N1, g_error1, 'ro--','MarkerSize',10, 'LineWidth', 3)
plot(1:N2, g_error2, 'bo--','MarkerSize',10, 'LineWidth', 3)
plot(1:N3, g_error3, 'mo--','MarkerSize',10, 'LineWidth', 3)
xlabel('time step','interpreter', 'latex', 'fontsize', 30, 'Rotation', 0)
ylabel('local error','interpreter', 'latex', 'fontsize', 30, 'Rotation', 90)
set(gca,'FontSize',30)

