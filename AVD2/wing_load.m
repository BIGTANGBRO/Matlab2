%Wing load calculation
clear
clc
close all
%% Geometry and load setup
%Cruise conditions
[~,a_cruise,~,rho_cruise]=atmosisa(35000*0.3048);
M = 0.8;
V_cruise = M * a_cruise;
V_max = V_cruise*1.25;% V_cruise = 0.8 V_max FAR 25

bf = (53.19-3.9)/2;  %wing semispan from the root at fuselage joint
n = 3.75;   %ultimate load factor
nn = -1.5; %negative extreme
N = 300; % number of discretisation
dy = bf/(N-1); % size of intervals
y = 0 : dy : bf; % spanwise discretisation 
W = 1341419/9.81; % weight at cruise altitude with no fuel
L = n*W*9.81/2; % lift on one side of the wing
Ln = nn*W*9.81/2; % lift on one side of the wing

c_r = 8.5742; % root chord
c_t = 2.7437; % tip chord
%angle of flexural axis
sweep = deg2rad(33.2);
theta = atan((tan(sweep)*bf+0.15*(c_t-c_r))/bf);
c = c_r : -(c_r-c_t)/(N-1) :c_t; % aero chord length distribution
%% structural coordinate
%structural span
bs = bf/cos(theta);
dx = bs/(N-1);
x = 0 : dx : bs;
%leading and trailing edge sweep angle
alead = atan((tan(sweep)*bf-0.25*(c_t-c_r))/bf);
atrai = atan((tan(sweep)*bf+0.75*(c_t-c_r))/bf);
lright = c_r/(tan(alead)-tan(atrai));
lflex = lright/cos(theta);
cs = (lflex-x/cos(theta))*(tan(alead-theta)+tan(theta-atrai));
%% load distribution
% lift distribution
elli = (1-(y./bf).^2).^0.5;
% elli (1,1:floor(1.5/11.52*N))=zeros(1,floor(1.5/11.52*N));
l_wing = elli*L/(trapz(y,elli));
l_wingn = elli*Ln/(trapz(y,elli));

%own weight
W_wing = 5150*9.81; % weight of wing
t2c = ones(1,300)*0.15;% thickness to chord ratio
% assume wing weight is proportional to c^2*t2c
w_wing = t2c.*c.^2*W_wing/trapz(y,t2c.*c.^2); % assuming quadratic

%fuel tank calcualtion
W_fuel = 27800*9.81;
yFuel = linspace(8.6949,20.2882,120);
t2cFuel = zeros(1,N);
cfuel = zeros(1,N);
t2cFuel(91:210) = t2c(91:210);
cfuel(91:210) = c(91:210);
w_fuel = t2cFuel.*cfuel.^2.*W_fuel./trapz(y,t2cFuel.*cfuel.^2);
plot(x,w_fuel,'b');

%landing gear
W_lg = 1275*9.81 ; % weight of main landin gear
y_lg = zeros(1,N);
y_lg(floor(N*1.95/bf):floor(N*2.2/bf)) = 1;% y position of mail landing gear
w_lg = W_lg*y_lg/trapz(y,y_lg);

%engine
W_engine = 6030*9.81;
y_engine = zeros(1,N);
y_engine(floor(N*7.23/bf):floor(N*8.23/bf)) = 1;
w_engine = W_engine*y_engine/trapz(y,y_engine);

totalLoad = l_wing-w_wing-w_lg-w_engine;
totalLoadN = l_wingn-w_wing-w_fuel-w_lg-w_engine;
figure(1)
plot(x,totalLoad);
hold on;
plot(x,totalLoadN);
hold on;
plot(x(91:210),-w_fuel(91:210));
hold on
plot(x(floor(N*1.95/bf):floor(N*2.2/bf)),-w_lg(floor(N*1.95/bf):floor(N*2.2/bf)));
hold on;
plot(x,l_wing);
hold on;
plot(x,-w_wing);
hold on
plot(x(floor(N*7.23/bf):floor(N*8.23/bf)),-w_engine(floor(N*7.23/bf):floor(N*8.23/bf)));
legend("Total load for N = 3.75","Total load for N = -1.5","Fuel tank","Landing gear","Lift","Own weight","Engine");
xlabel('Distance along flexural axis/m')
ylabel('Load Distribution/N/m')
hold off;

%% shear force&bending moment
SF = zeros(1,N);
SFn = zeros(1,N);
% initialise
%Shear force
shearForce = totalLoad.*dx;
shearForceN = totalLoadN.*dx;
for i = 1:N
    shearForce(i) = sum(shearForce(i:N));
    shearForceN(i) = sum(shearForceN(i:N));
end
figure(2)
plot(x,shearForce)
hold on
plot(x,shearForceN)
xlabel('Distance along flexural axis/m')
ylabel('Local shear force/N')
grid on

%% Bending moment
shearForce(301)=0;
shearForceN(301)=0;
for i = 1:N
    dbendMoment(i) = (shearForce(i)+shearForce(i+1))*(dx)/2;
    dbendMomentN(i) = (shearForceN(i)+shearForceN(i+1))*(dx)/2;
end

for i = 1:N
    bendMoment(i) = sum(dbendMoment(i:N));
    bendMomentN(i) = sum(dbendMomentN(i:N));
end

figure(3)
plot(x,bendMoment)
hold on
plot(x,bendMomentN)
xlabel('Distance along flexural axis/m')
ylabel('Local bending moment/Nm')
grid on
%% Torque
%from xfoil
T = zeros(1,N);
Tn = zeros(1,N);
cm0 = ones(1,N)*-0.07;
dM0 = 0.5*rho_cruise*(cos(theta)*V_max)^2*cs.^2.*cm0;%moment with respect to flexural axis. this could be better as this is more conservative and this is calculated with respect to the flexural axis.
%assume flexural axis at (.15+.65)/2=40% chord -- centre of wing box
x_flex = 0.4;
%moment arm of lift
al = (x_flex-0.25)*c;
dLa = al.*l_wing;
dLan = al.*l_wingn;
x_wing = 0.5;
%moment arm of inertial loads
bw = (x_flex-x_wing);
dnWbw = n*w_wing.*bw.*cs;
%sectional torque
dT = dM0+dLa+dnWbw;
dTn = dM0+dLan+dnWbw;
%total torque
for i = 1:N
    T(N-i+1) = sum(dT(N-i+1:N));  % sum from tip to root
    Tn(N-i+1) = sum(dTn(N-i+1:N));
end

figure(4)
plot(x,T);
hold on
plot(x,Tn);
xlabel('Distance along flexural axis/m')
ylabel('Local twisting moment/Nm')
grid on

save('loads.mat')