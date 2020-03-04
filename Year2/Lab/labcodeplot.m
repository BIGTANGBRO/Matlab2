clear
clc

xrange = [3:0.01:6];
xcg = 3.51+[-5,0,5]*0.0254;
ddeltaEdcl = [-15.2567,-14.0072,-12.0269];
scatter(xcg,ddeltaEdcl,'*');
p = polyfit(xcg,ddeltaEdcl,1);
hold on
plot(xrange,p(1).*xrange+p(2));
hold on
title('d(deltaE)/dCL over Xcg for clean setup')
xlabel('Xcg(m)')
ylabel('d(deltaE)/dCL')
hold off

ddeltaEdcl_landing = [-17.5534,-13.3372,-10.6681];
scatter(xcg,ddeltaEdcl_landing,'o');
p2 = polyfit(xcg,ddeltaEdcl_landing,1);
hold on
plot(xrange,p2(1).*xrange+p2(2));

title('d(deltaE)/dCL over Xcg for landing setup')
xlabel('Xcg(m)')
ylabel('d(deltaE)/dCL')

%xnp=4.59
%xnplanding = 4.02