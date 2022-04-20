syms phi theta
r = 1;
x = r*sin(phi)*cos(theta);
y = r*sin(phi)*sin(theta);
z = r*cos(phi);
fsurf(x,y,z,[0 pi 0 2*pi])
axis equal