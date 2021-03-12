% structure coursework
clear
clc

%initial setup
F_dot_x0 = 0.4823;
eta_dot_y0 = -0.00002;
F_dot_x90 = 0.0482;
F_dot_x30 = 0.1093;

eta_dot_x0 = 1e-4;
eta_dot_x30 = 1e-4;
eta_dot_x90 = 1e-4;

eta_max = 1e-3;
t = linspace(0,10,200);

width = 25e-3;
height = 1e-3;
cross_area = width*height;

% [0_8]
eta_x0 = eta_dot_x0.*t;
eta_y0 = eta_dot_y0.*t;
Fx0 = F_dot_x0.*t;

%[90_8]
eta_x90 = eta_dot_x90.*t;
Fx90 = F_dot_x90.*t;

%[30_8]
eta_x30 = eta_dot_x30.*t;
Fx30 = F_dot_x30.*t;

% for 0 degree
c = cos(0);
s = sin(0);
Tsigma0 = [c^2,s^2;s^2,c^2];
Teta0 = [c^2,s^2;s^2,c^2];
sigmaX0 = Fx0./cross_area;
plot(eta_x0,sigmaX0);
hold on

%for 90 degree
c = cos(90);
s = sin(90);
Tsigma90 = [c^2,s^2;s^2,c^2];
Teta90 = [c^2,s^2;s^2,c^2];
sigmaX90 = Fx90./cross_area;
plot(eta_x90,sigmaX90);
hold on

% for 30 degree
c = cos(30);
s = sin(30);
Tsigma30 = [c^2,s^2;s^2,c^2];
Teta30 = [c^2,s^2;s^2,c^2];
sigmaX30 = Fx30./cross_area;
plot(eta_x30,sigmaX30);