%Pendulum waves
clear
clc
g=9.81;
theta=pi/6;
L=input('input the length of the pendulum:');
d2_theta=-g*sin(theta)/L;
d_theta=0;
N=2100;
time_step=12;
for i=1:N
    d_theta=d_theta+d2_theta*time_step;
    theta=theta+d_theta*time_step;
end

    