clear
clc
fe = 67.5;
cfd = 66.5;

structure = 80;
aero = 68;
control = 80;
maths =65;
avd = 59;
gdp = 71;

coeff1 = 0.122;
coeff2 = 0.0833;
coeffAVD = 0.166;
coeffGDP = 0.25;

total = structure * coeff1 + aero *coeff1+control*coeff2+fe*coeff2+maths*coeff2+cfd*coeff2+avd*coeffAVD + gdp*coeffGDP
all = (0.111*79.45+0.222*76.02+0.333*total)/0.667
all2 = (0.111*79.45+0.222*76.02+0.333*total+70*0.333)
