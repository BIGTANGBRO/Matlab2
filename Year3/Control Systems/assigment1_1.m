%assignment1
[ A,B,C,D ] = Ex1_P1( 0,0,0,0,0,0,0,0 )


function [ A,B,C,D ] = Ex1_P1( x1_0,x2_0,x3_0,x4_0,x5_0,x6_0,u1_0,u2_0 )
% AE3-302 Control Systems 
% Exercise 1: Jacobian Linearization
% Problem 1: Linearization via symbolic differentiation
% Function inputs: 
%   x1_0,x2_0,x3_0,x4_0,x5_0,x6_0,u1_0,u2_0 - the operating point at which the linear model is extracted
% Function outputs:
%   A,B,C,D - state-space model of the system

% Symbolic operations
% the states x=(x1,x2,x3,x4,x5,x6)=(epsilon,rho,lambda,epsilon_dot,rho_dot,lambda_dot)
syms epsilon rho lambda epsilon_dot rho_dot lambda_dot u1 u2

% Propeller force-thrust constant found experimentally (N/V)
Kf = 0.1188;
% Mass of the helicopter body (kg)
mh = 1.308;
% Mass of counter-weight (kg)
mw = 1.924;
% Mass of front propeller assembly = motor + shield + propeller + body (kg)
mf = mh / 2;
% Mass of back propeller assembly = motor + shield + propeller + body (kg)
mb = mh / 2;
% Distance between pitch pivot and each motor (m)
Lh = 7.0 * 0.0254;
% Distance between elevation pivot to helicopter body (m)
La = 26.0 * 0.0254;
% Distance between elevation pivot to counter-weight (m)
Lw = 18.5 * 0.0254;
% Gravitational Constant (m/s^2)
g = 9.81;    
    
% Nonlinear Dynamics Eqns
f1=epsilon_dot;
f2=rho_dot;
f3=lambda_dot;
f4 = -cos(rho) ^ 2 * Lh * (mf - mb) * La * sin(rho) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * epsilon_dot ^ 2 + (-0.2e1 * Lh * cos(rho) * (cos(epsilon) * La * (mf - mb) * cos(rho) ^ 2 - cos(epsilon) * La * (mf - mb) + sin(rho) * sin(epsilon) * Lh * (mf + mb)) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * lambda_dot - 0.2e1 * (mf + mb) * cos(rho) * Lh ^ 2 * sin(rho) * rho_dot / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw)) * epsilon_dot + ((sin(rho) * La * (mf - mb) * cos(epsilon) - 0.2e1 * sin(epsilon) * Lh * (mf + mb)) * Lh * cos(epsilon) * cos(rho) ^ 2 - 0.2e1 * sin(rho) * La * Lh * (mf - mb) * cos(epsilon) ^ 2 - sin(epsilon) * ((mf + mb) * La ^ 2 - Lh ^ 2 * mb - Lh ^ 2 * mf + Lw ^ 2 * mw) * cos(epsilon) + sin(rho) * La * Lh * (mf - mb)) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * lambda_dot ^ 2 - 0.2e1 * Lh * (cos(epsilon) * Lh * (mf + mb) * cos(rho) ^ 2 - cos(epsilon) * Lh * (mf + mb) - sin(rho) * sin(epsilon) * La * (mf - mb)) * rho_dot / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * lambda_dot + Lh * (mf - mb) * La * sin(rho) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * rho_dot ^ 2 + (((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * ((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2) * cos(rho) ^ 3 + (g * (mw * Lw * (mf - mb) ^ 2 * La ^ 2 + ((-0.4e1 * Lh ^ 2 * mf + Lw ^ 2 * mw) * mb ^ 2 + (-0.4e1 * Lh ^ 2 * mf ^ 2 - 0.2e1 * Lw ^ 2 * mw * mf) * mb + mf ^ 2 * mw * Lw ^ 2) * La + mw * Lh ^ 2 * Lw * (mf + mb) ^ 2) * cos(epsilon) + ((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * ((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2)) * cos(epsilon) * cos(rho) ^ 2 + (Kf * (-u1 + u2) * (mf - mb) * ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * La * cos(epsilon) - (sin(epsilon) * Kf * Lh * (-u1 + u2) * sin(rho) + (g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * ((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2)) * cos(rho) + (0.4e1 * La ^ 2 * mb * mf + mw * Lw ^ 2 * (mf + mb)) * cos(epsilon) * (-g * ((mf + mb) * La - Lw * mw) * cos(epsilon) + g * sin(epsilon) * Lh * (mf - mb) * sin(rho) + (g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g)) / (0.4e1 * La ^ 2 * mb * mf + mw * Lw ^ 2 * (mf + mb)) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) / cos(epsilon);
f5 = cos(rho) * (((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * sin(rho) * cos(epsilon) + cos(rho) ^ 2 * sin(epsilon) * La * Lh * (mf - mb)) / cos(epsilon) / ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * epsilon_dot ^ 2 + (-0.2e1 * (-cos(rho) ^ 2 * ((mf + mb) * La ^ 2 + Lw ^ 2 * mw) * cos(epsilon) ^ 2 + cos(rho) ^ 2 * sin(rho) * sin(epsilon) * La * Lh * (mf - mb) * cos(epsilon) - Lh ^ 2 * (mf + mb) * cos(rho) ^ 2 + (mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) / cos(epsilon) / ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * lambda_dot + 0.2e1 * (mf + mb) * cos(rho) ^ 2 * Lh ^ 2 * sin(epsilon) * rho_dot / cos(epsilon) / ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw)) * epsilon_dot - cos(rho) * (((-mb - mf) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * sin(rho) * cos(epsilon) ^ 3 + sin(epsilon) * La * Lh * (cos(rho) ^ 2 - 0.2e1) * (mf - mb) * cos(epsilon) ^ 2 + 0.2e1 * sin(rho) * Lh ^ 2 * (mf + mb) * cos(epsilon) + sin(epsilon) * La * Lh * (mf - mb)) / cos(epsilon) / ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * lambda_dot ^ 2 - 0.2e1 * Lh * cos(rho) * (-La * (mf - mb) * cos(epsilon) ^ 2 + sin(rho) * sin(epsilon) * Lh * (mf + mb) * cos(epsilon) + La * (mf - mb)) * rho_dot / cos(epsilon) / ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * lambda_dot - cos(rho) * Lh * sin(epsilon) * (mf - mb) * La / cos(epsilon) / ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * rho_dot ^ 2 + (-g * cos(rho) * (mf - mb) * ((-0.4e1 * La * mb * mf + mw * Lw * (mf + mb)) * La * Lh ^ 2 + Lw * ((mf + mb) * La ^ 2 + Lw ^ 2 * mw) * (La + Lw) * mw) * cos(epsilon) ^ 3 + (-Lh ^ 2 * Kf * (-u1 + u2) * ((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2) * cos(rho) ^ 2 + (g * Lh * sin(epsilon) * ((mf + mb) * (-0.4e1 * La * mb * mf + mw * Lw * (mf + mb)) * Lh ^ 2 + Lw * La * mw * (mf - mb) ^ 2 * (La + Lw)) * sin(rho) - ((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * (mf - mb) * ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * La) * cos(rho) - Kf * (-u1 + u2) * ((-mb - mf) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw)) * cos(epsilon) ^ 2 + (-((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * (mf - mb) * ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * La * cos(rho) ^ 2 + Lh * (((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * sin(epsilon) * ((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2) * sin(rho) - g * Lh * (0.4e1 * La ^ 2 * mb * mf + mw * Lw ^ 2 * (mf + mb)) * (mf - mb)) * cos(rho) + (0.2e1 * sin(epsilon) * Kf * Lh * (-u1 + u2) * sin(rho) + (g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * (mf - mb) * ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) * La) * cos(epsilon) + Lh * (((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * sin(epsilon) * sin(rho) + Kf * Lh * (-u1 + u2)) * (((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2) * cos(rho) ^ 2 - (mf + mb) * ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw))) / Lh / (0.4e1 * La ^ 2 * mb * mf + mw * Lw ^ 2 * (mf + mb)) / ((mf + mb) * Lh ^ 2 + (mf + mb) * La ^ 2 + Lw ^ 2 * mw) / cos(epsilon) ^ 2;
f6 = -cos(rho) ^ 3 * Lh * (mf - mb) * La / cos(epsilon) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * epsilon_dot ^ 2 + (0.2e1 * (Lh * (sin(rho) * La * (mf - mb) * cos(epsilon) - sin(epsilon) * Lh * (mf + mb)) * cos(rho) ^ 2 + sin(epsilon) * ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw)) / cos(epsilon) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * lambda_dot - 0.2e1 * (mf + mb) * cos(rho) ^ 2 * Lh ^ 2 * rho_dot / cos(epsilon) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw)) * epsilon_dot + cos(rho) * Lh * (La * (mf - mb) * cos(epsilon) ^ 2 * cos(rho) ^ 2 + 0.2e1 * sin(rho) * sin(epsilon) * Lh * (mf + mb) * cos(epsilon) - 0.2e1 * (mf - mb) * (cos(epsilon) ^ 2 - 0.1e1 / 0.2e1) * La) / cos(epsilon) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * lambda_dot ^ 2 + 0.2e1 * (cos(epsilon) * Lh * (mf + mb) * sin(rho) + sin(epsilon) * La * (mf - mb)) * cos(rho) * Lh * rho_dot / cos(epsilon) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * lambda_dot + cos(rho) * Lh * (mf - mb) * La / cos(epsilon) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) * rho_dot ^ 2 + (-(((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * sin(rho) + sin(epsilon) * Kf * Lh * (-u1 + u2)) * ((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2) * cos(rho) ^ 2 - ((g * (mw * Lw * (mf - mb) ^ 2 * La ^ 2 + ((-0.4e1 * Lh ^ 2 * mf + Lw ^ 2 * mw) * mb ^ 2 + (-0.4e1 * Lh ^ 2 * mf ^ 2 - 0.2e1 * Lw ^ 2 * mw * mf) * mb + mf ^ 2 * mw * Lw ^ 2) * La + mw * Lh ^ 2 * Lw * (mf + mb) ^ 2) * cos(epsilon) + ((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g) * ((mf - mb) ^ 2 * La ^ 2 + Lh ^ 2 * (mf + mb) ^ 2)) * sin(rho) - g * Lh * sin(epsilon) * (0.4e1 * La ^ 2 * mb * mf + mw * Lw ^ 2 * (mf + mb)) * (mf - mb)) * cos(epsilon) * cos(rho) + ((-Kf * La * (-u1 + u2) * (mf - mb) * cos(epsilon) + (mf + mb) * ((g * mb + g * mf + Kf * (u1 + u2)) * La - Lw * mw * g)) * sin(rho) + sin(epsilon) * Kf * Lh * (-u1 + u2) * (mf + mb)) * ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw)) / (0.4e1 * La ^ 2 * mb * mf + mw * Lw ^ 2 * (mf + mb)) / ((mf + mb) * La ^ 2 + Lh ^ 2 * mb + Lh ^ 2 * mf + Lw ^ 2 * mw) / cos(epsilon) ^ 2;

% Fix the code below and add any code if necessary
%A_sym(epsilon,rho,lambda,epsilon_dot,rho_dot,lambda_dot,u1,u2)=1;
%B_sym(epsilon,rho,lambda,epsilon_dot,rho_dot,lambda_dot,u1,u2)=1;
%Jacobian linearization for matrix A;
A = [diff([f1;f2;f3;f4;f5;f6],epsilon),diff([f1;f2;f3;f4;f5;f6],rho),diff([f1;f2;f3;f4;f5;f6],lambda),diff([f1;f2;f3;f4;f5;f6],epsilon_dot),diff([f1;f2;f3;f4;f5;f6],rho_dot),diff([f1;f2;f3;f4;f5;f6],lambda_dot)];
%Jacobian linearization for matrix, differentiate with u1 and u2;
B = [diff([f1;f2;f3;f4;f5;f6],u1),diff([f1;f2;f3;f4;f5;f6],u2)];
%substitutu the value into matrix A and B
A = subs(A,[epsilon,rho,lambda,epsilon_dot,rho_dot,lambda_dot,u1,u2],[x1_0,x2_0,x3_0,x4_0,x5_0,x6_0,u1_0,u2_0]);
B = subs(B,[epsilon,rho,lambda,epsilon_dot,rho_dot,lambda_dot,u1,u2],[x1_0,x2_0,x3_0,x4_0,x5_0,x6_0,u1_0,u2_0]);
%make sure the matrix in double format
A = double(A);
B = double(B);
%get from prelabtask.pdf, y has the same dimension as x_dot, C = 1, D = 0;
C=eye(6,6);
D=zeros(6,2);

end
