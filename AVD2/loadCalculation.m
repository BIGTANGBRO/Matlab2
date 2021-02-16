%code to calculate the load
clear 
clc

%n =300;
croot = 8.5742;
ctip = 2.7437;
c = linspace(ctip,croot,300);
halfSpan = (53.19-3.9)/2;
rho = 0.33;
mass_MG = 2550;%kg
mass_NG = 580;%kg

%% load distribution
%inertia load calculation
%for lift elliptic distribution
Wac = 1341419;
L0 = Wac*3.75/(pi*halfSpan);
L02 = Wac*-1.5/(pi*halfSpan);
y = linspace(0,halfSpan,300);
L = L0*sqrt(1-(y/halfSpan).^2);
L2 = L02*sqrt(1-(y/halfSpan).^2);

loadEngine = 6030*9.81/1;
yEngine = linspace(7.23,8.23,100);

loadLG = 1275*9.81/0.25;
yLG = linspace(1.95,2.2,100);

%calculation of wing own weight
loadWing0 = 5150*9.81/(halfSpan*pi);
loadWing = loadWing0*sqrt(1-(y/halfSpan).^2);

yFuel = linspace(7.394,17.25,200);
loadFuel = 27800.*9.81./(halfSpan*0.4*pi).*(1-yFuel/halfSpan);

totalLoad = zeros(1,300);
totalLoad(:) = totalLoad(:)+L(:);
totalLoad(89:101) = totalLoad(89:101)-loadEngine;
totalLoad(25:28) = totalLoad(25:28)-loadLG;
totalLoad(:)=totalLoad(:)-loadWing(:);
yFuel2 = linspace(7.394,17.25,120);
loadFuel2 = 27800.*9.81./(halfSpan*0.4*pi).*(1-yFuel2/halfSpan);
totalLoad(91:210)= totalLoad(91:210)-loadFuel2(1:120);

totalLoad2 = zeros(1,300);
totalLoad2(:) = totalLoad2(:)+L2(:);
totalLoad2(89:101) = totalLoad2(89:101)-loadEngine;
totalLoad2(25:28) = totalLoad2(25:28)-loadLG;
totalLoad2(:)=totalLoad2(:)-loadWing(:);
totalLoad2(91:210)= totalLoad2(91:210)-loadFuel2(1:120);
%%
figure(1)
plot(y,L,'c');
hold on;
plot(y,-loadWing,'m');
hold on;
plot(yEngine,-loadEngine,'r.-');
hold on;
plot(yLG,-loadLG,'b.-');
hold on;
plot(yFuel,-loadFuel,'g');
hold on;
plot(y,totalLoad,'k');
legend("Lift","Own weight","Engine","Main landing gear","Fuel","totalLoad");
title("Load Distribution for n = 3.75");
ylabel('load(N/m)');
xlabel('Wing span loaction(m)');
grid on
hold off

%for n = -1
figure(2)
plot(y,L2,'c');
hold on;
plot(y,totalLoad2,'k');
legend("Lift","totalLoad");
title("Load Distribution for n = -1.5");
ylabel('load(N/m)');
xlabel('Wing span loaction(m)');
grid on
hold off

%% 
figure(3)
dx = halfSpan/300;
shearForce = totalLoad.*dx;
shearForce2 = totalLoad2.*dx;
for i = 1:300
    shearForce(i) = sum(shearForce(i:300));
    shearForce2(i) = sum(shearForce2(i:300));
end    
plot(y,shearForce);
hold on;
plot(y,shearForce2);
hold off;
legend("n=3.75","n=-1.5");
ylabel("Shear force/N");
xlabel("Wing Span/m");
grid on

%% Bending moment calculation
shearForce(301)=0;
shearForce2(301)=0;
for i = 1:300
    dbendMoment(i) = (shearForce(i)+shearForce(i+1))*(dx)/2;
    dbendMoment2(i) = (shearForce2(i)+shearForce2(i+1))*(dx)/2;
end

for i = 1:300
    bendMoment(i) = sum(dbendMoment(i:300));
    bendMoment2(i) = sum(dbendMoment2(i:300));
end    

figure(4);
plot(y,bendMoment);
hold on;
plot(y,bendMoment2);
grid on;
legend("n=3.75","n=-1.5");
ylabel("Bending Moment/Nm");
xlabel("WingSpan/m");
hold off;


