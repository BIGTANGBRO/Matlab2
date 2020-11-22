clear
clc

%Gauge parameters
V_in=15;
S=2.09;
G=1000;

%% Load experimental data
load('Maha_Data.mat')

zeros_A_loading=voltage_loading_A(1,:);
zeros_A_unloading=voltage_unloading_A(1,:);

dimensions_loading_A=size(voltage_loading_A);
rows_loading_A=dimensions_loading_A(1,1);
columns_loading_A=dimensions_loading_A(1,2);

dimensions_unloading_A=size(voltage_unloading_A);
rows_unloading_A=dimensions_unloading_A(1,1);
columns_unloading_A=dimensions_unloading_A(1,2);



zeros_B_loading=voltage_loading_B(1,:);
zeros_B_unloading=voltage_unloading_B(1,:);

dimensions_loading_B=size(voltage_loading_B);
rows_loading_B=dimensions_loading_B(1,1);
columns_loading_B=dimensions_loading_B(1,2);

dimensions_unloading_B=size(voltage_unloading_A);
rows_unloading_B=dimensions_unloading_B(1,1);
columns_unloading_B=dimensions_unloading_B(1,2);

%% Clean data by substracting zero values
%Clean loading
for i=1:rows_loading_A 
    for j=1:columns_unloading_A
        V_out_loading_A(i,j)=voltage_loading_A(i,j)-zeros_A_loading(j);
    end   
end

%Clean unloading
for i=1:rows_unloading_A 
    for j=1:columns_unloading_A
        V_out_unloading_A(i,j)=voltage_unloading_A(i,j)-zeros_A_unloading(j);
    end   
end

for i=1:rows_loading_B 
    for j=1:columns_unloading_B
        V_out_loading_B(i,j)=voltage_loading_B(i,j)-zeros_B_loading(j);
    end   
end

%Clean unloading
for i=1:rows_unloading_B 
    for j=1:columns_unloading_B
        V_out_unloading_B(i,j)=voltage_unloading_B(i,j)-zeros_B_unloading(j);
    end   
end

%% LOADING CASE A: Load on rear spar

direct_strains_loading_A=(4*V_out_loading_A)/(V_in*S*G);
direct_strains_unloading_A=(4*V_out_unloading_A)/(V_in*S*G);

%Looking at the expressions for the rosette strains, subsituting the angles
%for +45deg and -45deg we get that:
% Rosette 1: gamma_xy=epsilon_C-epsilon_E Front Spar 
% Rosette 2: gamma_xy=epsilon_F-epsilon_H Upper Skin
% Rosette 3: gamma_xy=epsilon_I-epsilon_K Lower Skin

for i=1:rows_loading_A
        gammas_loading_ros1_A(i)=direct_strains_loading_A(i,1)-direct_strains_loading_A(i,3);
        gammas_loading_ros2_A(i)=direct_strains_loading_A(i,4)-direct_strains_loading_A(i,6);
        gammas_loading_ros3_A(i)=(direct_strains_loading_A(i,7)-direct_strains_loading_A(i,9))*-1;
        
        gammas_unloading_ros1_A(i)=direct_strains_unloading_A(i,1)-direct_strains_unloading_A(i,3);
        gammas_unloading_ros2_A(i)=direct_strains_unloading_A(i,4)-direct_strains_unloading_A(i,6);
        gammas_unloading_ros3_A(i)=(direct_strains_unloading_A(i,7)-direct_strains_unloading_A(i,9))*-1;

end

%Interpolation
loads=[0;13.5280000000000; 27.0560000000000; 40.5840000000000; 54.1120000000000; 67.6400000000000];
torque_loading_A=loads_loading_A'*0.30406*4.44822;
torque_unloading_A=loads_unloading_A'*0.30406*4.44822;

%Rosette 1 loading 
p=polyfit((loads/0.304),gammas_loading_ros1_A',1);
gammas_loading_ros1_A_plot=polyval(p,loads/0.304);
% gammas_loading_ros1_A_plot=polyval(p,loads/0.304)-p(2);
% gammas_loading_ros1_A=gammas_loading_ros1_A-p(2);
% gammas_loading_ros1_A(1)=0;

%Rosette 1 unloading

p=polyfit((loads/0.304),gammas_unloading_ros1_A',1);
gammas_unloading_ros1_A_plot=polyval(p,loads/0.304);
% gammas_unloading_ros1_A_plot=polyval(p,loads/0.304)-p(2);
% gammas_unloading_ros1_A=gammas_unloading_ros1_A-p(2);
% gammas_unloading_ros1_A(1)=0;

%Rosette 2 loading 
p=polyfit((loads/0.304),gammas_loading_ros2_A',1);
gammas_loading_ros2_A_plot=polyval(p,loads/0.304);
% gammas_loading_ros2_A_plot=polyval(p,loads/0.304)-p(2);
% gammas_loading_ros2_A=gammas_loading_ros2_A-p(2);
% gammas_loading_ros2_A(1)=0;

%Rosette 2 unloading

p=polyfit((loads/0.304),gammas_unloading_ros2_A',1);
gammas_unloading_ros2_A_plot=polyval(p,loads/0.304);
% gammas_unloading_ros2_A_plot=polyval(p,loads/0.304)-p(2);
% gammas_unloading_ros2_A=gammas_unloading_ros2_A-p(2);
% gammas_unloading_ros2_A(1)=0;


%Rosette 3 loading 
p=polyfit((loads/0.304),gammas_loading_ros3_A',1);
gammas_loading_ros3_A_plot=polyval(p,loads/0.304);
% gammas_loading_ros3_A_plot=polyval(p,loads/0.304)-p(2);
% gammas_loading_ros3_A=gammas_loading_ros3_A-p(2);
% gammas_loading_ros3_A(1)=0;

%Rosette 3 unloading

p=polyfit((loads/0.304),gammas_unloading_ros3_A',1);
gammas_unloading_ros3_A_plot=polyval(p,loads/0.304);
% gammas_unloading_ros3_A_plot=polyval(p,loads/0.304)-p(2);
% gammas_unloading_ros3_A=gammas_unloading_ros3_A-p(2);
% gammas_unloading_ros3_A(1)=0;




%% LOADING CASE B: Load on front spar
direct_strains_loading_B=(4*V_out_loading_B)/(V_in*S*G);
direct_strains_unloading_B=(4*V_out_unloading_B)/(V_in*S*G);
for i=1:rows_loading_B
        gammas_loading_ros1_B(i)=direct_strains_loading_B(i,1)-direct_strains_loading_B(i,3);
        gammas_loading_ros2_B(i)=direct_strains_loading_B(i,4)-direct_strains_loading_B(i,6);
        gammas_loading_ros3_B(i)=(direct_strains_loading_B(i,7)-direct_strains_loading_B(i,9))*-1;
        
        gammas_unloading_ros1_B(i)=direct_strains_unloading_B(i,1)-direct_strains_unloading_B(i,3);
        gammas_unloading_ros2_B(i)=direct_strains_unloading_B(i,4)-direct_strains_unloading_B(i,6);
        gammas_unloading_ros3_B(i)=(direct_strains_unloading_B(i,7)-direct_strains_unloading_B(i,9))*-1;
end

%Rosette 1 loading 
p=polyfit((loads/0.304),gammas_loading_ros1_B',1);
gammas_loading_ros1_B_plot=polyval(p,loads/0.304);
% gammas_loading_ros1_B_plot=polyval(p,loads/0.304)-p(2);
% gammas_loading_ros1_B=gammas_loading_ros1_B-p(2);
% gammas_loading_ros1_B(1)=0;

%Rosette 1 unloading

p=polyfit((loads/0.304),gammas_unloading_ros1_B',1);
gammas_unloading_ros1_B_plot=polyval(p,loads/0.304);
% gammas_unloading_ros1_B_plot=polyval(p,loads/0.304)-p(2);
% gammas_unloading_ros1_B=gammas_unloading_ros1_B-p(2);
% gammas_unloading_ros1_B(1)=0;

%Rosette 2 loading 
p=polyfit((loads/0.304),gammas_loading_ros2_B',1);
gammas_loading_ros2_B_plot=polyval(p,loads/0.304);
% gammas_loading_ros2_B_plot=polyval(p,loads/0.304)-p(2);
% gammas_loading_ros2_B=gammas_loading_ros2_B-p(2);
% gammas_loading_ros2_B(1)=0;

%Rosette 2 unloading

p=polyfit((loads/0.304),gammas_unloading_ros2_B',1);
gammas_unloading_ros2_B_plot=polyval(p,loads/0.304);
% gammas_unloading_ros2_B_plot=polyval(p,loads/0.304)-p(2);
% gammas_unloading_ros2_B=gammas_unloading_ros2_B-p(2);
% gammas_unloading_ros2_B(1)=0;


%Rosette 3 loading 
p=polyfit((loads/0.304),gammas_loading_ros3_B',1);
gammas_loading_ros3_B_plot=polyval(p,loads/0.304);
% gammas_loading_ros3_B_plot=polyval(p,loads/0.304)-p(2);
% gammas_loading_ros3_B=gammas_loading_ros3_B-p(2);
% gammas_loading_ros3_B(1)=0;

%Rosette 3 unloading

p=polyfit((loads/0.304),gammas_unloading_ros3_B',1);
gammas_unloading_ros3_B_plot=polyval(p,loads/0.304);
% gammas_unloading_ros3_B_plot=polyval(p,loads/0.304)-p(2);
% gammas_unloading_ros3_B=gammas_unloading_ros3_B-p(2);
% gammas_unloading_ros3_B(1)=0;
%% PURE TORSION: REAR-FRONT LOAD CASES

gammas_loading_ros1=gammas_loading_ros1_A-gammas_loading_ros1_B;
gammas_loading_ros1_plot=gammas_loading_ros1_A_plot-gammas_loading_ros1_B_plot;


gammas_loading_ros2=(gammas_loading_ros2_A-gammas_loading_ros2_B)*-1;
gammas_loading_ros2_plot=(gammas_loading_ros2_A_plot-gammas_loading_ros2_B_plot)*-1;


gammas_loading_ros3=gammas_loading_ros3_A-gammas_loading_ros3_B;
gammas_loading_ros3_plot=gammas_loading_ros3_A_plot-gammas_loading_ros3_B_plot;


gammas_unloading_ros1=gammas_unloading_ros1_A-gammas_unloading_ros1_B;
gammas_unloading_ros1_plot=gammas_unloading_ros1_A_plot-gammas_unloading_ros1_B_plot;

gammas_unloading_ros2=(gammas_unloading_ros2_A-gammas_unloading_ros2_B)*-1;
gammas_unloading_ros2_plot=(gammas_unloading_ros2_A_plot-gammas_unloading_ros2_B_plot)*-1;

gammas_unloading_ros3=gammas_unloading_ros3_A-gammas_unloading_ros3_B;
gammas_unloading_ros3_plot=gammas_unloading_ros3_A_plot-gammas_unloading_ros3_B_plot;

%% THEORETICAL CALCULATIONS
% Structure Data
G=28000; %Shear Modulus MPa
t_front_spar=1.7; %thickness front spar, mm
t_skin=0.64; %thickness skin, mm
L=0.30406; %Lever Arm
P=[0 10 20 30 40 50]; %Applied Load
lbs_to_N=4.44822;
P=P*lbs_to_N;
torque=P*L;
torque_unloading=torque;
% p=loads;

%Theoretical Shear flow calculations
q01_ratio=0.003527007418494; %From code Theoretical.mat
q02_ratio=0.004982098504070;

q_01=q01_ratio*P;
q_02=q02_ratio*P;

%Theoretical Shear strain calculations
gamma_theoretical_front_spar=(q_02-q_01)/(G*t_front_spar);
gamma_theoretical_skin=q_02./(G*t_skin);

%% PLOTS

figure(1)
hold on
plot(loads, gammas_loading_ros1,'ro')
plot(loads,gammas_loading_ros1_plot,'r--')
plot(loads,gammas_unloading_ros1,'b*')
plot(loads,gammas_unloading_ros1_plot,'b--')
plot(loads,gamma_theoretical_front_spar,'k')
legend('Loading','Loading (Linear','Unloading','Unloading (Linear)','Theoretical')
xlabel('Torque(Nm)')
ylabel('Shear strain')
title('Front Spar')
grid on
hold off

figure(2)
hold on
plot(loads, gammas_loading_ros2,'ro')
plot(loads,gammas_loading_ros2_plot,'r--')
plot(loads,gammas_unloading_ros2,'b*')
plot(loads,gammas_unloading_ros2_plot,'b--')
plot(loads,gammas_loading_ros3,'gd')
plot(loads,gammas_loading_ros3_plot,'g--')
plot(loads,gammas_unloading_ros3,'mx')
plot(loads,gammas_unloading_ros3_plot,'m--')
plot(torque,gamma_theoretical_skin,'k-')
legend('Upper skin Loading','Upper skin Loading (Linear)','Upper skin Unloading','Upper skin Unloading (Linear)','Lower skin Loading','Lower skin Loading (Linear)','Lower skin Unloading','Lower skin Unloading (Linear)','Theoretical')
xlabel('Torque(Nm)')
ylabel('Shear strain')
grid on
title('Skins')
hold off
