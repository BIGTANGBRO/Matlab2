%% script for the business exam
clc
clear

C0 = 120;
Cc = 9.5;
D = 1700;

Qopt = [round(sqrt(2*C0*D/Cc)),300,500,800];
price = [38,37.24,36.48,36.1];

totalCost = C0.*D./Qopt + Cc.*Qopt./2 + price.*D;

fprintf("The total cost is %4.3f",totalCost(4));
