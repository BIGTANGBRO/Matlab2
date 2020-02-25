clear
clc

load('zeroXCG.mat');

rho=1.225;
w = 0.453592.*(3100+Fuelweight);
CL = w./(0.5.*rho.*Vind.^2);

plot(AoA,CL);