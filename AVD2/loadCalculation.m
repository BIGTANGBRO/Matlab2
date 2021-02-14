%code to calculate the load
clear 
clc


croot = 8.5742;
ctip = 2.7437;
c = linspace(ctip,croot,300);
halfSpan = (53.19-3.9)/2;
loadFactor = 3.4;
rho = 0.33;
mass_MG = 2550;%kg
mass_NG = 580;%kg

%% load distribution
%inertia load calculation
%for lift elliptic distribution
Wac = 1341419;
L0 = Wac*3.75/(pi*halfSpan);
y = linspace(0,halfSpan,300);
L = L0*sqrt(1-(y/halfSpan).^2);
plot(y,L);
ylabel('load(N/m)');
xlabel('Wing span loaction(m)');

loadEngine = 6030*9.81/7.73;
yEngine = linspace(6,9.46,10);

loadLG = 1275*9.81/2.075;
yLG = linspace(1.95,2.2,10);

%calculation of wing own weight
loadWing0 = -pi*5150*9.81/halfSpan;
loadWing = loadWing0*sqrt(1-(y/halfSpan).^2);
hold on;
plot(y,loadWing);
hold on;
plot(yEngine,-loadEngine,'*');
hold on;
plot(yLG,-loadLG,'o');

yFuel = linspace(7.394,17.25,200);
loadFuel = 27800*9.81./yFuel;
hold on;
plot(yFuel,-loadFuel);




