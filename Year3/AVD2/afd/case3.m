clear
clc

dx = 0.1;
FLength = 24.1;
x=[0:dx:FLength];
N=length(x);

load_f=3.75; %load factor

%Fuselage weight distribution
%cockpit
w_f(1:N)=0;
l_f_c=4.4/dx;
w_f(1:l_f_c+1)=-7.2267*9.81.*x(1:l_f_c+1).^2;
%cabin 
l_f_m=14.3/dx;
w_f(l_f_c+2:l_f_c+l_f_m+1)=-139.86*9.81;
%tail
l_f_t=5.4/dx;
w_f_t=-4.8*9.81.*[0:dx:5.3].^2;
w_f(l_f_c+l_f_m+2:l_f_c+l_f_m+l_f_t+1)=flip(w_f_t);

%% Payloads
%passenger weight distribution
w_p(1:N)=0;
w_p(63:173)=-52*85*9.81/10.96;
%cargo weight
w_p(167+9:167+9+10)=-918*9.81/0.9652;

%% Structures
%% Lifting surfaces
%wing
w=20829*0.97*0.985-1465.8-3672-280.7-148.4-137.8; %%fuselage mass
w_w(1:N)=0;
% wing box should be used as dimensions

%tail
w_t(1:N)=0;
% Assume the tail force will act at 21.9m,
f_t=100e3; % tail force
w_t(230)=f_t;

%% Stationary parts
%nacelle 
w_n(1:N)=0;
w_n(168:211)=-638.3*9.81/4.31;

%engine
w_e(1:N)=0;
w_e(175:204)=-1484*9.81/2.91;


% furnishing 
w_fur(1:N)=0;
w_fur(l_f_c+2:l_f_c+l_f_m+1)=-1191.9*9.81/14.3;

% air_conditioning
w_air(1:N)=0;
w_air(l_f_c+2:l_f_c+l_f_m+1)=-256*9.81/14.3;

%anti icing
w_ice(1:N)=-41.2*9.81/24.1;

%other masses(concentrated)
w_0(1:N)=0;
%nose landing gear
w_0(31)=-121*9.81;
% engine control & starter
w_0(190)=-(24.08+42.44)*9.81;
% fuel system
w_0(125)=-(76.98)*9.81;
% flight control
w_0(169)=-497.6*9.81;
% apu
w_0(214)=-319*9.81;
% intruments
w_0(18)=-439.8*9.81;
% hydrolic system 
w_0(121)=-95.37*9.81;
% avionic
w_0(12)=-697.8*9.81;
% handling gear
w_0(19)=6.2*9.81;
%pilot
w_0(30)=-2*85*9.81;



%total distributed load
w_tot=w_f+w_p+w_n+w_e+w_fur+w_air+w_ice;
%+w_t+w_0;

for i=1:N-1
   forced(i)=(w_tot(i)+w_tot(i+1))*dx/2; 
end
forced(N)=0;

% f1 f2 are rection forces from wing to fuselage
right=[-sum(forced+w_0)*load_f-sum(w_t);-sum(forced.*x+w_0.*x)*load_f-sum(w_t.*x)];
left=[1,1;11.3,13];
r=left\right;
w_w(113)=r(1);
w_w(130)=r(2);


%times the aerodynamic load by load factor
force=forced*load_f+w_w+w_0*load_f+w_t;

% shear force
for i=1:N
   sf(i)=sum(force(1:i));
end

%bending moment
dbm=w_tot.*x*dx*load_f;
for i=1:N
   bm(i)=sum(dbm(1:i))+sum(w_0(1:i).*x(1:i)*load_f+w_w(1:i).*x(1:i)+w_t(1:i).*x(1:i)); 
end

%%
figure (1);
plot(x,force,'linewidth',2);
grid on
hold on
title('Force distribution','interpreter','latex')
xlabel('x','interpreter','latex');
ylabel('force N/m','interpreter','latex');

figure (2);
plot(x,sf,'linewidth',2);
grid on
hold on
title('Shear force distribution','interpreter','latex')
xlabel('x','interpreter','latex')
ylabel('shear force N','interpreter','latex')


figure (3);
plot(x,bm,'linewidth',2);
grid on
hold on
title('Bending moment distribution','interpreter','latex')
xlabel('x','interpreter','latex');
ylabel('bending moment Nm','interpreter','latex');
%%
