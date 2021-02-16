clear
clc
close all


% check compression and shear to meet the failure critiria
n=65;
t=0.0023;
t_s=0.0027;
h=0.116;
E=73e9;
L=0.5;
[sigma_cri,sigma_mb,As_1]=stringer(n,t,t_s,h,E);

sf=2.3108e+05; %maximun shear flow
D=3; % Fuselage diameter
qs=sf/(2*pi*D); % shear flow
sigma_ms=qs/t;
b=pi*D/n;
y=KS(b,L);
sigma_scri=y*E*(t/b)^2;

R_c=sigma_mb/sigma_cri;
R_s=sigma_ms/sigma_scri;
check_1=R_c+R_s^2;

% check the stringers
a=0.05; %z section base length
I=(a*h^3-(a-t_s)*(h-2*t_s)^3)/12;
rho=sqrt(I/As_1);
sigma_eu=pi*2*E*(rho/L)^2;
check_2=sigma_cri/sigma_eu;


