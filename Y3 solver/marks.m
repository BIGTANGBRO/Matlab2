clear
clc

fe = 67.5;
cfd = 66.5;

structure = 75;
aero = 66;
control = 78;
maths = 62;
avd = 62;
gdp = 67;

coeff1 = 0.122;
coeff2 = 0.0833;
coeffAVD = 0.166;
coeffGDP = 0.25;

total = structure * coeff1 + aero *coeff1+control*coeff2+fe*coeff2+maths*coeff2+cfd*coeff2+avd*coeffAVD + gdp*coeffGDP
all = (0.111*79.45+0.222*76.02+0.333*total)/0.667


%% year2 raw
aero = 69;
cir = 73.44;
exp = 70.58;
L2=69;
MP = 65;
material = 65.6;
maths = 76.12;
mf = 68.67;
na = 75.31;
pt = 74.5;
smd = 61;
business = 75.67;
p1 = 0.0929;
p2 = 0.0929;
p3 = 0.145;
p4 = 0.0929;
p5 = 0.0494;
p6 = 0.0619;
p7 = 0.0912;
p8 = 0.0619;
p9 = 0.0619;
p10 = 0.0619;
p11=0.0929;
p12 = 0.0929;
mtotal = aero * p1 + cir *p2 + exp*p3 + L2*p4+MP*p5+material *p6+maths*p7+mf*p8+na*p9+pt*p10+smd*p11+business*p12;
