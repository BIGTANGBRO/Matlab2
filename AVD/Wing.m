% this is the wing calculation
rho = 1.225;
u = 0.82 * 340;
d = 10;
miu = 1e-5;
Re = rho * u *d/miu;

SLE = 29;
SQC = 28;
lambda = 0.28;
AR = 9.4;
SLE2 = tan(SQC/180*pi) + ((1-lambda)/(AR*(1+lambda)));
disp(atan(SLE2)/pi*180);

%% sf
sf = 255.05035/273.6;
Length = 4.9605 * (sf)^0.4;
Diameter1 = 3.49 * (sf)^0.5;
Diameter2 = 2.81941 * (sf)^0.5;
Weight = 6147.1 * (sf)^1.1;
fanArea = Diameter2^2/4*pi;
captureArea = fanArea * 0.777;


