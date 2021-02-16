function [N_L]=thickness(n,As)
%% 
t=0.005; %initial guess
D=3; %fuselage diameter
L=0.5; %frame spacing 

b=pi*D/n; %stringer pitch
theta=linspace(0,2*pi,n);
y=D/2.*sin(theta); % stringer position in y direction 
I=pi/2*((D/2)^4-(D/2-t)^4)+sum(As*y.^2); % second moment of aera
M=3.7074e6; %maximum bending moment
sigma_mb=M*(D/2)/I; %maximum stress due to bending 
T=(t+As/b); % effective thickness
N=sigma_mb*T; % compressive load carried per unit width

N_L=N/L;
end