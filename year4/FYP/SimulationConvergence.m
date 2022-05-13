clc
clear

%using limited resolution
%Regular sphere

cdLoop = [1.2889E-03 3.8560E-04	3.5600E-04	1.9900E-04];
cdMb   = [1.2889E-03 6.1000E-04	5.2200E-04	6.5000E-05];
cdRoot = [1.2889E-03 1.1300E-04	2.0500E-04	2.1800E-04];

%point at 0.12 0.14
pLoop = [4.8700E+01	1.8300E+01	6.5000E+00	1.5200E+01];
vLoop = [9.6000E-01	5.0000E-02	3.6000E-01	6.1000E-01];

pMb =  [4.8700E+01 1.8400E+01	9.5000E+00	2.0900E+01];
vMb =  [9.6000E-01 5.3000E-01	8.9000E-01	1.8000E-01];

pRoot = [4.8700E+01	1.8000E+00	4.2000E+00	9.7000E+00];
vRoot = [9.6000E-01	1.6000E-01	5.4000E-01	1.0000E-01];

hloop = [2.6249E+01	1.3105E+01	6.4943E+00	3.2115E+00];
hMb =   [2.6249E+01 1.3081E+01	6.5463E+00	3.3163E+00];
hRoot = [2.6249E+01 17.144	11.4794	7.7396];

x = [1,2,3,4];
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
