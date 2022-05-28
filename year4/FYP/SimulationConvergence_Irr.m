clc
clear
%stl model h = 5.9546
%using Limited Resolution
%Irregular sphere
%point at 0.12 0.14
cdLoop = [5.5910E-03 2.3400E-04	1.6000E-05	1.1500E-04];
cdMb   = [5.5910E-03 1.6540E-03	1.6870E-03	1.9850E-03];
cdRoot = [5.5910E-03 5.4000E-04	1.8200E-04	2.5290E-04];

%%point at 0.12 0.14
%pLoop = [8.7500E+01	2.5900E+01	2.4700E+01	3.5000E+00];
%vLoop = [8.1000E-01	1.6000E-01	4.1000E-01	5.7000E-01];
%
%pMb =  [8.7500E+01 4.6000E+01	4.8300E+01	5.7400E+01];
%vMb =  [8.1000E-01 8.5000E-01	1.0900E+00	1.0900E+00];
%
%pRoot = [8.7500E+01 2.2000E+00	1.8700E+01	5.1700E+01];
%vRoot = [8.1000E-01 2.1000E-01	6.0000E-02	6.0000E-02];

hloop = [65.236, 31.240, 15.435,  7.693];
hMb =   [65.236, 33.230, 16.708,  8.369];   
hRoot = [65.236, 36.215, 20.620,  11.839];

figure(1)
plot(hloop,cdLoop,'o-');
hold on
plot(hMb,cdMb,'*-');
hold on
plot(hRoot,cdRoot,'.-');
grid on
xlabel("Element size/mm")
ylabel("Simulation error for drag coefficient")
legend("Loop","Modified Butterfly","$\sqrt{3}$");
