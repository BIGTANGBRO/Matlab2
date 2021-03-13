% structure coursework
clear
clc

%initial setup
F_dot_x0 = 0.4823*1000;
eta_dot_y0 = -0.00002;
F_dot_x90 = 0.0482*1000;
F_dot_x30 = 0.1093*1000;

eta_dot_x0 = 1e-4;
eta_dot_x30 = 1e-4;
eta_dot_x90 = 1e-4;

eta_max = 1e-3;
t = linspace(0,10,200);

width = 25e-3;
height = 1e-3;
cross_area = width*height;

% [0_8]
eta_x0 = eta_dot_x0.*t;
eta_y0 = eta_dot_y0.*t;
Fx0 = F_dot_x0.*t;

%[90_8]
eta_x90 = eta_dot_x90.*t;
Fx90 = F_dot_x90.*t;

%[30_8]
eta_x30 = eta_dot_x30.*t;
Fx30 = F_dot_x30.*t;

% for 0 degree
c = cos(0);
s = sin(0);
Tsigma0 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
Teta0 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
sigmaXX0 = Fx0./cross_area;

%for 90 degree
c = cos(90);
s = sin(90);
Tsigma90 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
Teta90 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
sigmaXX90 = Fx90./cross_area;

% for 30 degree
c = cos(30);
s = sin(30);
Tsigma30 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
Teta30 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
sigmaXX30 = Fx30./cross_area;

figure(1)
plot(eta_x0,sigmaXX0);
hold on
plot(eta_x90,sigmaXX90);
hold on
plot(eta_x30,sigmaXX30);

figure(2);
plot(eta_x0,-eta_y0);

%% solve the matrix
syms G12 gammaXY30 epsYY30;
v12 = -eta_y0(200)/eta_x0(200);

epsilonMatrix30 = [eta_x30(200),epsYY30,gammaXY30];
sigmaMatrix30 = [sigmaXX30(200),0,0];
E1 = sigmaXX0(200)/eta_x0(200);
E2 = sigmaXX90(200)/eta_x90(200);
v21 = v12*E2/E1;

Q = [E1/(1-v12*v21),v21*E1/(1-v12*v21),0;
     v12*E2/(1-v12*v21),E2/(1-v12*v21),0;
     0, 0, G12];
 Qbar = Tsigma30^(-1)*Q*Teta30;
 
 eqns = [Qbar(1,1)*epsilonMatrix30(1)+Qbar(1,2)*epsilonMatrix30(2)+Qbar(1,3)*epsilonMatrix30(3)==sigmaMatrix30(1),Qbar(2,1)*epsilonMatrix30(1)+Qbar(2,2)*epsilonMatrix30(2)+Qbar(2,3)*epsilonMatrix30(3)==sigmaMatrix30(2),Qbar(3,1)*epsilonMatrix30(1)+Qbar(3,2)*epsilonMatrix30(2)+Qbar(3,3)*epsilonMatrix30(3)==sigmaMatrix30(3)];
 vars = [G12,gammaXY30,epsYY30];
 nums = solve(eqns,vars);
 fprintf("The value of G12 is %3.5f \n",nums.G12);
 fprintf("The value of gammaXY30 is %3.5f \n",nums.gammaXY30);
 fprintf("The value of epsYY30 is %3.5f \n",nums.epsYY30);
 
 
 
 
 