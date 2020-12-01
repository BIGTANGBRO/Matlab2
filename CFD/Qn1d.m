%CFD Coursework I (Professor Spencer Sherwin)
%Question 1(d) 
%Thomas Algorithm
%
%Written by Jonathan De Sousa
%Date: 30/11/2020

%clear workspace and screen
clear
clc
close all

%Parameters
delta_x = 1/10;
x_mesh = 0:delta_x:1;
N = 1/delta_x +1;

a_coeff = 1;
b_coeff = -(2+delta_x^2);
c_coeff = 1;

f_star = transpose(-(9*pi^2+1)*delta_x^2*sin(3*pi*x_mesh(2:N-1)));

%Entries of tridiagonal matrix system (a_{k}*x_{k-1} + b_{k}*x_{k} + c_{k}*x_{k+1} = f_{k})
a = [0;a_coeff*ones(N-3,1)];
b = b_coeff*ones(N-2,1);
c = [c_coeff*ones(N-3,1);0];

%Forward step
beta = zeros(N-2,1);
beta(1) = b(1);
for k = 2:N-2
    beta(k) = b(k)-a(k)*c(k-1)/beta(k-1);
end

gamma = zeros(N-2,1);
gamma(1) = f_star(1)/beta(1);
for k = 2:N-2
    gamma(k) = (-a(k)*gamma(k-1)+f_star(k))/beta(k);
end

u = [0;zeros(N-2,1);0];
u(N-2) = gamma(N-2);

for k = (N-3):-1:1
    u(k) = gamma(k)-u(k+1)*c(k)/beta(k);
end

u_exact = sin(3*pi*x_mesh'); %analytical solution at each mesh point
epsilon_direct_max = max(u-u_exact); %maximum error for each delta_x
fprintf('Epsilon_direct_max = %.15f',epsilon_direct_max)


figure(1)
hold on
grid minor
thomas = plot(x_mesh,u,'-b');
analytic = plot(0:0.01:1,sin(3*pi*(0:0.01:1)),'--r');
hold off