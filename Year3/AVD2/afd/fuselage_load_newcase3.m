clear all
clc
close all

%%
y_t=[1.49,1.49]; % horizontal tail moment arm
z_v=[1.64,1.64+0.36]; % vertical tail moment arm
R=[1.25/2,0.82/2];   % fuselage radius

F_hl=75e3; % Force on left horizontal tail 
F_hr=25e3; % Force on right horizontal tail
F_v=50e3;  % Force on vertical tail

%%
T=y_t*F_hr-y_t*F_hl-z_v*F_v; %Tortion on the fuselage (+ve anticlockwise)
T_ave=-sum(T)/2;
 
%% torque distribution 
Flength=24.1;
dx=0.1;
x=[0:0.1:24.1];

l_cock=4.4;
r(1:l_cock/dx)=linspace(0,1.5,l_cock/dx);
l_fuse=14.2;
r(l_cock/dx+1:187)=1.5;
l_aft=5.4;
r(188:242)=linspace(1.5,0,55);

q=T_ave./(2*pi.*r.^2); %Shear flow on the skin q=T/(2pir^2)
q(1)=q(2);
q(length(x))=q(length(x)-1);

figure (1);
plot(x,q,'linewidth',2);
grid on
title('Shear Flow Distribution','interpreter','latex')
xlabel('x','interpreter','latex');
ylabel('Shear flow N/m','interpreter','latex');
%%