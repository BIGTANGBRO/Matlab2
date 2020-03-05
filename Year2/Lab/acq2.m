clear
clc

xnp1 = 4.59;
xnp2 = 4.02;
Cbar=1.53;
xcg=[3.3830,3.51,3.6370];
Kn1=(xnp1-xcg)./Cbar;
Kn2=(xnp2-xcg)./Cbar;
CL1=[0.1468,0.1647,0.2052];
CL2=[0.5126,0.6004,0.7111];
Cm0_clean = Kn1.*CL1;
Cm0_landing = Kn2.*CL2;
VbarH=(8.11/1.53-3.95/1.53)*4.55/17.48;
dEdCL1=[-0.2663,-0.2445,-0.2099];
dEdCL2=[-0.3077,-0.2335,-0.1886];
nhaE1=-Kn1./(dEdCL1.*VbarH);
nhaE2=-Kn2./(dEdCL2.*VbarH);