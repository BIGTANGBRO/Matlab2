%Pendulum waves
clear
clc
g=9.81;
n=1;
dx=10;
alpha=2;
Lo=20;
tmax=300;
dt=0.05;
theta0=30;
x=[0:n-1];
L=Lo-x*tan(alpha*pi/180);
t=0;
dtheta=zeros(1,n);
theta=ones(1,n)*theta0*pi/180;
while t<tmax
    t=t+dt;
    d2theta=-g*sin(theta)./L;
    dtheata=dtheta+d2theta*dt;
    theta=theta+dtheta*dt;
    plot3(x,L.*sin(theta),-L.*cos(theta),'or');
    hold on
    for i=1:n
        plot3([1,1]*x(i),[0,L(i)*sin(theta(i))],[0,-L(i)*cos(theta(i))],'k');
    end
    hold off
    view([90,0])
    axis([0,n*dx,-Lo,Lo,-1.5*Lo,0])
    pause(max(0.01,dt-0.02))
    drawnow
end

    