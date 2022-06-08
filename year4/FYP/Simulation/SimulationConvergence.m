clc
clear

%using limited resolution
%Regular sphere

cdLoop = [1.2889E-03 3.8560E-04	3.5600E-04	1.9900E-04];
cdMb   = [1.2889E-03 3.5800E-04	3.1400E-04	6.5000E-05];
cdRoot = [1.2889E-03 2.2200E-04	1.9200E-04	1.2400E-04];
cdSTL = [1.1210E-03	5.6700E-04	4.1000E-04	1.4000E-05];

hloop = [25.733	12.768, 6.364, 3.178];
hMb =   [25.733 12.920, 6.473, 3.239];
hRoot = [25.733 14.767, 8.452, 4.890];
hSTL = [25.740 10.624 6.0495 3.337];


%%point at 0.12 0.14
%pLoop = [4.8700E+01	1.8300E+01	6.5000E+00	1.5200E+01];
%vLoop = [9.6000E-01	5.0000E-02	3.6000E-01	6.1000E-01];
%
%pMb =  [4.8700E+01 1.8400E+01	9.5000E+00	2.0900E+01];
%vMb =  [9.6000E-01 5.3000E-01	8.9000E-01	1.8000E-01];
%
%pRoot = [4.8700E+01	1.8000E+00	4.2000E+00	9.7000E+00];
%vRoot = [9.6000E-01	1.6000E-01	5.4000E-01	1.0000E-01];
%

x = [1,2,3,4];
figure(1)
plot(hloop,cdLoop,'o-');
hold on
plot(hMb,cdMb,'*-');
hold on
plot(hRoot,cdRoot,'->');
hold on
plot(hSTL,cdSTL,'.-');
grid on
xlabel("Element size/mm")
ylabel("Simulation error for drag coefficient")
legend("Loop","Modified Butterfly","$\sqrt{3}$","STL refined surface");
