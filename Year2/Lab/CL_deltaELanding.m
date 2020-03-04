%%
clear
clc
%landing xcg =0
rho=1.225;
rangeE=[-20:0.01:5];

IAS_landing = ([108.9,99.3,91,80.6,75.2,69.8])*0.5144;
MassOfFuel_landing = ([930,924.8,919,915.6,907.8,903.3]+3100+503).*0.453592;
WeightofFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightofFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing = [-4.3,-2.85,-1,2.1,3.6,5.7];

deltaE_landing=[0*30,-0.06*30,-0.12*30,-0.24*30,-0.29*30,-0.38*30];
scatter(deltaE_landing,CL_landing,'r*');
pdeltaE_landing = polyfit(deltaE_landing,CL_landing,1);
disp(pdeltaE_landing);
hold on
plot(rangeE,pdeltaE_landing(1).*rangeE+pdeltaE_landing(2),'r');
hold on


%%
%landing xcg-5
IAS_landing = [119.3,111.3,100.6,90.5,80.2,69.6].*0.5144;
rho = 1.225;
MassOfFuel_landing=(3100+503+[936.8,926.9,920.8,917.6,917,914.6]).*0.453592;
WeightOfFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightOfFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing=[-5.248,-4.286,-3.312,-0.781,2.33,6.249];

deltaE_landing=[-0.003*30,-0.048*30,-0.087*30,-0.203*30,-0.357*30,-0.558*30];
scatter(deltaE_landing,CL_landing,'g*');
pdeltaE_landing = polyfit(deltaE_landing,CL_landing,1);
disp(pdeltaE_landing);
hold on
plot(rangeE,pdeltaE_landing(1).*rangeE+pdeltaE_landing(2),'g');
hold on

%%
%landing xcg+5
IAS_landing = ([119.4,109.7,99.13,90.9,80.6,69.72])*0.5144;
MassOfFuel_landing = ([776.5,795.1,807,818.8,748.9,738.5]+3100+503).*0.453592;
WeightofFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightofFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing = [-5.547,-4.593,-3.096,-1.731,1.525,4.986];

deltaE_landing=[0.1652*14,0.1071*14,0.01603*14,-0.03469*30,-0.1479*30,-0.2368*30];
scatter(deltaE_landing,CL_landing,'b*');
pdeltaE_landing = polyfit(deltaE_landing,CL_landing,1);
disp(pdeltaE_landing);
hold on
plot(rangeE,pdeltaE_landing(1).*rangeE+pdeltaE_landing(2),'b');
title('CL vs deltaE for landing setup')
ylabel('CL')
xlabel('Elvator deflection in angle');
legend('Xcg=0 points','Line for Xcg=0','Xcg-5 points','Line for Xcg-5','Xcg+5 points','Line for Xcg+5');

