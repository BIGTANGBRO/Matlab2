clear
clc

xrange = [3:0.01:5.5];
xcg = 3.91+[-5,0,5]*0.0254;
ddeltaEdcl = [-15.9628,-13.9851,-12.1741];
scatter(xcg,ddeltaEdcl,'*');
p = polyfit(xcg,ddeltaEdcl,1);
hold on
plot(xrange,p(1).*xrange+p(2));
hold on
title('d(deltaE)/dCL over Xcg for clean setup')
xlabel('Xcg(m)')
ylabel('d(deltaE)/dCL')
hold off

ddeltaEdcl_landing = [-19.7590,-13.3372,-10.6681];
scatter(xcg,ddeltaEdcl_landing,'o');
p2 = polyfit(xcg,ddeltaEdcl_landing,1);
hold on
plot(xrange,p2(1).*xrange+p2(2));

title('d(deltaE)/dCL over Xcg for landing setup')
xlabel('Xcg(m)')
ylabel('d(deltaE)/dCL')

%xp=4.85
%xpnlanding = 4.32