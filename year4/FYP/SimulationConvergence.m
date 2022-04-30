clc
clear

cdLoop = [1.0679E-03	1.6460E-04	1.3500E-04	4.2000E-04];
cdMb = [1.0679E-03 3.8900E-04	3.0100E-04	1.5600E-04];
cdRoot = [1.0679E-03 1.0800E-04	1.6000E-05	3.0000E-06];

%point at 0.12 0.14
pLoop = [4.1300E+01	2.5700E+01	1.3900E+01	7.8000E+00];
vLoop = [6.7000E-01	2.4000E-01	7.0000E-02	3.2000E-01];

pMb = [4.1300E+01 1.1000E+01	2.1000E+00	1.3500E+01];
vMb = [6.7000E-01 2.4000E-01	6.0000E-01	1.1000E-01];

pRoot = [4.1300E+01 9.2000E+00	3.2000E+00	1.7100E+01];
vRoot = [6.7000E-01 1.3000E-01	2.5000E-01	1.9000E-01];

hloop = [2.6249E+01	1.3105E+01	6.4943E+00	3.2115E+00];
hMb = [2.6249E+01 1.3081E+01	6.5463E+00	3.3163E+00];
hRoot =[2.6249E+01 17.144	11.4794	7.7396];

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
