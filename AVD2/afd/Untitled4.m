clear
clc


t=0.005; %initial guess
D=3; %fuselage diameter
L=0.5; %frame spacing 
n=50; % number of stringers
As=5e-4;

b=pi*D/n; %stringer pitch
theta=linspace(0,2*pi,n);
y=D/2.*sin(theta);% stringer position in y direction 
x=D/2.*cos(theta); % stringer position in x direction
figure (1);
plot(x,y,'o');
grid on

%%
Askin=t*b/6*(2+1); % skin boom area
I=sum((As+Askin)*y.^2); % second moment of aera
M=3.7074e6; %maximum bending moment
sigma_mb=M*(D/2)/I; %maximum stress due to bending 

%%
F=231077; % maximum shear force
qs=F/2/pi/D; %shear flow q=F/(2*pi*D)
sigma_ms=qs/t;

%% compare (Bending stress with euler buckling and yield) (Shear stress with plate buckling and yield)
