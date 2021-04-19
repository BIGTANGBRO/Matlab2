%the script to solve the collocation method
clear
clc
clear

%first get the expression for alpha = alphaZero(1-xx|y/s|)
%substitute with the theta
%the input parameters
AR = 12;

theta1 = pi/5;
theta2 = 2*pi/5;
%should be cbar = xxx*C0, but eliminate during the equation
cbar =2/3;

%angle of attack
alpha1=5*(1-1*cos(theta1)^2);
alpha2=5*(1-1*cos(theta2)^2);

%miu calculation involves the use of chord distribution
chord1 = (1-2/3*cos(theta1));
chord2 = (1-2/3*cos(theta2));

%lift curve slope
a0 = 6;

%% calculation part
miu1 = a0*chord1/(AR*4*cbar);
miu2 = a0*chord2/(AR*4*cbar);
alpha1Rad = deg2rad(alpha1);
alpha2Rad = deg2rad(alpha2);

a=sin(theta1)*(miu1+sin(theta1));
b=sin(3*theta1)*(3*miu1+sin(theta1));
c=sin(theta2)*(miu2+sin(theta2));
d=sin(3*theta2)*(3*miu2+sin(theta2));

B1 = miu1*alpha1Rad*sin(theta1);
B2 = miu2*alpha2Rad*sin(theta2);

%% solve the equation
matrixA = [a,b;c,d];
B = [B1;B2];
finalAns = matrixA\B;

syms A1 A3;
[ans1,ans2] = solve(B1 == A1*a+A3*b,B2 == A1*c+A3*d);

%% answer format
fprintf("The value of A1 is %6.6f\n",ans1);
fprintf("The value of A3 is %6.6f\n",ans2);

CL = pi*AR*ans1;
CDi = pi*AR*(ans1^2+3*ans2^2);
fprintf("The value of CL is %6.6f\n",CL);
fprintf("The value of CDi is %6.6f\n",CDi);

fprintf("The value of CL/CDi is %6.6f\n",CL/CDi);