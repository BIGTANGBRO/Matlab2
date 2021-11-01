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
hold on 
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
%front matrix
%9 is C D E F G H I J K
%6 is 0 10 20 30 40 50; 5 is 50 40 30 20 10 0
frontShearDataLoading = zeros(9,6);
frontShearDataUnloading = zeros(9,6);

%rear matrix
rearShearDataLoading = zeros(9,6);
rearShearDataUnloading = zeros(9,6);

%front loading; shear strain calculation
frontShearStrainLoadingCDE = frontShearDataLoading(1,:) - frontShearDataLoading(3,:);
frontShearStrainLoadingFGH = frontShearDataLoading(4,:) - frontShearDataLoading(6,:);
frontShearStrainLoadingIJK = frontShearDataLoading(9,:) - frontShearDataLoading(9,:);

frontShearStrainUnloadingCDE = frontShearDataUnloading(1,:) - frontShearDataUnloading(3,:);
frontShearStrainUnloadingFGH = frontShearDataUnloading(4,:) - frontShearDataUnloading(6,:);
frontShearStrainUnloadingIJK = frontShearDataUnloading(9,:) - frontShearDataUnloading(9,:);

%rear loading; shear strain calculation
rearShearStrainLoadingCDE = rearShearDataLoading(1,:) - rearShearDataLoading(3,:);
rearShearStrainLoadingFGH = rearShearDataLoading(4,:) - rearShearDataLoading(6,:);
rearShearStrainLoadingIJK = rearShearDataLoading(9,:) - rearShearDataLoading(9,:);

rearShearStrainUnloadingCDE = rearShearDataUnloading(1,:) - rearShearDataUnloading(3,:);
rearShearStrainUnloadingFGH = rearShearDataUnloading(4,:) - rearShearDataUnloading(6,:);
rearShearStrainUnloadingIJK = rearShearDataUnloading(9,:) - rearShearDataUnloading(9,:);

loadsLoadingFront = [0,10,20,30,40,50];
loadsUnloadingFront = [50,40,30,20,10,0];
%need interpolation to make load front the same as load rear
loadsLoadingRear = [0,10,20,30,40,50];
loadsUnloadingRear = [50,40,30,20,10,0];

ShearStrainFrontLoading = rearShearStrainLoadingCDE - frontShearStrainLoadingCDE;
ShearStrainUpperLoading = rearShearStrainLoadingFGH- frontShearStrainLoadingFGH;
ShearStrainBottomLoading = rearShearStrainLoadingIJK - frontShearStrainLoadingIJK;

ShearStrainFrontUnLoading = rearShearStrainUnloadingCDE - frontShearStrainUnloadingCDE;
ShearStrainUpperUnloading = rearShearStrainUnloadingFGH- frontShearStrainUnloadingFGH;
ShearStrainBottomUnloading = rearShearStrainUnloadingIJK - frontShearStrainUnloadingIJK;

figure(2)
plot(loadsLoadingFront,ShearStrainFrontLoading,'r*');
hold on
plot(loadsUnloadingFront,ShearStrainFrontUnLoading,'ro');
hold off

figure(3)
plot(loadsLoadingFront,ShearStrainUpperLoading,'r*');
hold on
plot(loadsUnloadingFront,ShearStrainUpperUnloading,'ro');
hold on
plot(loadsLoadingFront,ShearStrainBottomLoading,'b--');
hold on
plot(loadsUnloadingFront,ShearStrainBottomUnloading,'b--');
hold off


%% functions
function x = varSolver(var1,var2)
    x = var1^(-1) * var2; 
end


