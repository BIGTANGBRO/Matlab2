%%
%for cg plus 5
clear 
clc

IAS = [240,221,202,179.5,160.1,140.5].*0.5144;
rho = 1.225;
MassOfFuel=(3100+[971.6,969.3,965.1,961.4,956.1,953.9]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.55,-0.18,-0.15,-0.047,1.004,2.144];
plot(AoA,CL);

hold on
%%
%High lift mode
IAS_landing = [119.3,111.3,100.6,90.5,80.2,69.6].*0.5144;
rho = 1.225;
MassOfFuel_landing=(3100+[936.8,926.9,920.8,917.6,917,914.6]).*0.453592;
WeightOfFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightOfFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing=[-5.248,-4.286,-3.312,-0.781,2.33,6.249];
plot(AoA_landing,CL_landing);

