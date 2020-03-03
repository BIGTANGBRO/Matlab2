
%%
clear
clc
%xcg=0
%landing
range = [-10:0.1:10];
rho = 1.225;
IAS_landing = ([108.9,99.3,91,80.6,75.2,69.8])*0.5144;
MassOfFuel_landing = ([930,924.8,919,915.6,907.8,903.3]+3100+503).*0.453592;

WeightofFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightofFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing = [-4.3,-2.85,-1,2.1,3.6,5.7];

hold on
scatter(AoA_landing,CL_landing,'r*');
p2 = polyfit(AoA_landing,CL_landing,1);
hold on
plot(range,p2(1).*range+p2(2),'r');
hold on
%%
%landing
%xcg-5
IAS_landing = [119.3,111.3,100.6,90.5,80.2,69.6].*0.5144;
rho = 1.225;
MassOfFuel_landing=(3100+503+[936.8,926.9,920.8,917.6,917,914.6]).*0.453592;
WeightOfFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightOfFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing=[-5.248,-4.286,-3.312,-0.781,2.33,6.249];

hold on
scatter(AoA_landing,CL_landing,'g*');
p2 = polyfit(AoA_landing,CL_landing,1);
hold on
plot(range,p2(1).*range+p2(2),'g');
hold on 
%%
%landing
%xcg + 5
IAS_landing = ([119.4,109.7,99.13,90.9,80.6,69.72])*0.5144;
MassOfFuel_landing = ([776.5,795.1,807,818.8,748.9,738.5]+3100+503).*0.453592;

WeightofFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightofFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing = [-5.547,-4.593,-3.096,-1.731,1.525,4.986];

hold on
scatter(AoA_landing,CL_landing,'b*');
p2 = polyfit(AoA_landing,CL_landing,1);
hold on
plot(range,p2(1).*range+p2(2),'b');

legend('points for zero Xcg','line for zero Xg','points for Xcg-5','line for Xcg-5','points for Xcg+5','line for Xcg+5');
xlabel('Angel of attack in degree');
ylabel('CL(Coefficient of life)');
title('CL vs AoA for landing setup');
hold off
