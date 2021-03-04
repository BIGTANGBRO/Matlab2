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

halfSpan = 14.8/2;  %wing semispan from the root at fuselage joint
n = 2.5;   %ultimate load factor
N = 300; % number of discretisation
dy = halfSpan/(N-1); % size of intervals
y = 0 : dy : halfSpan; % spanwise discretisation 
W = 1.14e3/2; % weight at cruise altitude with no fuel
L = n*W*9.81/2; % lift on one side of the wing

cRoot = 4.98; % root chord
cTip = 1.99; % tip chord
%angle of flexural axis
sweep = deg2rad(38);
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
totalLoad = l_wing;
%own weight
% W_wing = W*9.81; % weight of wing
t2c = ones(1,300)*0.12;% thickness to chord ratio
t = t2c.*c;
% % assume wing weight is proportional to c^2*t2c
% w_wing = t2c.*c.^2*W_wing/trapz(y,t2c.*c.^2); % assuming quadratic

% totalLoad = l_wing-w_wing;

% plot(x,l_wing);
% hold on;
% plot(x,w_wing);
% hold on
plot(x,l_wing);
hold on
xlabel('Wing semispan/m')
ylabel('Load Distribution/N/m')
hold off;

%% shear force
% initialise
%Shear force
shearForce = totalLoad.*dx;
for i = 1:N
    shearForce(i) = sum(shearForce(i:N));
end

figure(2)
plot(x,shearForce,'b')
xlabel('Wing semispan/m')
ylabel('Shear force/N')
grid on

%% Bending moment
shearForce(301)=0;
for i = 1:N
    dbendMoment(i) = (shearForce(i)+shearForce(i+1))*(dx)/2;
end

for i = 1:N
    bendMoment(i) = sum(dbendMoment(i:N));
end

figure(3)
plot(x,bendMoment,'b')
xlabel('Wing semispan/m')
ylabel('Bending moment/Nm')
grid on
%% Torque
cm0 = ones(1,N)*0;
dM0 = 0.5*rho*(cos(theta)*V_max)^2*chordS.^2.*cm0;%moment with respect to flexural axis. this could be better as this is more conservative and this is calculated with respect to the flexural axis.
%assume flexural axis at (.15+.60)/2=37.5% chord -- centre of wing box
xCenter = 0.375;
%moment arm of lift
liftArm = (xCenter-0.25)*chordS;
deltaLa = liftArm.*l_wing*dx;
% deltaLaN = liftArm.*l_wingn*dx;

%moment arm of inertia loads
weightArm = (-xCenter+0.5).*chordS;
deltaNWb = n*W.*weightArm*dx;
%sectional torque
dT =deltaLa+deltaNWb-dM0;
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
bBox = t.*(0.57/0.5976);
cBox = 0.45.*c;
NormalLoad = bendMoment./(bBox.*cBox);

%T/2A
qTorque = T./(2*bBox.*cBox);
% qTorque2 = -Tn./(2*bBox*cBox);

%SF/2Bw
qS = shearForce(1:300)./(2.*bBox);

figure(5)
plot(x,NormalLoad,'b');
xlabel('Horizontal tailplane semispan/m')
ylabel('Compression per unit length/Nm^-1')
grid on

figure(6)
plot(x,qTorque,'b');
% hold on
% plot(x,qTorque2);
% legend("N=3.75","N=-1.5");
xlabel('Horizontal tailplane semispan/m')
ylabel('Shear Flow from torque/Nm^-1')
grid on
 
figure(7)
plot(x,qS,'b');
xlabel('Horizontal tailplane semispan/m')
ylabel('Shear flow from shear force/Nm^-1')
grid on

%%
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
xlabel("Horizontal stabilizer semispan/m");
ylabel("Thickness/mm");
legend("Front spar","Rear spar");
shearStress1 = q1./tFrontSpar;
shearStress2 = q2./tRearSpar;
disp(max(shearStress1));
disp(max(shearStress2));

volumeSpar1 = sum(0.001.*tFrontSpar.*bBox.*dx);
volumeSpar2 = sum(0.001.*tRearSpar.*bBox.*dx);
massSparTotal = volumeSpar1*2710
massSparTota2 = volumeSpar2*2710
