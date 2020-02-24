function [ ] = main
% Call a numerical method (or methods) to obtain a numerical solution of 
% the scalar ode in Exercise 6, Tutorial Sheet 1
% Dr Thulasi Mylvaganam, 02/2019 
clear all; 
close all; 

%% Define problem 
A = [ 0 1; -1 0]; % Define the problem y' Ay, where y is a 2D vector 

[P Lambda] =eig(A); % Compute eigenvectors and eigenvalues of A 
                % This command gives P and Lambda (matrix of eigenvectors and eigenvalues)  

test = A - P*Lambda*inv(P)% You can verify that A = P^-1 Lambda P , but this step is not necessary 

y0 = [10; 1] % Initial condition of y 

%% Change of coordinates 

z0 = inv(P)*y0 % Compute the corresponding initial value of z (given the initial condition of y) 

% This change of coordinates yields two uncoupled scalar ODEs 

f1 = @(t,z1) Lambda(1,1)*z1 % the first ODE z1'=lambda1*z1 

f2 = @(t,z2) Lambda(2,2)*z2 % the first ODE z2'=lambda1*z2
 

%% Call another numerical method to solve the two ODEs separately 
h = .1; % stepsize 
tspan = [0 50]; 

[t, z1] = RungeKutta4(f1,tspan,z0(1),h); % solve the first ODE 
[t, z2] = RungeKutta4(f2,tspan,z0(2),h); % solve the second ODE 

% Reconstruct a numerical solution for y from the numerical solutions of z 
z = [z1; z2]; 
y = P*z; 

% Plot result 
figure(1) 
subplot(2,1, 1)
hold on 
box on 
grid on 
plot(t, real(y(1, :)), 'bo--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in blue (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y_1$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)

subplot(2,1, 2)
hold on 
box on 
grid on 
plot(t, real(y(2, :)), 'bo--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in blue (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y_2$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)



figure(2) 
hold on 
box on 
grid on 
scatter3(t, real(y(1, :)), real(y(2, :)), 'b') % Plot numerical solution in blue(circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y_1$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
zlabel('$y_2$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)

%% Call a numerical method to solve the two ODEs separately 
clearvars z1, z2, t, y 
h = 1; % stepsize 
tspan = [0 50]; 
[t, z1] = RungeKutta4(f1,tspan,z0(1),h); % solve the first ODE 
[t, z2] = RungeKutta4(f2,tspan,z0(2),h); % solve the second ODE 

% Reconstruct a numerical solution for y from the numerical solutions of z 
z = [z1; z2]; 
y = P*z; 

% Plot result 
figure(1) 
subplot(2,1, 1)
hold on 
box on 
grid on 
plot(t, real(y(1, :)), 'ro--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in blue (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y_1$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)

subplot(2,1, 2)
hold on 
box on 
grid on 
plot(t, real(y(2, :)), 'ro--','MarkerSize',10, 'LineWidth', 3) % Plot numerical solution in blue (circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y_2$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)



figure(2) 
hold on 
box on 
grid on 
scatter3(t, (y(1, :)), (y(2, :)), 'r') % Plot numerical solution in blue(circular markers)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('$y_1$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
zlabel('$y_2$','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
set(gca,'FontSize',30)


end 
