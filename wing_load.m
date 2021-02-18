%Wing load calculation
clear
clc
close all
%% Geometry and load setup
%Cruise conditions
[~,a_cruise,~,rho_cruise]=atmosisa(35000*0.3048);
M = 0.8;
V_cruise = M * a_cruise;
V_max = V_cruise*1.25;% V_cruise = 0.8 V_max FAR 25

bf = 10.02;  %wing semispan from the root at fuselage joint
n = 3.75;   %ultimate load factor
nn = -1; %negative extreme
N = 100; % number of discretisation
dy = bf/(N-1); % size of intervals
y = 0 : dy : bf; % spanwise discretisation 
W = 20829*0.97*0.985*0.92; % weight at cruise altitude with no fuel
L = n*W*9.81/2; % lift on one side of the wing
Ln = nn*W*9.81/2; % lift on one side of the wing

c_r = 3.66-(3.66-0.91)/11.52*1.5; % root chord
c_t = 0.91; % tip chord
%angle of flexural axis
sweep = deg2rad(26.3);
theta = atan((tan(sweep)*bf+0.15*(c_t-c_r))/bf);
c = c_r : -(c_r-c_t)/(N-1) :c_t; % aero chord length distribution
%% structural coordinate
%structural span
bs = bf/cos(theta);
dx = bs/(N-1);
x = 0 : dx : bs;
%leading and trailing edge sweep angle
alead = atan((tan(sweep)*bf-0.25*(c_t-c_r))/bf);
atrai = atan((tan(sweep)*bf+0.75*(c_t-c_r))/bf);
lright = c_r/(tan(alead)-tan(atrai));
lflex = lright/cos(theta);
cs = (lflex-x/cos(theta))*(tan(alead-theta)+tan(theta-atrai));
%% distributed loads
% elliptic lift distribution
elli = (1-(y).^2/(bf)^2).^0.5;
% elli (1,1:floor(1.5/11.52*N))=zeros(1,floor(1.5/11.52*N));
l_wing = elli*L/trapz(y,elli);
l_wingn = elli*Ln/trapz(y,elli);
% distributed wing self-weight
W_wing = -1465.8*9.81/2; % weight of wing
t2c = [ones(1,floor((0.3*11.52-1.5)/10.02*N))*0.14 ones(1,N-floor((0.3*11.52-1.5)/10.02*N))*0.1];% thickness to chord ratio
% assume wing weight is proportional to c^2*t2c
w_wing = t2c.*c.^2*W_wing/trapz(y,t2c.*c.^2); % assuming quadratic

% similarly for fuel and fuel tank
W_fuel = -3672*9.81/2; % weight of fuel and tank
t2ct = [t2c(1:N*0.9) zeros(1,N*0.1)];
w_fuel = t2ct.*c.^2*W_fuel/trapz(y,t2ct.*c.^2);
% worst case is zero fuel
% w_fuel = 0;

% consider main landing gear as a point load
W_mlg = -280.7*9.81/2 ; % weight of main landin gear
y_mlg = zeros(1,N);
y_mlg(floor(N*2.8/bf):floor(N*3.2/bf)) = 1;% y position of mail landing gear
w_mlg = W_mlg*y_mlg/trapz(y,y_mlg);

ly = l_wing+w_wing+w_mlg;% distributed load dF/dy
lyn = l_wingn+w_wing+w_fuel+w_mlg;
SF = zeros(1,N);SFn = SF;% initialise
BM = SF; BMn = BM;
T = SF;Tn = T;
%Shear force
for i = 1:N
    SF(N-i+1) = dx*sum(ly(N-i+1:N)); % sum from tip to root
    SFn(N-i+1) = dx*sum(lyn(N-i+1:N)); % sum from tip to root
end
%Bending moment
dBM = ly*dx;    % differential bending moment
dBMn = lyn*dx; 
for i = 1:N
    BM(N-i+1) = sum(dBM(N-i+1:N).*(x(N-i+1:N)-x(N-i+1)));  % sum from tip to root
    BMn(N-i+1) = sum(dBMn(N-i+1:N).*(x(N-i+1:N)-x(N-i+1)));
end

%Torque
%from xfoil
cm0 = [ones(1,floor((0.3*11.52-1.5)/10.02*N))*-0.09 ones(1,N-floor((0.3*11.52-1.5)/10.02*N))*-0.07];
dM0 = 0.5*rho_cruise*(cos(theta)*V_max)^2*cs.^2.*cm0;%moment with respect to flexural axis. this could be better as this is more conservative and this is calculated with respect to the flexural axis.
%assume flexural axis at (.15+.65)/2=40% chord -- centre of wing box
x_flex = 0.4;
%moment arm of lift
al = (x_flex-0.25)*c;
dLa = al.*l_wing;
dLan = al.*l_wingn;
x_wing = 0.5;
%moment arm of inertial loads
bw = (x_flex-x_wing);
dnWbw = n*w_wing.*bw.*cs;
%sectional torque
dT = dM0+dLa+dnWbw;
dTn = dM0+dLan+dnWbw;
%total torque
for i = 1:N
    T(N-i+1) = sum(dT(N-i+1:N));  % sum from tip to root
    Tn(N-i+1) = sum(dTn(N-i+1:N));
end

save('loads.mat')
%% plots
    x0=400;
    y0=400;
    width=700;
    height=300;

figure (1)
plot(x,ly,'linewidth',2)
hold on
plot(x,lyn,'linewidth',2)
% title('Load Distribution','interpreter','latex')
xlabel('Distance along flexural axis, m','interpreter','latex')
ylabel('Load distribution, N/m','interpreter','latex')
xlim([-1,12])
% ylim([-3000 max(ly)*1.05])
grid on
        set(gcf,'position',[x0,y0,width,height])

figure(2)
plot(x,SF,'linewidth',2)
hold on
plot(x,SFn,'linewidth',2)
% title('Shear Forces','interpreter','latex')
xlabel('Distance along flexural axis, m','interpreter','latex')
ylabel('Local shear force, N','interpreter','latex')
xlim([-1,12])
grid on
        set(gcf,'position',[x0,y0,width,height])

figure(3)
plot(x,BM,'linewidth',2)
hold on
plot(x,BMn,'linewidth',2)
% title('Bending Moments','interpreter','latex')
xlabel('Distance along flexural axis, m','interpreter','latex')
ylabel('Local bending moment, Nm','interpreter','latex')
xlim([-1,12])
grid on
        set(gcf,'position',[x0,y0,width,height])

figure(4)
plot(x,T,'linewidth',2)
hold on
plot(x,Tn,'linewidth',2)
% title('Torque','interpreter','latex')
xlabel('Distance along flexural axis, m','interpreter','latex')
ylabel('Local twisting moment, Nm','interpreter','latex')
xlim([-1,12])
grid on
        set(gcf,'position',[x0,y0,width,height])

        
h1=figure(1);
set(h1,'PaperSize',[18 8]); %set the paper size to what you want  
print(h1,'loaddistribution','-deps')
h2=figure(2);
set(h2,'PaperSize',[18 8]); %set the paper size to what you want  
print(h2,'shearforce','-deps')
h3=figure(3);
set(h3,'PaperSize',[18 8]); %set the paper size to what you want  
print(h3,'bendingmoment','-deps')
h4=figure(4);
set(h4,'PaperSize',[18 8]); %set the paper size to what you want  
print(h4,'torque','-deps')