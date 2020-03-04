clear
clc

xnp1 = 4.59;
xnp2 = 4.02;
Cbar=1.53;
xcg=[3.3830,3.51,3.6370];
Kn1=(xnp1-xcg)./Cbar;
Kn2=(xnp2-xcg)./Cbar;
CL1=[0.1481,0.1655,0.2052];
CL2=[0.5144,0.6004,0.7129];
Cm0_clean = Kn1.*CL1;
Cm0_landing = Kn2.*CL2;
VbarH=(8.11/1.03-3.95/1.53)*4.55/17.48;
dCLdE2=[-0.0567,-0.0747,-0.0925];
dCLdE1=[-0.0655,-0.0714,-0.0831];
nhaE1=-Kn1.*VbarH.*dCLdE1;
nhaE2=-Kn2.*VbarH.*dCLdE2;