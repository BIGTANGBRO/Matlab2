% structure coursework
clear
clc

%initial setup
F_dot_x0 = 0.4823*1000;
eta_dot_y0 = -0.00002;
F_dot_x90 = 0.0482*1000;
F_dot_x30 = 0.1093*1000;

eps_dot_x0 = 1e-4;
eps_dot_x30 = 1e-4;
eps_dot_x90 = 1e-4;

eps_max = 1e-3;
t = linspace(0,10,200);

width = 25e-3;
height = 1e-3;
cross_area = width*height;

% [0_8]
eps_x0 = eps_dot_x0.*t;
eps_y0 = eta_dot_y0.*t;
Fx0 = F_dot_x0.*t;

%[90_8]
eps_x90 = eps_dot_x90.*t;
eps_y90 = -eps_x0/10;
Fx90 = F_dot_x90.*t;

%[30_8]
eps_x30 = eps_dot_x30.*t;
Fx30 = F_dot_x30.*t;

% for 0 degree
c = cos(0);
s = sin(0);
Tsigma0 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
Teta0 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
sigmaXX0 = Fx0./cross_area;

%for 90 degree
c = cos(90/180*pi);
s = sin(90/180*pi);
Tsigma90 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
Teta90 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
sigmaXX90 = Fx90./cross_area;

% for 30 degree
c = cos(30/180*pi);
s = sin(30/180*pi);
Tsigma30 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
Teta30 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
sigmaXX30 = Fx30./cross_area;



%% solve the matrix
syms G12 gammaXY30 epsYY30;
v12 = -eps_y0(200)/eps_x0(200);

epsilonMatrix30 = [eps_x30(200),epsYY30,gammaXY30];
sigmaMatrix30 = [sigmaXX30(200),0,0];
E1 = sigmaXX0(200)/eps_x0(200);
E2 = sigmaXX90(200)/eps_x90(200);
E3 = sigmaXX30(200)/eps_x30(200);

v21 = v12*E2/E1;

Q = [E1/(1-v12*v21),v21*E1/(1-v12*v21),0;
     v12*E2/(1-v12*v21),E2/(1-v12*v21),0;
     0, 0, G12];
Qbar30 = Tsigma30^(-1)*Q*Teta30;

eqns = [Qbar30(1,1)*epsilonMatrix30(1)+Qbar30(1,2)*epsilonMatrix30(2)+Qbar30(1,3)*epsilonMatrix30(3)==sigmaMatrix30(1),
        Qbar30(2,1)*epsilonMatrix30(1)+Qbar30(2,2)*epsilonMatrix30(2)+Qbar30(2,3)*epsilonMatrix30(3)==sigmaMatrix30(2),
        Qbar30(3,1)*epsilonMatrix30(1)+Qbar30(3,2)*epsilonMatrix30(2)+Qbar30(3,3)*epsilonMatrix30(3)==sigmaMatrix30(3)];
vars = [G12,gammaXY30,epsYY30];
nums = solve(eqns,vars);
 
fprintf("The value of G12 is %3.5f \n",nums.G12);
fprintf("The value of gammaXY30 is %3.5f \n",nums.gammaXY30);
fprintf("The value of epsYY30 is %3.5f \n",nums.epsYY30);
vxy30 = -nums.epsYY30/eps_x30(200);
fprintf("The value of Vxy30 is %3.5f \n",vxy30);

Gxy = nums.G12;
gammaXY30 = nums.gammaXY30;
epsYY30 = nums.epsYY30;
Qbar0 = Tsigma0^(-1)*Q*Teta0;
Qbar90 = Tsigma90^(-1)*Q*Teta90;

c = cos(45/180*pi);
s = sin(45/180*pi);
Tsigma45 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
Teta45 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
c = cos(-45/180*pi);
s = sin(-45/180*pi);
TsigmaMinus45 = [c^2,s^2,2*c*s;s^2,c^2,-2*c*s;-c*s,c*s,(c^2-s^2)];
TetaMinus45 = [c^2,s^2,c*s;s^2,c^2,-c*s;-2*c*s,2*c*s,(c^2-s^2)];
Qbar45 = Tsigma45^(-1)*Q*Teta45;
QbarMinus45 = TsigmaMinus45^(-1)*Q*TetaMinus45;

A11 = (Qbar0(1,1)*0.125e-3+Qbar45(1,1)*0.125e-3+Qbar90(1,1)*0.125e-3+QbarMinus45(1,1)*0.125e-3)*2;
A11 = subs(A11,G12,Gxy);
A12 = (Qbar0(1,2)*0.125e-3+Qbar45(1,2)*0.125e-3+Qbar90(1,2)*0.125e-3+QbarMinus45(1,2)*0.125e-3)*2;
A12 = subs(A12,G12,Gxy);
A22 = (Qbar0(2,2)*0.125e-3+Qbar45(2,2)*0.125e-3+Qbar90(2,2)*0.125e-3+QbarMinus45(2,2)*0.125e-3)*2;
A22= subs(A22,G12,Gxy);
fprintf("The value of A11 is %3.5f \n",A11);
fprintf("The value of A12 is %3.5f \n",A12);
fprintf("The value of A22 is %3.5f \n",A22);

Eqi = 1/(1e-3)*(A11-A12^2/A22);
vqi = A12/A22;
fprintf("The value of Eqi is %3.5f \n",Eqi);
fprintf("The value of vqi is %3.5f \n",vqi);
E4 = Eqi;
%% plot section
figure(1)
plot(eps_x0,sigmaXX0);
hold on
plot(eps_x90,sigmaXX90);
hold on
plot(eps_x30,sigmaXX30);
hold on
plot(eps_x0,double(Eqi)*eps_x0);
xlim([0 1e-03]), ylim([0 1e-03*E1])
xlabel('Strain');
ylabel('Stress/Pa');
legend('[0_8]-193GPa','[90_8]-19.3GPa','[30_8]-43.7GPa','Quasi-isotropic-79.6GPa');
grid on


figure(2)
epsYY30 = linspace(0,epsYY30,200);
v1 = -eps_y0(200)/eps_x0(200);
v2 = -eps_y90(200)/eps_x90(200);
v3 = -epsYY30(200)/eps_x30(200);
v4 = vqi;
xlim([0 1e-03])
plot(eps_x0,-eps_y0);
hold on
plot(eps_x90,-eps_y90);
hold on
plot(eps_x30,-epsYY30);
hold on
plot(eps_x0,eps_x0*vqi);
xlabel('Strain X');
ylabel('- Strain Y');
legend('[0_8]-0.2','[90_8]-0.1','[30_8]-0.308','Quasi-isotropic-0.279');
grid on
fprintf("The value of v3 is %3.5f \n",v3);
fprintf("The value of v4 is %3.5f \n",v4);
