clear
clc
fe = 67.5;
cfd = 66.5;

structure = 82;
aero = 70;
control = 81;
maths =69;
avd = 60;
gdp = 72;

coeff1 = 0.122;
coeff2 = 0.083;
coeffAVD = 0.166;
coeffGDP = 0.25;

total = structure * coeff1 + aero *coeff1+control*coeff2+fe*coeff2+maths*coeff2+cfd*coeff2+avd*coeffAVD + gdp*coeffGDP