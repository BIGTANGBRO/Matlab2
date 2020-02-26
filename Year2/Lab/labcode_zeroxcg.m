clear
clc

%%Zero xcg AOA vs CL
%%cleaAn
rho=1.225;
IAS = [239.2,220.1,199.5,180.9,160.3,139]*0.5144;
MassOfFuel=(3100+[980,976,971.8,968.6,965,959.4]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.6,-0.3,0.1,0.45,1.25,2.3];

plot(AoA,CL);
hold on
%%
%landing
IAS_landing = [108.9,99.3,91,80.6,75.2,69.8]*0.5144;
MassOfFuel_landing = [930,924.8,919,915.6,907.8,903.3];

WeightofFuel_landing = MassOfFuel_landing.*9.81;
CL_landing = WeightofFuel_landing./(0.5.*rho.*IAS_landing.^2.*17.48);
AoA_landing = [-4.3,-2.85,-1,2.1,3.6,5.7];

plot(AoA_landing,CL_landing)


