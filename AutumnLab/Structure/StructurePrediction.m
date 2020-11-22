%structure prediction
clc
clear

%defining the variables:
G = 28e9;
gain = 1000;
s = 2.09;%strain gauge factor
load = [0:10:50];%in lbs
LBS2N = 4.44822;
A1 = 8487e-6;
A2 = 24507e-6;
L=286.663e-3 + 17.4e-3;%m
T = L.*load.*LBS2N;
%thickness
t18e = 0.64e-3;
t18i = 1.7e-3;
t12 = 2.34e-3;
t23 = 0.64e-3;
t34 = 2.23e-3;
t36 = 1.59e-3;

%lengths
s18e = 318e-3;
s18i = 81e-3;
s12 = 17.4e-3;
s23 = 286.66e-3;
s34 = 17.27e-3;
s36 = 81e-3;

var1 = [
    (s18e/t18e + s18i/t18i)/(2*A1*G),(-s18i/t18i)/(2*A1*G), -1
    (-s18i/t18i)/(2*A2*G),(2*s12/t12+2*s23/t23+s36/t36+s18i/t18i)/(2*A2*G), -1
    2*A1, 2*A2, 0
];
values = zeros(length(T),3);
for i = 1:length(T)
    values(i,:) = varSolver(var1,[0;0;T(i)]);
end
%values,same row, same torque. column1 q01 column2 q02 column3 dthetadz

%CDE is front FGH Upper IJK Bottom
%calculate the shear strain
shearStrainFront = (values(:,2) - values(:,1))./(G*t18i);
shearStrainUpper = (values(:,2))./(G*t23);
shearStrainBottom = (values(:,2))./(G*t23);
%bottom and upper are the same

%plot the diagram for pure torque loading shear strain vs applied load
figure(1)
plot(load,shearStrainFront,"r-*");
hold on
plot(load,shearStrainBottom,"b-o");
hold on
plot(load,shearStrainUpper,"b-*");
legend("Front surface","Upper surface","Lower surface");
title('Shear Strain Vs Load inPure torsion');
xlabel('Load/lbs');
ylabel('Shear strain');
hold off

%% Code for structure lab
%load = 10;
VoutCDE = [0.0335 0.0005 -0.031];
VoutFGH = [-0.031 -0.0895 -0.0775];
VoutIJK = [0.079 0.163 0.046];

%calculate the experimental strains
strainC = 4*VoutCDE(1)/(15*2.09*1000);
strainD = 4*VoutCDE(2)/(15*2.09*1000);
strainE = 4*VoutCDE(3)/(15*2.09*1000);

strainF = 4*VoutFGH(1)/(15*2.09*1000);
strainG = 4*VoutFGH(2)/(15*2.09*1000);
strainH = 4*VoutFGH(3)/(15*2.09*1000);

strainI = 4*VoutIJK(1)/(15*2.09*1000);
strainJ = 4*VoutIJK(2)/(15*2.09*1000);
strainK = 4*VoutIJK(3)/(15*2.09*1000);

%% functions
function x = varSolver(var1,var2)
    x = var1^(-1) * var2; 
end

