clc
clear

%%Zero xcg AOA vs CL
%%clean
rho=1.225;
IAS = [239.2,220.1,199.5,180.9,160.3,139]*0.5144;
MassOfFuel=(3100+503+[980,976,971.8,968.6,965,959.4]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.6,-0.3,0.1,0.45,1.25,2.3];

p1=polyfit(AoA,CL,1);
scatter(AoA,CL,'r*');
range = [-2:0.1:4];
hold on
plot(range,p1(1).*range + p1(2),'r');
hold on 
%%
%for cg - 5
%clean
clear 
clc

IAS = [240,221,202,179.5,160.1,140.5].*0.5144;
rho = 1.225;
MassOfFuel=(3100+503+[971.6,969.3,965.1,961.4,956.1,953.9]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.55,-0.18,-0.15,-0.047,1.004,2.144];

p1=polyfit(AoA,CL,1);
scatter(AoA,CL,'g*');
range = [-2:0.1:4];
hold on
plot(range,p1(1).*range + p1(2),'g');
hold on 
%%
%%xcg + 5AOA vs CL
%clean
rho=1.225;
IAS = [240,221.25,203.8,180,158.9,142]*0.5144;
MassOfFuel=(3100+503+[910.75,897,884.1,869.6,861.6,854]).*0.453592;
WeightOfFuel = MassOfFuel.*9.81;
CL = WeightOfFuel./(0.5.*rho.*IAS.^2.*17.48);
AoA=[-0.8,-0.5,-0.197,0.4365,1.214,2.026];

p1=polyfit(AoA,CL,1);
scatter(AoA,CL,'*b');
range = [-2:0.1:4];
hold on
plot(range,p1(1).*range + p1(2),'b');

legend('points for zero Xcg','line for zero Xg','points for Xcg-5','line for Xcg-5','points for Xcg+5','line for Xcg+5');
xlabel('Angel of attack in degree');
ylabel('CL(Coefficient of life)');
title('CL vs AoA for clean setup');
grid on
hold off
