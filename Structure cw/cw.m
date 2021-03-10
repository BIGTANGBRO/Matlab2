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
t = linspace(0,100,200);

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