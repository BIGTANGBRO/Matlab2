% Aircraft Structures - Bending/Torsion of a Wing Structure's Lab
% By Claudia Jiménez Cuesta
clear
clc
%% Pre-lab - THEORETICAL SHEAR STRAINS
% Structure Data
G=28000; %Shear Modulus MPa
t_front_spar=1.7; %thickness front spar, mm
t_skin=0.64; %thickness skin, mm
L=0.30406; %Lever Arm
P=[0 10 20 30 40 50]; %Applied Load
lbs_to_N=4.44822;
P=P*lbs_to_N;
loads=P;
torque=P*L;
torque_unloading=torque;

%Theoretical Shear flow calculations
q01_ratio=0.003527007418494; %From code Theoretical.mat
q02_ratio=0.004982098504070;

q_01=q01_ratio*P;
q_02=q02_ratio*P;

%Theoretical Shear strain calculations
gamma_theoretical_front_spar=(q_02-q_01)/(G*t_front_spar);
gamma_theoretical_skin=q_02./(G*t_skin);

gamma_theoretical_front_spar=gamma_theoretical_front_spar*10^6;
gamma_theoretical_skin=gamma_theoretical_skin*10^6;



%% LAB
V_in=15;
S=2.09;
G=1000;

%% LOAD CASE A: Load on rear spar
% In the order C D E F G H I J K, for each (Epsilon c, Epsilon_b, Epsilon_a)
% Rosette 1: C D E :front spar
% Rosette 2: F G H : upper skin
% Rosette 3: I J K : lower skin

load('OurGroup.mat')
%Import variables: 
%zeros_A, voltage_loading_A, voltage_unloading_A
%zeros_B, voltage_loading_B, voltage_unloading_B


zeros_A_loading=direct_strains_loading_A(1,:);
zeros_A_unloading=direct_strains_unloading_A(1,:);

dimensions_loading_A=size(direct_strains_loading_A);
rows_loading_A=dimensions_loading_A(1,1);
columns_loading_A=dimensions_loading_A(1,2);

dimensions_unloading_A=size(direct_strains_unloading_A);
rows_unloading_A=dimensions_unloading_A(1,1);
columns_unloading_A=dimensions_unloading_A(1,2);



%% Clean data (substract zero readings)
%Clean loading
for i=1:rows_loading_A 
    for j=1:columns_unloading_A
        direct_strains_loading_A(i,j)=direct_strains_loading_A(i,j)-zeros_A_loading(j);
    end
end

%Clean unloading
for i=1:rows_unloading_A 
    for j=1:columns_unloading_A
        direct_strains_unloading_A(i,j)=direct_strains_unloading_A(i,j)-zeros_A_unloading(j);
    end   
end

%% STRAINS IN LOADING
%direct_strains_loading_A=(4*V_out_loading_A)/(V_in*S*G);

%Noting
%direct_strain=Strain_x*cos^2(theta)+Strain_y*sin^2(theta)+Strain_xy*sin(theta)*cos(theta)
coeffs=[(cosd(45)^2) (sind(45)^2) (sind(45)*cosd(45)) ; (cosd(0)^2) (sind(0)^2) (sind(0)*cosd(0)) ; (cosd(-45)^2) (sind(-45)^2) (sind(-45)*cosd(-45))]; 

%Sort direct strains (epsilon_n) for each rosette
epsilons_n_loading_ros1_A=direct_strains_loading_A(:, 1:3);
epsilons_n__loading_ros2_A=direct_strains_loading_A(:, 4:6);
epsilons_n_loading_ros3_A=direct_strains_loading_A(:, 7:9);

%Rosette 1 ( C D E)
%Solve system for each load case, strains_loading_rosX is a vector
%containing epsilon_x, epsilon_y and epsilon_xy
Strains_loading_ros1_0_A=linsolve(coeffs, (epsilons_n_loading_ros1_A(1,:))'); 
Strains_loading_ros1_10_A=linsolve(coeffs, (epsilons_n_loading_ros1_A(2,:))');
Strains_loading_ros1_20_A=linsolve(coeffs, (epsilons_n_loading_ros1_A(3,:))');
Strains_loading_ros1_30_A=linsolve(coeffs, (epsilons_n_loading_ros1_A(4,:))');
Strains_loading_ros1_40_A=linsolve(coeffs, (epsilons_n_loading_ros1_A(5,:))');
Strains_loading_ros1_50_A=linsolve(coeffs, (epsilons_n_loading_ros1_A(6,:))');

gammas_loading_ros1_A=[Strains_loading_ros1_0_A(3), Strains_loading_ros1_10_A(3), Strains_loading_ros1_20_A(3), Strains_loading_ros1_30_A(3), Strains_loading_ros1_40_A(3), Strains_loading_ros1_50_A(3)];

%Rosette 2 ( F G H)
Strains_loading_ros2_0_A=linsolve(coeffs, (epsilons_n__loading_ros2_A(1,:))'); 
Strains_loading_ros2_10_A=linsolve(coeffs, (epsilons_n__loading_ros2_A(2,:))');
Strains_loading_ros2_20_A=linsolve(coeffs, (epsilons_n__loading_ros2_A(3,:))');
Strains_loading_ros2_30_A=linsolve(coeffs, (epsilons_n__loading_ros2_A(4,:))');
Strains_loading_ros2_40_A=linsolve(coeffs, (epsilons_n__loading_ros2_A(5,:))');
Strains_loading_ros2_50_A=linsolve(coeffs, (epsilons_n__loading_ros2_A(6,:))');


gammas_loading_ros2_A=[Strains_loading_ros2_0_A(3), Strains_loading_ros2_10_A(3), Strains_loading_ros2_20_A(3), Strains_loading_ros2_30_A(3), Strains_loading_ros2_40_A(3), Strains_loading_ros2_50_A(3)];
gammas_loading_ros2_A=gammas_loading_ros2_A*-1;
%Rosette 3 ( I J K)
Strains_loading_ros3_0_A=linsolve(coeffs, (epsilons_n_loading_ros3_A(1,:))'); 
Strains_loading_ros3_10_A=linsolve(coeffs, (epsilons_n_loading_ros3_A(2,:))');
Strains_loading_ros3_20_A=linsolve(coeffs, (epsilons_n_loading_ros3_A(3,:))');
Strains_loading_ros3_30_A=linsolve(coeffs, (epsilons_n_loading_ros3_A(4,:))');
Strains_loading_ros3_40_A=linsolve(coeffs, (epsilons_n_loading_ros3_A(5,:))');
Strains_loading_ros3_50_A=linsolve(coeffs, (epsilons_n_loading_ros3_A(6,:))');


gammas_loading_ros3_A=[Strains_loading_ros3_0_A(3), Strains_loading_ros3_10_A(3), Strains_loading_ros3_20_A(3), Strains_loading_ros3_30_A(3), Strains_loading_ros3_40_A(3), Strains_loading_ros3_50_A(3)];

gammas_loading_ros3_A=gammas_loading_ros3_A*-1;

%% UNLOADING LOAD CASE A
%direct_strains_unloading_A=(4*V_out_unloading_A)/(V_in*S*G);


epsilons_n_unloading_ros1_A=direct_strains_unloading_A(:, 1:3);
epsilons_n__unloading_ros2_A=direct_strains_unloading_A(:, 4:6);
epsilons_n_unloading_ros3_A=direct_strains_unloading_A(:, 7:9);

%Rosette 1 ( C D E)
Strains_unloading_ros1_0_A=linsolve(coeffs, (epsilons_n_unloading_ros1_A(1,:))'); 
Strains_unloading_ros1_10_A=linsolve(coeffs, (epsilons_n_unloading_ros1_A(2,:))');
Strains_unloading_ros1_20_A=linsolve(coeffs, (epsilons_n_unloading_ros1_A(3,:))');
Strains_unloading_ros1_30_A=linsolve(coeffs, (epsilons_n_unloading_ros1_A(4,:))');
Strains_unloading_ros1_40_A=linsolve(coeffs, (epsilons_n_unloading_ros1_A(5,:))');
Strains_unloading_ros1_50_A=linsolve(coeffs, (epsilons_n_unloading_ros1_A(6,:))');

gammas_unloading_ros1_A=[Strains_unloading_ros1_0_A(3), Strains_unloading_ros1_10_A(3), Strains_unloading_ros1_20_A(3), Strains_unloading_ros1_30_A(3), Strains_unloading_ros1_40_A(3), Strains_unloading_ros1_50_A(3)];
%gammas_unloading_ros1_A=flip(gammas_unloading_ros1_A);

%Rosette 2 ( F G H)
Strains_unloading_ros2_0_A=linsolve(coeffs, (epsilons_n__unloading_ros2_A(1,:))'); 
Strains_unloading_ros2_10_A=linsolve(coeffs, (epsilons_n__unloading_ros2_A(2,:))');
Strains_unloading_ros2_20_A=linsolve(coeffs, (epsilons_n__unloading_ros2_A(3,:))');
Strains_unloading_ros2_30_A=linsolve(coeffs, (epsilons_n__unloading_ros2_A(4,:))');
Strains_unloading_ros2_40_A=linsolve(coeffs, (epsilons_n__unloading_ros2_A(5,:))');
Strains_unloading_ros2_50_A=linsolve(coeffs, (epsilons_n__unloading_ros2_A(6,:))');


gammas_unloading_ros2_A=[Strains_unloading_ros2_0_A(3), Strains_unloading_ros2_10_A(3), Strains_unloading_ros2_20_A(3), Strains_unloading_ros2_30_A(3), Strains_unloading_ros2_40_A(3), Strains_unloading_ros2_50_A(3)];
%gammas_unloading_ros2_A=flip(gammas_unloading_ros2_A);
gammas_unloading_ros2_A=gammas_unloading_ros2_A*-1;
%Rosette 3 ( I J K)
Strains_unloading_ros3_0_A=linsolve(coeffs, (epsilons_n_unloading_ros3_A(1,:))'); 
Strains_unloading_ros3_10_A=linsolve(coeffs, (epsilons_n_unloading_ros3_A(2,:))');
Strains_unloading_ros3_20_A=linsolve(coeffs, (epsilons_n_unloading_ros3_A(3,:))');
Strains_unloading_ros3_30_A=linsolve(coeffs, (epsilons_n_unloading_ros3_A(4,:))');
Strains_unloading_ros3_40_A=linsolve(coeffs, (epsilons_n_unloading_ros3_A(5,:))');
Strains_unloading_ros3_50_A=linsolve(coeffs, (epsilons_n_unloading_ros3_A(6,:))');


gammas_unloading_ros3_A=[Strains_unloading_ros3_0_A(3), Strains_unloading_ros3_10_A(3), Strains_unloading_ros3_20_A(3), Strains_unloading_ros3_30_A(3), Strains_unloading_ros3_40_A(3), Strains_unloading_ros3_50_A(3)];
%gammas_unloading_ros3_A=flip(gammas_unloading_ros3_A);
gammas_unloading_ros3_A=gammas_unloading_ros3_A*-1;

%% LOAD CASE B: Load on rear spar
% In the order C D E F G H I J K, for each (Epsilon c, Epsilon_b, Epsilon_a)
% Rosette 1: C D E 
% Rosette 2: F G H
% Rosette 3: I J K


zeros_B_loading=direct_strains_loading_B(1,:);
zeros_B_unloading=direct_strains_unloading_B(1,:);

dimensions_loading_B=size(direct_strains_loading_B);
rows_loading_B=dimensions_loading_B(1,1);
columns_loading_B=dimensions_loading_B(1,2);

dimensions_unloading_B=size(direct_strains_unloading_B);
rows_unloading_B=dimensions_unloading_B(1,1);
columns_unloading_B=dimensions_unloading_B(1,2);



%Clean loading
for i=1:rows_loading_B 
    for j=1:columns_unloading_B
        direct_strains_loading_B(i,j)=direct_strains_loading_B(i,j)-zeros_B_loading(j);
    end
end

%Clean unloading
for i=1:rows_unloading_B 
    for j=1:columns_unloading_B
        direct_strains_unloading_B(i,j)=direct_strains_unloading_B(i,j)-zeros_B_unloading(j);
    end   
end


%direct_strains_loading_B=(4*V_out_loading_B)/(V_in*S*G);

epsilons_n_loading_ros1_B=direct_strains_loading_B(:, 1:3);
epsilons_n__loading_ros2_B=direct_strains_loading_B(:, 4:6);
epsilons_n_loading_ros3_B=direct_strains_loading_B(:, 7:9);

%Rosette 1 ( C D E)
Strains_loading_ros1_0_B=linsolve(coeffs, (epsilons_n_loading_ros1_B(1,:))'); 
Strains_loading_ros1_10_B=linsolve(coeffs, (epsilons_n_loading_ros1_B(2,:))');
Strains_loading_ros1_20_B=linsolve(coeffs, (epsilons_n_loading_ros1_B(3,:))');
Strains_loading_ros1_30_B=linsolve(coeffs, (epsilons_n_loading_ros1_B(4,:))');
Strains_loading_ros1_40_B=linsolve(coeffs, (epsilons_n_loading_ros1_B(5,:))');
Strains_loading_ros1_50_B=linsolve(coeffs, (epsilons_n_loading_ros1_B(6,:))');

gammas_loading_ros1_B=[Strains_loading_ros1_0_B(3), Strains_loading_ros1_10_B(3), Strains_loading_ros1_20_B(3), Strains_loading_ros1_30_B(3), Strains_loading_ros1_40_B(3), Strains_loading_ros1_50_B(3)];

%Rosette 2 ( F G H)
Strains_loading_ros2_0_B=linsolve(coeffs, (epsilons_n__loading_ros2_B(1,:))'); 
Strains_loading_ros2_10_B=linsolve(coeffs, (epsilons_n__loading_ros2_B(2,:))');
Strains_loading_ros2_20_B=linsolve(coeffs, (epsilons_n__loading_ros2_B(3,:))');
Strains_loading_ros2_30_B=linsolve(coeffs, (epsilons_n__loading_ros2_B(4,:))');
Strains_loading_ros2_40_B=linsolve(coeffs, (epsilons_n__loading_ros2_B(5,:))');
Strains_loading_ros2_50_B=linsolve(coeffs, (epsilons_n__loading_ros2_B(6,:))');


gammas_loading_ros2_B=[Strains_loading_ros2_0_B(3), Strains_loading_ros2_10_B(3), Strains_loading_ros2_20_B(3), Strains_loading_ros2_30_B(3), Strains_loading_ros2_40_B(3), Strains_loading_ros2_50_B(3)];
gammas_loading_ros2_B=gammas_loading_ros2_B*-1;
%Rosette 3 ( I J K)
Strains_loading_ros3_0_B=linsolve(coeffs, (epsilons_n_loading_ros3_B(1,:))'); 
Strains_loading_ros3_10_B=linsolve(coeffs, (epsilons_n_loading_ros3_B(2,:))');
Strains_loading_ros3_20_B=linsolve(coeffs, (epsilons_n_loading_ros3_B(3,:))');
Strains_loading_ros3_30_B=linsolve(coeffs, (epsilons_n_loading_ros3_B(4,:))');
Strains_loading_ros3_40_B=linsolve(coeffs, (epsilons_n_loading_ros3_B(5,:))');
Strains_loading_ros3_50_B=linsolve(coeffs, (epsilons_n_loading_ros3_B(6,:))');


gammas_loading_ros3_B=[Strains_loading_ros3_0_B(3), Strains_loading_ros3_10_B(3), Strains_loading_ros3_20_B(3), Strains_loading_ros3_30_B(3), Strains_loading_ros3_40_B(3), Strains_loading_ros3_50_B(3)];
gammas_loading_ros3_B=gammas_loading_ros3_B*-1;


%% UNLOADING LOAD CASE B
%direct_strains_unloading_B=(4*V_out_unloading_B)/(V_in*S*G);

%coeffs=[(cosd(90)^2) (sind(90)^2) (sind(90)*cosd(90)) ; (cosd(45)^2) (sind(45)^2) (sind(45)*cosd(45)) ; (cosd(0)^2) (sind(0)^2) (sind(0)*cosd(0))]; 

epsilons_n_unloading_ros1_B=direct_strains_unloading_B(:, 1:3);
epsilons_n__unloading_ros2_B=direct_strains_unloading_B(:, 4:6);
epsilons_n_unloading_ros3_B=direct_strains_unloading_B(:, 7:9);

%Rosette 1 ( C D E)
Strains_unloading_ros1_0_B=linsolve(coeffs, (epsilons_n_unloading_ros1_B(1,:))'); 
Strains_unloading_ros1_10_B=linsolve(coeffs, (epsilons_n_unloading_ros1_B(2,:))');
Strains_unloading_ros1_20_B=linsolve(coeffs, (epsilons_n_unloading_ros1_B(3,:))');
Strains_unloading_ros1_30_B=linsolve(coeffs, (epsilons_n_unloading_ros1_B(4,:))');
Strains_unloading_ros1_40_B=linsolve(coeffs, (epsilons_n_unloading_ros1_B(5,:))');
Strains_unloading_ros1_50_B=linsolve(coeffs, (epsilons_n_unloading_ros1_B(6,:))');

gammas_unloading_ros1_B=[Strains_unloading_ros1_0_B(3), Strains_unloading_ros1_10_B(3), Strains_unloading_ros1_20_B(3), Strains_unloading_ros1_30_B(3), Strains_unloading_ros1_40_B(3), Strains_unloading_ros1_50_B(3)];
%gammas_unloading_ros1_B=flip(gammas_unloading_ros1_B);
%Rosette 2 ( F G H)
Strains_unloading_ros2_0_B=linsolve(coeffs, (epsilons_n__unloading_ros2_B(1,:))'); 
Strains_unloading_ros2_10_B=linsolve(coeffs, (epsilons_n__unloading_ros2_B(2,:))');
Strains_unloading_ros2_20_B=linsolve(coeffs, (epsilons_n__unloading_ros2_B(3,:))');
Strains_unloading_ros2_30_B=linsolve(coeffs, (epsilons_n__unloading_ros2_B(4,:))');
Strains_unloading_ros2_40_B=linsolve(coeffs, (epsilons_n__unloading_ros2_B(5,:))');
Strains_unloading_ros2_50_B=linsolve(coeffs, (epsilons_n__unloading_ros2_B(6,:))');


gammas_unloading_ros2_B=[Strains_unloading_ros2_0_B(3), Strains_unloading_ros2_10_B(3), Strains_unloading_ros2_20_B(3), Strains_unloading_ros2_30_B(3), Strains_unloading_ros2_40_B(3), Strains_unloading_ros2_50_B(3)];
%gammas_unloading_ros2_B=flip(gammas_unloading_ros2_B);
gammas_unloading_ros2_B=gammas_unloading_ros2_B*-1;
%Rosette 3 ( I J K)
Strains_unloading_ros3_0_B=linsolve(coeffs, (epsilons_n_unloading_ros3_B(1,:))'); 
Strains_unloading_ros3_10_B=linsolve(coeffs, (epsilons_n_unloading_ros3_B(2,:))');
Strains_unloading_ros3_20_B=linsolve(coeffs, (epsilons_n_unloading_ros3_B(3,:))');
Strains_unloading_ros3_30_B=linsolve(coeffs, (epsilons_n_unloading_ros3_B(4,:))');
Strains_unloading_ros3_40_B=linsolve(coeffs, (epsilons_n_unloading_ros3_B(5,:))');
Strains_unloading_ros3_50_B=linsolve(coeffs, (epsilons_n_unloading_ros3_B(6,:))');


gammas_unloading_ros3_B=[Strains_unloading_ros3_0_B(3), Strains_unloading_ros3_10_B(3), Strains_unloading_ros3_20_B(3), Strains_unloading_ros3_30_B(3), Strains_unloading_ros3_40_B(3), Strains_unloading_ros3_50_B(3)];
%gammas_unloading_ros3_B=flip(gammas_unloading_ros3_B);
gammas_unloading_ros3_B=gammas_unloading_ros3_B*-1;

%% INTERPOLATING ENFORCING ZERO CONDITION
torque_A_loading=loads_loading_A*0.30406*4.4482;
torque_A_unloading=loads_loading_A*0.30406*4.4482;
torque_B_loading=loads_loading_B*0.30406*4.4482;
torque_B_unloading=loads_loading_B*0.30406*4.4482;

%Rosette 1 loading 
p=polyfit(torque_A_loading,gammas_loading_ros1_A',1);
gammas_loading_ros1_A_plot=polyval(p,torque)-p(2);
gammas_loading_ros1_A=gammas_loading_ros1_A-p(2);
gammas_loading_ros1_A(1)=0;

%Rosette 1 unloading

p=polyfit(torque_A_unloading,gammas_unloading_ros1_A',1);
gammas_unloading_ros1_A_plot=polyval(p,torque)-p(2);
gammas_unloading_ros1_A=gammas_unloading_ros1_A-p(2);
gammas_unloading_ros1_A(1)=0;

%Rosette 2 loading 
p=polyfit(torque_A_loading,gammas_loading_ros2_A',1);
gammas_loading_ros2_A_plot=polyval(p,torque)-p(2);
gammas_loading_ros2_A=gammas_loading_ros2_A-p(2);
gammas_loading_ros2_A(1)=0;

%Rosette 2 unloading

p=polyfit(torque_A_unloading,gammas_unloading_ros2_A',1);
gammas_unloading_ros2_A_plot=polyval(p,torque)-p(2);
gammas_unloading_ros2_A=gammas_unloading_ros2_A-p(2);
gammas_unloading_ros2_A(1)=0;


%Rosette 3 loading 
p=polyfit(torque_A_loading,gammas_loading_ros3_A',1);
gammas_loading_ros3_A_plot=polyval(p,torque)-p(2);
gammas_loading_ros3_A=gammas_loading_ros3_A-p(2);
gammas_loading_ros3_A(1)=0;

%Rosette 3 unloading

p=polyfit(torque_A_unloading,gammas_unloading_ros3_A',1);
gammas_unloading_ros3_A_plot=polyval(p,torque)-p(2);
gammas_unloading_ros3_A=gammas_unloading_ros3_A-p(2);
gammas_unloading_ros3_A(1)=0;

%% LOAD CASE B
%Rosette 1 loading 
p=polyfit(torque_B_loading,gammas_loading_ros1_B',1);
gammas_loading_ros1_B_plot=polyval(p,torque)-p(2);
gammas_loading_ros1_B=gammas_loading_ros1_B-p(2);
gammas_loading_ros1_B(1)=0;

%Rosette 1 unloading

p=polyfit(torque_B_unloading,gammas_unloading_ros1_B',1);
gammas_unloading_ros1_B_plot=polyval(p,torque)-p(2);
gammas_unloading_ros1_B=gammas_unloading_ros1_B-p(2);
gammas_unloading_ros1_B(1)=0;

%Rosette 2 loading 
p=polyfit(torque_B_loading,gammas_loading_ros2_B',1);
gammas_loading_ros2_B_plot=polyval(p,torque)-p(2);
gammas_loading_ros2_B=gammas_loading_ros2_B-p(2);
gammas_loading_ros2_B(1)=0;

%Rosette 2 unloading

p=polyfit(torque_B_unloading,gammas_unloading_ros2_B',1);
gammas_unloading_ros2_B_plot=polyval(p,torque)-p(2);
gammas_unloading_ros2_B=gammas_unloading_ros2_B-p(2);
gammas_unloading_ros2_B(1)=0;


%Rosette 3 loading 
p=polyfit(torque_B_loading,gammas_loading_ros3_B',1);
gammas_loading_ros3_B_plot=polyval(p,torque)-p(2);
gammas_loading_ros3_B=gammas_loading_ros3_B-p(2);
gammas_loading_ros3_B(1)=0;

%Rosette 3 unloading

p=polyfit(torque_B_unloading,gammas_unloading_ros3_B',1);
gammas_unloading_ros3_B_plot=polyval(p,torque)-p(2);
gammas_unloading_ros3_B=gammas_unloading_ros3_B-p(2);
gammas_unloading_ros3_B(1)=0;
%% CALCULATING SHEAR STRAINS: REAR-FRONT CASES

gammas_loading_ros1=gammas_loading_ros1_A-gammas_loading_ros1_B;
gammas_loading_ros2=gammas_loading_ros2_A-gammas_loading_ros2_B;
gammas_loading_ros3=gammas_loading_ros3_A-gammas_loading_ros3_B;


gammas_unloading_ros1=gammas_unloading_ros1_A-gammas_unloading_ros1_B;
gammas_unloading_ros2=gammas_unloading_ros2_A-gammas_unloading_ros2_B;
gammas_unloading_ros3=gammas_unloading_ros3_A-gammas_unloading_ros3_B;



% SUBSTRACTING PLOTS
gammas_loading_ros1_plot=gammas_loading_ros1_A_plot-gammas_loading_ros1_B_plot;
gammas_loading_ros2_plot=gammas_loading_ros2_A_plot-gammas_loading_ros2_B_plot;
gammas_loading_ros3_plot=gammas_loading_ros3_A_plot-gammas_loading_ros3_B_plot;
gammas_unloading_ros1_plot=gammas_unloading_ros1_A_plot-gammas_unloading_ros1_B_plot;
gammas_unloading_ros2_plot=gammas_unloading_ros2_A_plot-gammas_unloading_ros2_B_plot;
gammas_unloading_ros3_plot=gammas_unloading_ros3_A_plot-gammas_unloading_ros3_B_plot;

figure('Name','Theoretical')
hold on
plot(torque,gamma_theoretical_front_spar,'r-o','MarkerFaceColor', 'r','LineWidth',1)
plot(torque, gamma_theoretical_skin, 'bd-','MarkerFaceColor', 'b','LineWidth',1)
xlabel('Torque (Nm)')
ylabel('Shear Strain \mu\gamma')
title('Theoretical Shear Strains')
legend('Front Spar','Skin')
grid on
hold off

figure('Name','Front Spar')
hold on
plot(torque, gammas_loading_ros1,'ro','MarkerFaceColor', 'r')
plot(torque,gammas_loading_ros1_plot,'r--','LineWidth',1)
plot(torque,gammas_unloading_ros1,'b*','MarkerFaceColor', 'b')
plot(torque,gammas_unloading_ros1_plot,'b--','LineWidth',1)
plot(torque,gamma_theoretical_front_spar,'kd-','MarkerFaceColor', 'k','LineWidth',1)
legend('Loading','Loading (Linear','Unloading','Unloading (Linear)','Theoretical')
xlabel('Torque(Nm)')
ylabel('Shear strain \mu\gamma')
title('Shear Strains in Front Spar')
grid on
hold off

figure('Name','Skins')
hold on
plot(torque, gammas_loading_ros2,'ro','MarkerFaceColor', 'r')
plot(torque,gammas_loading_ros2_plot,'r--','LineWidth',1)
plot(torque,gammas_unloading_ros2,'bs','MarkerFaceColor', 'b')
plot(torque,gammas_unloading_ros2_plot,'b--','LineWidth',1)
plot(torque,gammas_loading_ros3,'gd','MarkerFaceColor', 'g')
plot(torque,gammas_loading_ros3_plot,'g--','LineWidth',1)
plot(torque,gammas_unloading_ros3,'m^','MarkerFaceColor', 'm')
plot(torque,gammas_unloading_ros3_plot,'m--','LineWidth',1)
plot(torque,gamma_theoretical_skin,'k*-','MarkerFaceColor', 'k','LineWidth',1)
legend('Upper skin Loading','Upper skin Loading (Linear)','Upper skin Unloading','Upper skin Unloading (Linear)','Lower skin Loading','Lower skin Loading (Linear)','Lower skin Unloading','Lower skin Unloading (Linear)','Theoretical')
xlabel('Torque(Nm)')
ylabel('Shear strain \mu\gamma')
grid on
title('Shear Strains in Skins')
hold off

% %% PLOTTING SHEARS FOR INDIVIDUAL LOAD CASES
% figure('Name', 'Front Spar Load Case')
% subplot(2,1,1)
% hold on
% grid on
% plot(loads_loading_B, gammas_loading_ros1_B,'bo-')
% plot(loads_unloading_B, gammas_unloading_ros1_B,'ro-')
% title('Strains in Front Spar')
% legend('Loading','Unloading')
% xlabel('Applied Load (N)')
% ylabel('Shear Strain')
% title('Front Spar')
% hold off
% 
% subplot(2,1,2)
% hold on
% grid on
% plot(loads_loading_B,gammas_loading_ros2_B,'bo-')
% plot(loads_unloading_B,gammas_unloading_ros2_B,'b*:')
% plot(loads_loading_B,gammas_loading_ros3_B,'ro-')
% plot(loads_unloading_B,gammas_unloading_ros3_B,'r*:')
% legend('Upper Skin Loading','Upper Skin Unloading','Lower Skin Loading','Lower Skin Unloading')
% title('Skins')
% xlabel('Applied Load (N)')
% ylabel('Shear Strain')
% hold off
% 
% figure('Name', 'Rear Spar Load Case')
% subplot(2,1,1)
% hold on
% grid on
% plot(loads_loading_A, gammas_loading_ros1_A,'bo-')
% plot(loads_unloading_A, gammas_unloading_ros1_A,'ro-')
% title('Strains in Front Spar')
% legend('Loading','Unloading')
% xlabel('Applied Load (N)')
% ylabel('Shear Strain')
% title('Front Spar')
% hold off
% 
% subplot(2,1,2)
% hold on
% grid on
% plot(loads_loading_A,gammas_loading_ros2_A,'bo-')
% plot(loads_unloading_A,gammas_unloading_ros2_A,'b*:')
% plot(loads_loading_A,gammas_loading_ros3_A,'ro-')
% plot(loads_unloading_A,gammas_unloading_ros3_A,'r*:')
% legend('Upper Skin Loading','Upper Skin Unloading','Lower Skin Loading','Lower Skin Unloading')
% title('Skins')
% xlabel('Applied Load (N)')
% ylabel('Shear Strain')
% hold off