clear
clc
close all
format long

% Shear flow in a structural section lab
% Nadja Radovic 20-11-2020 

% WARNINGS/NOTES:
% still need to add code for line of best fit
% angle/axis definitions might be incorrect, so final strain values might have wrong signs
% 
%% defining parameters

% thicknesses - mm originally
t18e=0.64e-3;
t18i=1.7e-3;
t32=0.64e-3;
t21=2.34e-3;
t87=2.34e-3;
t76=0.64e-3;
t63=1.59e-3;

% distances - mm originally
s18e=318e-3;
s18i=81e-3;
s32=286.66e-3;
s21=17.4e-3;
s87=17.4e-3;
s76=286.66e-3;
s63=81e-3;

% areas - mm^2 originally
A1=8487e-6;
A2=24507e-6;

% other parameters
Gshear=28e9; % shear modulus - GPa
G=1000; % gain
Vin=15; % input voltage - V
S=2.09; % strain gauge factor

%% solving simultaneous equations
% defining matrices to solve simultaneous equations
A=[(s18e/t18e + s18i/t18i) (-s18i/t18i) (-2*A1*Gshear);
   (-s18i/t18i) (s32/t32 + s21/t21 + s18i/t18i + s87/t87 + s76/t76 + s63/t63) (-2*A2*Gshear);
   A1 A2 0];

T=0.45359*9.81*(0:10:50); % converting from lbs to N

for i=1:length(T)
    x(:,i)=inv(A)*transpose([0 0 T(i)/2]); % x = matrix of unknowns [q01; q02; dtheta_dz;]
end

%% calculating theoretical results (TH - theoretical)
% CDE - front spar
% FGH - top skin
% IJK - bottom skin

THstrainCDE=1e6*(x(2,:)-x(1,:))/(Gshear*t18i); % subtract first from second row corresp to q02-q01
THstrainFGH=1e6*x(2,:)/(Gshear*t32); % take second row of x corresp. to q02
THstrainIJK=1e6*x(2,:)/(Gshear*t76); % take second row of x corresp. to q02 (these two are equal)

mCDE=THstrainCDE(2)/T(2); % (probably a bad practice) way of finding slopes
mFGH=THstrainFGH(2)/T(2); 
mIJK=THstrainIJK(2)/T(2); % FGH and IJK should be equal 

%% inputting experimental results
% currently populated with TEST DATA from handout

%front spar 
VoutC=[0 0.0335];
VoutD=[0 0.0005];
VoutE=[0 -0.031];

% top skin
VoutF=[0 -0.032];
VoutG=[0 -0.0895];
VoutH=[0 -0.0775];

% bottom skin
VoutI=[0 0.079];
VoutJ=[0 0.163];
VoutK=[0 0.046];

%% calculating experimental data

Q=4/(Vin*S*G); % defining constant that converts voltage to strain

% for ALL gauges: x direction is parallel to the 0deg gauge, +ve R to L


% front spar
% assuming y direction is opposite to direction of q02-q01 i.e. upwards
% C = +45deg, D = 0deg, E = -45deg (anticlockwise)
epsC=Q*VoutC;
epsE=Q*VoutE;
strainCDE=1e6*(epsC-epsE);

% top skin
% assuming y direction is in direction of q02/from built in to curved end
% F = +45deg, G = 0deg, H = -45deg (anticlockwise)
epsF=Q*VoutF;
epsH=Q*VoutH;
strainFGH=1e6*(epsF-epsH);

% bottom skin
% assuming y direction is in direction of q02/from curved to built in end
% I = -45deg, J = 0deg, K = +45deg (anticlockwise)
epsI=Q*VoutI;
epsK=Q*VoutK;
strainIJK=1e6*(epsK-epsI);

%% plotting torques
figure(1) % plotting results
title('Wing subject to pure torsion')
xlabel('Torque, T (Nm)')
ylabel('Shear strain \gamma (\mum)')

syms t % symbolically plotting theoretical results
hold on
fplot(mCDE*t,[0 50], 'g') % front spar
fplot(mFGH*t,[0 50], 'b') % top skin
fplot(mIJK*t,[0 50], 'r--') % bottom skin, plotting both FGH and IJK to check if equal
legend('Front spar (theoretical)','Top skin (theoretical)','Bottom skin (theoretical)')
hold off

%% plotting loads - NOT REQUIRED
figure(2) % plotting rear spar loading - just for a test
title('Wing subject to rear spar load')
xlabel('Applied point load (N)')
ylabel('Shear strain \gamma (\mum)')
hold on
plot(T(1:2),strainCDE, 'gx') % front spar
plot(T(1:2),strainFGH, 'bo') % top skin
plot(T(1:2),strainIJK, 'r*') % bottom skin
legend('Front spar (CDE)','Top skin (FGH)','Bottom skin (IJK)')
hold off