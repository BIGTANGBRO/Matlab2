%Wing load calculation
clear
clc

%%
%Cruise parameters
aCruise = 296.5355;
rho = 0.3796;
M = 0.8;
V_cruise = M * aCruise;
V_max = 0.8*aCruise*1.25;% maximum velocity

halfSpan = (53.19-3.9)/2;  %wing semispan from the root at fuselage joint
n = 3.75;   %ultimate load factor
nn = -1.5; %negative extreme
N = 300; % number of discretisation
dy = halfSpan/(N-1); % size of intervals
y = 0 : dy : halfSpan; % spanwise discretisation 
W = 1341419/9.81; % weight at cruise altitude with no fuel
L = n*W*9.81/2; % lift on one side of the wing
LN = nn*W*9.81/2; % lift on one side of the wing

cRoot = 8.5742; % root chord
cTip = 2.7437; % tip chord
%angle of flexural axis
sweep = deg2rad(33.2);
theta = atan((tan(sweep)*halfSpan+0.15*(cTip-cRoot))/halfSpan);
c = cRoot : -(cRoot-cTip)/(N-1) :cTip; % aero chord length distribution
%% structural coordinate
%structural span
bs = halfSpan/cos(theta);
dx = bs/(N-1);
x = 0 : dx : bs;
%leading and trailing edge sweep angle
alead = atan((tan(sweep)*halfSpan-0.25*(cTip-cRoot))/halfSpan);
atrai = atan((tan(sweep)*halfSpan+0.75*(cTip-cRoot))/halfSpan);
lright = cRoot/(tan(alead)-tan(atrai));
lflex = lright/cos(theta);
chordS = (lflex-x/cos(theta))*(tan(alead-theta)+tan(theta-atrai));

%% load distribution
% lift distribution
ellipfunc = (1-(y./halfSpan).^2).^0.5;
% elli (1,1:floor(1.5/11.52*N))=zeros(1,floor(1.5/11.52*N));
l_wing = ellipfunc*L/(trapz(y,ellipfunc));
l_wingn = ellipfunc*LN/(trapz(y,ellipfunc));

%own weight
W_wing = 5150*9.81; % weight of wing
t2c = ones(1,300)*0.15;% thickness to chord ratio
t = t2c.*c;
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

%landing gear
W_lg = 1275*9.81 ; % weight of main landin gear
y_lg = zeros(1,N);
y_lg(floor(N*1.95/halfSpan):floor(N*2.2/halfSpan)) = 1;% y position of mail landing gear
w_lg = W_lg*y_lg/trapz(y,y_lg);

%engine
W_engine = 6030*9.81;
y_engine = zeros(1,N);
y_engine(floor(N*7.23/halfSpan):floor(N*8.23/halfSpan)) = 1;
w_engine = W_engine*y_engine/trapz(y,y_engine);

%without the fuel
totalLoad = l_wing-w_wing-w_lg-w_engine;
totalLoadN = l_wingn-w_wing-w_fuel-w_lg-w_engine;

%plot
figure(1)
plot(x,totalLoad);
hold on;
plot(x,totalLoadN);
hold on;
plot(x(91:210),-w_fuel(91:210));
hold on
plot(x(floor(N*1.95/halfSpan):floor(N*2.2/halfSpan)),-w_lg(floor(N*1.95/halfSpan):floor(N*2.2/halfSpan)),'b-.');
hold on;
plot(x,l_wing);
hold on;
plot(x,-w_wing);
hold on
plot(x(floor(N*7.23/halfSpan):floor(N*8.23/halfSpan)),-w_engine(floor(N*7.23/halfSpan):floor(N*8.23/halfSpan)),'-.');
legend("Total load for N = 3.75","Total load for N = -1.5","Fuel tank","Landing gear","Lift","Own weight","Engine");
xlabel('Wing semispan/m')
ylabel('Load Distribution/N/m')
hold off;

%% shear force
% initialise
%Shear force
shearForce = totalLoad.*dx;
shearForceN = totalLoadN.*dx;
for i = 1:N
    shearForce(i) = sum(shearForce(i:N));
    shearForceN(i) = sum(shearForceN(i:N));
end

figure(2)
plot(x,shearForce,'b')
hold on
plot(x,shearForceN)
legend("N=3.75","N=-1.5");
xlabel('Wing semispan/m')
ylabel('Shear force/N')
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
plot(x,bendMoment,'b')
hold on
plot(x,bendMomentN)
legend("N=3.75","N=-1.5");
xlabel('Wing semispan/m')
ylabel('Bending moment/Nm')
grid on
%% Torque
cm0 = ones(1,N)*-0.07;
dM0 = 0.5*rho*(cos(theta)*V_max)^2*chordS.^2.*cm0;%moment with respect to flexural axis. this could be better as this is more conservative and this is calculated with respect to the flexural axis.
%assume flexural axis at (.15+.60)/2=37.5% chord -- centre of wing box
xCenter = 0.375;
%moment arm of lift
liftArm = (-xCenter+0.25)*chordS;
deltaLa = liftArm.*l_wing*dx;
% deltaLaN = liftArm.*l_wingn*dx;

%moment arm of inertia loads
weightArm = (-xCenter+0.5).*chordS;
deltaNWb = n*w_wing.*weightArm*dx;
%sectional torque
dT =-deltaLa-deltaNWb+dM0;
% dTn = deltaLaN+deltaNWb+dM0;
%total torque
for i = 1:N
    T(N-i+1) = sum(dT(N-i+1:N));  % sum from tip to root
%     Tn(N-i+1) = sum(dTn(N-i+1:N));
end

figure(4)
plot(x,T,'b');
% hold on
% plot(x,Tn);
xlabel('Wing semispan/m')
ylabel('Torque for n = 3.75/Nm')
grid on

%% calculation of shear flow
bBox = t.*(1/1.2861);
cBox = 0.45.*c;
NormalLoad = bendMoment./(bBox.*cBox);
NormalLoadN = -bendMomentN./(bBox.*cBox);

%T/2A
qTorque = -T./(2*bBox.*cBox);
% qTorque2 = -Tn./(2*bBox*cBox);

%SF/2Bw
qS = shearForce(1:300)./(2.*bBox);

figure(5)
plot(x,NormalLoad,'b');
hold on
plot(x,NormalLoadN);
legend("N=3.75","N=-1.5");
xlabel('Wing semispan/m')
ylabel('Compression per unit length/Nm^-1')
grid on

figure(6)
plot(x,qTorque,'b');
% hold on
% plot(x,qTorque2);
% legend("N=3.75","N=-1.5");
xlabel('Wing semispan/m')
ylabel('Shear Flow from torque/Nm^-1')
grid on
 
figure(7)
plot(x,qS,'b');
xlabel('Wing semispan/m')
ylabel('Shear flow from shear force/Nm^-1')
grid on

%% spar sizing
ks = 8.2;
q1 = abs(qS+qTorque);
q2 = abs(qS-qTorque);
E = 76E9;
tFrontSpar = 1000*((q1.*bBox.^2)./(ks*E)).^(1/3);
tRearSpar = 1000*((q2.*bBox.^2)./(ks*E)).^(1/3);
tFrontSpar = ceil(tFrontSpar.*10)/10;
tRearSpar = ceil(tRearSpar.*10)/10;
figure(8)
plot(x,tFrontSpar);
hold on;
plot(x,tRearSpar);
xlabel("Wing span/m");
ylabel("Thickness/mm");
legend("Front spar","Rear spar");
shearStress1 = q1./tFrontSpar;
shearStress2 = q2./tRearSpar;
disp(max(shearStress1));
disp(max(shearStress2));

%% web stiffeners sizing
load("L.mat");
for i = 2:length(L)+1
    RibPos(i-1) = sum(L(1:i-1));
end
%start from 13m

gradient = (bBox(300)-bBox(1))./x(300);
spacing(1) = bBox(1);
for i = 2:100
    spacing(i) = spacing(i-1)+spacing(i-1).*gradient;
    if (abs(sum(spacing) - x(300)) <= 0.01)
        break;
    end
end
spacing = ceil(100.*spacing)./100;


webDistribution(1)=0;
for i = 1:48
webDistribution(i+1) = webDistribution(i)+spacing(i); 
end
figure(9)
for i = 1:48
    plot(webDistribution(i:i+1),[spacing(i),spacing(i)]);
    hold on
end
hold on
plot(RibPos,0.4*linspace(1,1,length(RibPos)),"*");
ylabel('Web stiffeners spacing/m');
xlabel("Position in half span/m");

spacing = spacing(16:length(spacing));
webDistribution = webDistribution(16:length(webDistribution));
figure(10)
for i = 1:length(spacing)
    plot(webDistribution(i:i+1),[spacing(i),spacing(i)]);
    hold on
end
ylabel('Web stiffeners spacing/m');
xlabel("Position in half span/m");

%% weight calculation for spar and web stiffeners
%volume of the web
volumeSpar = sum(0.001.*tFrontSpar.*bBox.*dx) + sum(0.001.*tRearSpar.*bBox.*dx);
flangeBreath = bBox.*0.05/1;
flangthickness = bBox.*0.006/1;
volumeSpar = volumeSpar + 4.*sum(flangeBreath.*flangthickness.*dx);
%assume 5mm width and 2mm thick for web stiffeners. 
volumeStiffeners = 2.*sum(spacing.*0.005.*0.002);
% volumeWebStiffeners = sum(space.*thickness.*height)
volumeSparTotal = volumeSpar+volumeStiffeners
massSparTotal = volumeSparTotal*2710
save("N.mat");