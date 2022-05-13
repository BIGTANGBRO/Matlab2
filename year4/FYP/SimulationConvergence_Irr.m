clc
clear
%using Limited Resolution
%Irregular sphere
%point at 0.12 0.14
cdLoop = [5.5910E-03 2.3400E-04	1.6000E-05	1.1500E-04];
cdMb   = [5.5910E-03 1.6540E-03	1.6870E-03	1.9850E-03];
cdRoot = [5.5910E-03 5.4000E-04	1.8200E-04	2.5290E-04];

%point at 0.12 0.14
pLoop = [8.7500E+01	2.5900E+01	2.4700E+01	3.5000E+00];
vLoop = [8.1000E-01	1.6000E-01	4.1000E-01	5.7000E-01];

pMb =  [8.7500E+01 4.6000E+01	4.8300E+01	5.7400E+01];
vMb =  [8.1000E-01 8.5000E-01	1.0900E+00	1.0900E+00];

pRoot = [8.7500E+01 2.2000E+00	1.8700E+01	5.1700E+01];
vRoot = [8.1000E-01 2.1000E-01	6.0000E-02	6.0000E-02];

hloop = [2.6249E+01	1.3105E+01	6.4943E+00	3.2115E+00];
hMb =   [2.6249E+01 1.3081E+01	6.5463E+00	3.3163E+00];
hRoot = [2.6249E+01 17.144	11.4794	7.7396];

figure(1)
plot(hloop,cdLoop,'o-');
hold on
plot(hMb,cdMb,'*-');
hold on
plot(hRoot,cdRoot,'.-');
grid on
title("Simulation error for Cd")
xlabel("Element size/mm")
ylabel("Error")
legend("Loop","Modified butterfly","R3");

figure(2)
plot(hloop,pLoop,'o-');
hold on
plot(hMb,pMb,'*-');
hold on
plot(hRoot,pRoot,'.-');
grid on
title("Simulation error for pressure")
xlabel("Element size/mm")
ylabel("Error/pa")
legend("Loop","Modified butterfly","R3");

figure(3)
plot(hloop,vLoop,'o-');
hold on
plot(hMb,vMb,'*-');
hold on
plot(hRoot,vRoot,'.-');
grid on
title("Simulation error for velocity")
xlabel("Element size/mm")
ylabel("Error/m/s")
legend("Loop","Modified butterfly","R3");
