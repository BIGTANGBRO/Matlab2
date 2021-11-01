%collocation backward

clear
clc

AR = 48/7;
cbar =7/8;

theta1 = pi/5;
theta2 = 2*pi/5;
A1 = 0.02657;
A3 = -6.8177e-4;

alpha1=8*(1-1/4*cos(theta1));
alpha2=8*(1-1/4*cos(theta2));

chord1 = (3/2-1*cos(theta1));
chord2 = (1-0*cos(theta2));

miu1 = chord1/(AR*4*cbar);
miu2 = chord2/(AR*4*cbar);

%these are a0 related
LHS1 = deg2rad(alpha1)*miu1*sin(theta1);
LHS2 = deg2rad(alpha2)*miu2*sin(theta2);
item1 = A1*sin(theta1)*miu1;
item2 = 3*A3*sin(3*theta1)*miu1;
item3 = A1*sin(theta2)*miu2;
item4 = 3*A3*sin(3*theta2)*miu2;

k1 = A1*sin(theta1)^2;
k2 = A3*sin(3*theta1)*sin(theta1);
k3 = A1*sin(theta2)^2;
k4= A3*sin(3*theta2)*sin(theta2);

a1 = (k1+k2)/(LHS1 - item1-item2)
a2 = (k3+k4)/(LHS2 - item3-item4)
