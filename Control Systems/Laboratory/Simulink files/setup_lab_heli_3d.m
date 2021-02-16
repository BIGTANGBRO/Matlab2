%% SETUP_LAB_HELI_3D
%
% This script sets the model parameters and designs a PID position
% controller using LQR for the Quanser 3-DOF Helicopter plant.
%
clear all;
addpath('lib')
%
%% User defined 3DOF helicopter system configuration
% Amplifier Gain used for yaw and pitch axes: set VoltPAQ to 3.
K_AMP = 3;
% Amplifier Maximum Output Voltage (V)
VMAX_AMP = 24;
% Digital-to-Analog Maximum Voltage (V): set to 10 for Q4/Q8 cards
VMAX_DAC = 10;
% Initial elvation angle (rad)
elev_0 = -27.5*pi/180;

%% User defined Filter design
% Specifications of a second-order low-pass filter
wcf = 2 * pi * 20; % filter cutting frequency
zetaf = 0.9;        % filter damping ratio
% Anti-windup: integrator saturation (V)
SAT_INT_ERR_ELEV = 7.5;
SAT_INT_ERR_TRAVEL = 7.5;

%% User defined command settings
% Note: These limits are imposed on both the program and joystick commands.
% Elevation position command limit (deg)
CMD_ELEV_POS_LIMIT_LOWER = elev_0*180/pi;
CMD_ELEV_POS_LIMIT_UPPER = -CMD_ELEV_POS_LIMIT_LOWER;
% Maximum Rate of Desired Position (rad/s)
CMD_RATE_LIMIT = 45.0 * pi / 180;

%% Controller design
K=[37.9315   18.8463  -41.6699   21.9400    6.0742  -61.8190   10.0000  -10.0000
   37.9315  -18.8463   41.6699   21.9400   -6.0742   61.8190   10.0000   10.0000];


%% Non-linear model parameters (for closed-loop simulation only):
%Modified on 21/11/2016

%System parameters
% Propeller force-thrust constant found experimentally (N/V)
Kf = 0.1188;
% Mass of the helicopter body (kg)
m_h = 1.308;
% Mass of counter-weight (kg)
m_w = 1.924;
% Mass of front propeller assembly = motor + shield + propeller + body (kg)
m_f = m_h / 2;
% Mass of back propeller assembly = motor + shield + propeller + body (kg)
m_b = m_h / 2;
% Distance between pitch pivot and each motor (m)
Lh = 7.0 * 0.0254;
% Distance between elevation pivot to helicopter body (m)
La = 26.0 * 0.0254;
% Distance between elevation pivot to counter-weight (m)
Lw = 18.5 * 0.0254;
% Gravitational Constant (m/s^2)
g = 9.81;    
par = [Kf;m_h;m_w;m_f;m_b;Lh;La;Lw;g]; 

%Initial condition
X0=[-15/180*pi;0;0;0;0;0];
%% Feed-forward input:

Vop=0.5*g*(Lw*m_w-2*La*m_f)/(La*Kf);
