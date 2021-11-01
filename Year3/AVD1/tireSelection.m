w0 = 145e3;%kg
percentageMg = 0.9;
percentageNg = 0.1;
StaticLoadMg = 0.9 * w0/2;
StaticLoadNg = 0.1*w0;
staticMg = StaticLoadMg*1.07/4;
staticNg = StaticLoadNg*1.07/2;
psiNg = 190;
psiMg = 195;
pressureNg = psiNg*703.0696;
pressureMg = psiMg*703.0696;
ApNg = staticNg/pressureNg;
ApMg = staticMg/pressureMg;
RrNg = -ApNg/(2.3*sqrt(0.23495*0.8636))+0.8636/2;
RrMg = -ApMg/(2.3*sqrt(0.4191*1.13036))+1.1303/2;