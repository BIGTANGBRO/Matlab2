% Script to implement Excplicit Euler to solve the model problem, namely  
% the initial value problem y' = l*y, y(0) = y0 
% 20/01/2019 Thulasi Mylvaganam 

%close all; 
clear all; 

%% DEFINE PROBLEM  
l = -1;  % l corresponds to lambda in the lectures
y0 = 1;  % The initial value y(0) 
tf = 50; % The final time (up to which we want to integrate the ODE)


%% PARAMETERS FOR THE NUMERICAL SOLUTION 
% The parameters (time step, etc) for the numerical solution. 
% Can be varied to explore the effects this has on accuracy and numerical
% stability  

h1 = 2% uniform time step (delta t)  
%h1 = 2.1;
% To compare different time steps simultaneously, you may wish to add
% alternative time steps h2, h3, etc here and repeat the numerical solution
% loop for these (in the next block). Note you will have to give t and y a
% a different name to do this. 

%% NUMERICAL SOLUTION (EXPLICIT EULER) 
% The array y is the numerical solution of the equation 

% Initialise 
y_num1(1) = y0; % Initial condition. Note MATLAB starts indexing with `1` 
t_num1(1) = 0;  % Initial time (t = 0 in this case) 

i = 1; % initialise counter 


while t_num1(i)<= tf 
     ydot = l*y_num1(i); % The is the ODE (y' = l*y) 
     y_num1(i+1) = y_num1(i) + h1*ydot; % Euler method 
     t_num1(i+1) = t_num1(i)+h1; % Save "sample times" in an array 
     
     i = i+1;     
end 

 % Plot numerical solution in red 
figure(1) 
hold on 
box on 
grid on 
plot(t_num1, y_num1, 'ro--','MarkerSize',10, 'LineWidth', 3)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('y','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)
%% EXACT SOLUTION 
% The exact solution (known for the model problem) 
 y_sol = @(t) y0*exp(l*t) % this is the exact solution of the problem 
 N = 500; 
 t_exact = linspace(0, tf, N); % creates a vector of N time instants 
                               % (uniformly spaced) 
 y_exact = y_sol(t_exact)      % Samples of the exact solution  
 
 % Plot exact solution (in blue) to compare with the numerical solution (in
 % red)
 
figure(1) 
plot(t_exact, y_exact, 'b','LineWidth',3)

