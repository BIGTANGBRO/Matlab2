clear
clc

%%xcg+5 AOA vs CL
%%clean

rho=1.225;
IAS = [240,221.25,203.8,180,158.9,142]*0.5144;
MassOfFuel=(3100+503+[910.75,897,884.1,869.6,861.6,854]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.8,-0.5,-0.197,0.4365,1.214,2.026];

p1=polyfit(AoA,CL,1);
scatter(AoA,CL);
range = [-10:0.1:10];
hold on
plot(range,p1(1).*range + p1(2));
%%
%landing
IAS_landing = ([119.4,109.7,99.13,90.9,80.6,69.72])*0.5144;
MassOfFuel_landing = ([776.5,795.1,807,818.8,748.9,738.5]+3100+503).*0.453592;

WeightofFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightofFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing = [-5.547,-4.593,-3.096,-1.731,1.525,4.986];

hold on
scatter(AoA_landing,CL_landing,'*');
p2 = polyfit(AoA_landing,CL_landing,1);
hold on
plot(range,p2(1).*range+p2(2));
legend('points for clean setup','line for clean setup','points for landing setup','line for landing setup');
xlabel('Angel of attack in degree');
ylabel('CL(Coefficient of life)');
title('CL vs AoA for Xcg + 5');
hold off



%%
%clean 
%delta e and Cl
%xcg + 5

rangeE=[-15:0.01:5];
deltaE=[0.07*14,0.055*14,0.03*14,-0.05767*30,-0.02962*30,-0.05614*30];
scatter(deltaE,CL,'*');
pdeltaE = polyfit(deltaE,CL,1);
hold on
plot(rangeE,pdeltaE(1).*rangeE+pdeltaE(2));
hold on
%%
%landing
%delta e and CL
deltaE_landing=[0.1652*14,0.1071*14,0.01603*14,-0.03469*30,-0.1479*30,-0.2368*30];
scatter(deltaE_landing,CL_landing,'*');
pdeltaE_landing = polyfit(deltaE_landing,CL_landing,1);
hold on
plot(rangeE,pdeltaE_landing(1).*rangeE+pdeltaE_landing(2));
title('CL vs deltaE when xcg + 5')
ylabel('CL')
xlabel('Elvator deflection in angle');
legend('clean points','Line for clean setup','landing points','Line for landing setup');

%clean dDeltaE/dCl = -12.1741
%landing = -10.6681