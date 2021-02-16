function [sigma_cri,sigma_mb,As_1]=stringer(n,t,t_s,h,E)


D=3; %fuselage diameter
L=0.5; %frame spacing 
ba=0.05; % stringer base length

As=t_s*(h+2*ba);
b=pi*D/n %stringer pitch
theta=linspace(0,2*pi,n);
y=D/2.*sin(theta);% stringer position in y direction 
Askin=t*b/6*(2+1); % skin boom area
I=sum((As+Askin)*y.^2); % second moment of aera
M=3.7074e6; %maximum bending moment
sigma_mb=M*(D/2)/I %maximum stress due to bending
T=(t+As/b); % effective thickness
N=sigma_mb*T;
N_l=N/L;

F=0.945; %Farrad efficiency factor
h_bs=0.8; %ratio of stringers depth to stringers pitch
t_ts=0.9; % ratio of skin thickness to stringers thickness

k_lateral=6; %b/ts>40
t=t_s*t_ts;
h_1=b*h_bs;
As_1=t_s*(2*ba+h_1);
sigma_cri=k_lateral*E*(t^2/b^2);
end
% [sigma_cri,sigma_mb,As_1]=stringer(65,0.0023,0.0027,0.116,73e9)
% the stress would not cause yielding in the structure 
% for cabin pressurisation, the skin thcikness in cockpit and aft body is
% t/t_cockpit=(2-v)/(1-v)