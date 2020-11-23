w0 = 145e3;%kg
percentageMg = 0.9;
percentageNg = 0.1;
StaticLoadMg = 0.9 * w0/2;
StaticLoadNg = 0.1*w0;
staticMg = StaticLoadMg*1.07/4;
staticNg = StaticLoadNg*1.07/2;
Ap = 2.3*sqrt(wdith*diameter)*(diameter/2-rollingRadius);