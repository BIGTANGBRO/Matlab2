%Script that solves the ODE -p'=2pa+q-(b^2/r)p^2  using explicit Euler and
%4th-order Runge-Kutta.
%It then goes on to solve the ODE x'=ax-(b^2/r)px. 
%Script is taken from Dr Mylvaganam's solutions to Tutorial 1 and adjusted
%according to answer the coursework questions
%Date: 28/03/2020
%clear workspace and screen
clear
clc
close all 

%% Define problem

%Define constants 
a=1;
b=0.5;
q=1;
r=1;
s=10;
 
%Parameters of numerical scheme
f=@(t,p) 2*p*a+q-(b^2/r)*p^2; %Define derivative -p'=f(t,p) 
T=20; %final time 
tspan=[0, T]; %time span 
h=0.01; %stepsize 
p0=s; %the initial value of p in the tau domain, the final in the t domain

%% Explicit Euler
h=0.25;
tic
[t,p_euler] = explicitEuler(f,tspan,p0,h);
euler_time=toc;

p_euler=fliplr(p_euler); %reverse p from tau domain to t domain

% Plot result 
figure(1) 
hold on 
box on 
grid on 
ex_euler=plot(t, p_euler, 'ro--','MarkerSize',4, 'LineWidth',1); 
xlabel('time (s)','interpreter', 'latex')
ylabel('p(t)','interpreter', 'latex')
title('Numerical solutions to the ODE: $-\frac{dp}{dt}=2pa+q-\frac{b^2}{r}p^2$','Interpreter','latex')
set(gca,'FontSize',10) %sets the font size for axes demarcations and labels

%Tau domain solution to better visualise stability
%figure(2)
%hold on 
%box on 
%grid on 
%ex_euler_rev=plot(t, fliplr(p_euler), 'ro--','MarkerSize',4, 'LineWidth',1); 
%xlabel('time (s)','interpreter', 'latex')
%ylabel('p(t)','interpreter', 'latex')
%title('Reversed numerical solutions','Interpreter','latex')
%set(gca,'FontSize',10) %sets the font size for axes demarcations and labels
%% 4th-Order Runge-Kutta 
clearvars t p %clear t and p to store the new numerical solution 
h=0.25;
tic
[t,p_RK4] = RungeKutta4(f,tspan,p0,h);
RK4_time=toc;

p_RK4=fliplr(p_RK4); %reverse p from tau domain to t domain

figure(1) 
RK4=plot(t,p_RK4,'--vb','MarkerSize',4, 'LineWidth', 1);
legend([ex_euler,RK4],'Explicit Euler','$4^{th}$-Order Runge-Kutta','Location','northwest','Interpreter','latex')
set(gca,'FontSize',15)
hold off

%Tau domain solution to better visualise stability
%figure(2)
%RK4_rev=plot(t,fliplr(p_RK4),'--vb','MarkerSize',4, 'LineWidth', 1);
%legend([ex_euler_rev,RK4_rev],'Explicit Euler','$4^{th}$-Order Runge-Kutta','Location','northwest','Interpreter','latex')
%set(gca,'FontSize',15)

%% Solution for x(t) using Explicit Euler
% Parameters of problem
%h=0.25; %size of time-step 
x0=5; %initial value x(0)
t=0:h:T; %discretized time

x_prime=@(t,x_euler,p_RK4) a*x_euler-(b^2/r)*p_RK4*x_euler; %Define derivative -x'=x_prime(t,p)

%Implement Explicit Euler
x_euler(1)=x0;

for i=2:length(t)
    x_euler(i)=x_euler(i-1)+h*x_prime(t(i-1),x_euler(i-1),p_RK4(i-1));
end

% Plot result 
figure(3) 
hold on 
grid on 
x_eulerplot=plot(t, x_euler, 'ro--','MarkerSize',4, 'LineWidth',1); 
xlabel('time (s)','interpreter', 'latex')
ylabel('x(t)','interpreter', 'latex')
title('Explicit Euler solution to the ODE: $\frac{dx}{dt}=ax-\frac{b^2}{r}px$','Interpreter','latex')
set(gca,'FontSize',15) %sets the font size for axes demarcations and labels

save('PartI_Solutions','t','x_euler','p_RK4','p_euler')