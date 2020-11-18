% this is the wing calculation
rho = 1.225;
u = 0.82 * 340;
d = 10;
miu = 1e-5;
Re = rho * u *d/miu;

SLE = 29;
SQC = 10;
lambda = 0.29;
AR = 9.4;
SLE2 = tan(SQC/180*pi) + ((1-lambda)/(AR*(1+lambda)));
disp(atan(SLE2)/pi*180);

%% sf
sf = 0.907;
Length = 4.9605 * (sf)^0.4;
Diameter = 3.49 * (sf)^0.5;
Weight = 6147.1 * (sf)^1.1;

