clear
clc

N = 3:1:7;

%Loop
phi = 1./N.*(5/8-(3/8+1/4.*cos(2*pi./N)).^2);
alpha = 1 - N.*phi;

%root3
phi2 = 1./N.*((4-2.*cos(2*pi./N))./9);
alpha2 = 1 - N.*phi2;