%% script for the business exam
clc
clear

C0 = 275;
Cc = 14;
D = 700;

Qopt = [round(sqrt(2*C0*D/Cc)),200,600];
price = [65,59,56];

totalCost = C0.*D./Qopt + Cc.*Qopt./2 + price.*D;

fprintf("The total cost is %4.3f",totalCost(3));
