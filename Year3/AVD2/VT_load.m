clear
clc
%F
halfSpan = 9.5-2.11;  %fake span
aCruise = 296.5355;
rho = 0.3796;
M = 0.8;
V_cruise = M * aCruise;
V_max = 0.8*aCruise*1.25;% maximum velocity
N = 308;
dy = halfSpan/(N-1);
y = 0 : dy : halfSpan;
ellipfunc = (1-(y./halfSpan).^2).^0.5;
newellipfunc([1:88])=flip(ellipfunc([1:88]));
newellipfunc([88+1:88+N])=ellipfunc;
newy=0:9.5/(396-1): 9.5;
F=61.94*10^3;
l_wing = newellipfunc*F/(trapz(newy,newellipfunc));
%x
halfSpan=9.5;
cRoot = 6.11; % root chord
cTip = 3.05; % tip chord
sweep = deg2rad(38);
theta = atan((tan(sweep)*halfSpan+0.15*(cTip-cRoot))/halfSpan);
bs = halfSpan/cos(theta);
dx = bs/(396-1);
x = 0 : dx : bs;

alead = atan((tan(sweep)*halfSpan-0.25*(cTip-cRoot))/halfSpan);
atrai = atan((tan(sweep)*halfSpan+0.75*(cTip-cRoot))/halfSpan);
lright = cRoot/(tan(alead)-tan(atrai));
lflex = lright/cos(theta);
chordS = (lflex-x/cos(theta))*(tan(alead-theta)+tan(theta-atrai));

plot(x,l_wing)
totalLoad=l_wing;
%shear force
N=396;
shearForce = totalLoad.*dx;
for i = 1:N
    shearForce(i) = sum(shearForce(i:N));
end
figure(2)
plot(x,shearForce,'b')
xlabel('Vertical tail span/m')
ylabel('Shear force/N')
grid on

%Bending moment
shearForce(N+1)=0;
for i = 1:N
    dbendMoment(i) = (shearForce(i)+shearForce(i+1))*(dx)/2;
end

for i = 1:N
    bendMoment(i) = sum(dbendMoment(i:N));
end

figure(3)
plot(x,bendMoment,'b')
xlabel('Vertical tail span/m')
ylabel('Bending moment/Nm')
grid on

%Torque
%assume flexural axis at (.15+.60)/2=37.5% chord -- centre of wing box
xCenter = 0.375;
c = cRoot : -(cRoot-cTip)/(N-1) :cTip; % aero chord length distribution
t2c = 0.15;
t = t2c.*c;

forceArm = (xCenter - 0.463).*c;
forceTorque = shearForce(1:396).*forceArm;
%sectional torque
T = forceTorque;
% dTn = deltaLaN+deltaNWb+dM0;
%total torque

figure(4)
plot(x,T,'b');
% hold on
% plot(x,Tn);
xlabel('Vertical tail span/m')
ylabel('Torque')
grid on

%% calculation of shear flow
bBox = t.*(0.85/0.9165);
cBox = 0.45.*c;
NormalLoad = bendMoment./(bBox.*cBox);

%T/2A
qTorque = -T./(2*bBox.*cBox);
% qTorque2 = -Tn./(2*bBox*cBox);

%SF/2Bw
qS = shearForce(1:396)./(2.*bBox);

figure(5)
plot(x,NormalLoad,'b');
xlabel('Vertical tailplane semispan/m')
ylabel('Compression per unit length/Nm^-1')
grid on

figure(6)
plot(x,qTorque,'b');
xlabel('Vertical tailplane semispan/m')
ylabel('Shear Flow from torque/Nm^-1')
grid on
 
figure(7)
plot(x,qS,'b');
xlabel('Vertical tailplane semispan/m')
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
xlabel("Vertical tailplane semispan/m");
ylabel("Thickness/mm");
legend("Front spar","Rear spar");
grid on
shearStress1 = q1./tFrontSpar;
shearStress2 = q2./tRearSpar;
disp(max(shearStress1));
disp(max(shearStress2));


volumeSpar1 = sum(0.001.*tFrontSpar.*bBox.*dx);
volumeSpar2 = sum(0.001.*tRearSpar.*bBox.*dx);
massSparTotal = volumeSpar1*2710
massSparTota2 = volumeSpar2*2710
