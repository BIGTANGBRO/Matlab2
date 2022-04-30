clc
clear
%Using high resolution
%point at 0.12 0.14
pLoop = [5.1300E+01	1.5700E+01	3.9000E+00	1.7800E+01];
vLoop = [5.0000E-01	4.1000E-01	1.0000E-01	1.5000E-01];
cdLoop = [1.8079E-03	9.0460E-04	8.7500E-04	3.2000E-04];
hloop = [2.6249E+01	1.3105E+01	6.4943E+00	3.2115E+00];

pMb = [5.1300E+01 2.1000E+01	1.2100E+01	2.3500E+01];
vMb = [5.0000E-01 7.0000E-02	4.3000E-01	2.8000E-01];
cdMb = [1.8079E-03 1.1290E-03	1.0410E-03	5.8400E-04];
hMb = [2.6249E+01 1.3081E+01	6.5463E+00	3.3163E+00];

pRoot = [5.1300E+01 8.0000E-01	6.8000E+00	7.1000E+00];
vRoot = [5.0000E-01 3.0000E-01	8.0000E-02	3.6000E-01];
cdRoot = [1.8079E-03 6.3200E-04	7.2400E-04	7.3700E-04];
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
