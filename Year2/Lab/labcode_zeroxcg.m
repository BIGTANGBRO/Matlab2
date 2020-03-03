clear
clc

%%Zero xcg AOA vs CL
%%clean 
rho=1.225;
IAS = [239.2,220.1,199.5,180.9,160.3,139]*0.5144;
MassOfFuel=(3100+503+[980,976,971.8,968.6,965,959.4]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.6,-0.3,0.1,0.45,1.25,2.3];

p1=polyfit(AoA,CL,1);
scatter(AoA,CL);
range = [-10:0.1:10];
hold on
plot(range,p1(1).*range + p1(2));
%%
%landing
IAS_landing = ([108.9,99.3,91,80.6,75.2,69.8])*0.5144;
MassOfFuel_landing = ([930,924.8,919,915.6,907.8,903.3]+3100+503).*0.453592;

WeightofFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightofFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing = [-4.3,-2.85,-1,2.1,3.6,5.7];

hold on
scatter(AoA_landing,CL_landing,'*');
p2 = polyfit(AoA_landing,CL_landing,1);
hold on
plot(range,p2(1).*range+p2(2));
legend('points for clean setup','line for clean setup','points for landing setup','line for landing setup');
xlabel('Angel of attack in degree');
ylabel('CL(Coefficient of life)');
title('CL vs AoA for zero Xcg');
hold off

%%
%clean 
%delta e and Cl
%xcg = 0

rangeCL=[0:0.01:1.6];
deltaE=[0.04*14,0.02*14,-0.01*30,-0.025*30,-0.055*30,-0.095*30];
scatter(CL,deltaE,'*');
pdeltaE = polyfit(CL,deltaE,1);
hold on
plot(rangeCL,pdeltaE(1).*rangeCL+pdeltaE(2));
hold on

%%
%landing
deltaE_landing=[0*30,-0.06*30,-0.12*30,-0.24*30,-0.29*30,-0.38*30];
scatter(CL_landing,deltaE_landing,'*');
pdeltaE_landing = polyfit(CL_landing,deltaE_landing,1);
hold on
plot(rangeCL,pdeltaE_landing(1).*rangeCL+pdeltaE_landing(2));
title('Delta E vs CL when xcg = 0')
xlabel('CL')
ylabel('Delta of Elvator in angle');
legend('clean points','Line for clean setup','landing points','Line for landing setup');

%clean dDeltaE/dCl = -13.9851
%landing = -13.3372
