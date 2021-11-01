%steering calculation
clear
clc

steeringAngle = linspace(0,12,100);
travel = 102;
x =  sqrt(435^2-(297-travel.*sin(deg2rad(steeringAngle))).^2)-sqrt(435^2-297^2) ;
d = 230.*asin(x./55);

plot(steeringAngle,d);
xlabel('Front wheel steering angle/degree');
ylabel('Handler travel/mm')
grid on