clear
clc
load('delrin.mat');
load('al.mat');
load('cf.mat');
E_delrin=table2array(G1Copy1(1:551,1));
F_delrin=table2array(G1Copy1(1:551,2));
E_cf=table2array(G1(1:202,1));
F_cf=table2array(G1(1:202,2));
E_al=table2array(G1CopyCopy(1:344,1));
F_al=table2array(G1CopyCopy(1:344,2));                   
strain_delrin=E_delrin./20;
stress_delrin=F_delrin./(12.19*1.02*0.000000001);
strain_cf=E_cf./80;
stress_cf=F_cf./(10.05*0.9*0.000000001);
strain_al=E_al./50;
stress_al=F_al./(6.19*2.51*0.000000001);

plot(strain_al,stress_al,'-r');
hold on
plot(strain_cf,stress_cf,'-k');
hold on
plot(strain_delrin,stress_delrin,'-b');
hold off
