%Pendulum waves
clear
clc
g=9.81;
L=20;
tmax=300;
dt=0.05;
theta=pi/6;
x=0;
t=0;
n=300;
dtheta=0;
while t<tmax
    t=t+dt;
    theta=theta+dtheta*dt;
    d2theta=-g*sin(theta)/L;
    dtheta=dtheta+d2theta*dt;
    plot3(x,L*sin(theta),-L*cos(theta),'or');
    hold on 
    plot3([1,1]*x,[0,L*sin(theta)],[0,-L*cos(theta)],'k')
    hold off
    pause(0.5);
end

    