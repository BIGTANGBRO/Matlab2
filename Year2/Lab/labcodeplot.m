clear
clc

xrange = [3:0.01:6];
xcg = 3.51+[-5,0,5]*0.0254;
ddeltaEdcl = [-0.2663,-0.2445,-0.2099];
scatter(xcg,ddeltaEdcl,'*');
p = polyfit(xcg,ddeltaEdcl,1);
hold on
plot(xrange,p(1).*xrange+p(2));
hold on
title('d(deltaE)/dCL over Xcg for clean setup')
xlabel('Xcg(m)')
ylabel('d(deltaE)/dCL (radian)')
grid on
hold off

ddeltaEdcl_landing = [-0.3077,-0.2335,-0.1886];
scatter(xcg,ddeltaEdcl_landing,'o');
p2 = polyfit(xcg,ddeltaEdcl_landing,1);
hold on
plot(xrange,p2(1).*xrange+p2(2));

title('d(deltaE)/dCL over Xcg for landing setup')
xlabel('Xcg(m)')
grid on
ylabel('d(deltaE)/dCL (radian)')
hold off
%xnp=4.59
%xnplanding = 4.02