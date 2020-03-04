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

rangeE=[-5:0.01:2];
deltaE=[0.04*14,0.02*14,-0.01*30,-0.025*30,-0.055*30,-0.095*30];
scatter(deltaE,CL,'r*');
pdeltaE = polyfit(deltaE,CL,1);
disp(pdeltaE);
hold on
plot(rangeE,pdeltaE(1).*rangeE+pdeltaE(2),'r');
hold on

%%
%xcg-5
IAS = [240,221,202,179.5,160.1,140.5].*0.5144;
rho = 1.225;
MassOfFuel=(3100+503+[971.6,969.3,965.1,961.4,956.1,953.9]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.55,-0.18,-0.15,-0.047,1.004,2.144];

deltaE=[+0.01*14,-0.01*30,-0.02*30,-0.015*30,-0.068*30,-0.111*30];
scatter(deltaE,CL,'g*');
pdeltaE = polyfit(deltaE,CL,1);
disp(pdeltaE);
hold on
plot(rangeE,pdeltaE(1).*rangeE+pdeltaE(2),'g');
hold on

%%
%xcg+5

rho=1.225;
IAS = [240,221.25,203.8,180,158.9,142]*0.5144;
MassOfFuel=(3100+503+[910.75,897,884.1,869.6,861.6,854]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.8,-0.5,-0.197,0.4365,1.214,2.026];

deltaE=[0.07*14,0.055*14,0.03*14,-0.005767*30,-0.02962*30,-0.05614*30];
scatter(deltaE,CL,'b*');
pdeltaE = polyfit(deltaE,CL,1);
disp(pdeltaE);
hold on
plot(rangeE,pdeltaE(1).*rangeE+pdeltaE(2),'b');
hold on

title('CL vs deltaE for clean setup')
ylabel('CL')
xlabel('Elevator deflection in angle');
legend('Xcg=0 points','Line for Xcg=0','Xcg-5 points','Line for Xcg-5','Xcg+5 points','Line for Xcg+5');
