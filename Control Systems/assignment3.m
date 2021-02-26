%% Task 1: State-space model
clc
clear

syms sgma omega x1 x2 x3 x4 u1 u2

% 1.1 Provide the following expressions with symbolic variables
g=sgma^3*omega^2;
%differentiate and substitute with syms values
x1_dot=x2;
x2_dot=-g/(x1+sgma)^2+u1+(x1+sgma)*(x4/sgma+omega)^2;
x3_dot=x4;
x4_dot=sgma*((u2-2*x2*(x4/sgma+omega))/(x1+sgma));

% State space matrices in symbolic expressions
%use jacobian function to do jaocobian linearization
A_sym=jacobian([x1_dot,x2_dot,x3_dot,x4_dot],[x1,x2,x3,x4]);
B_sym=jacobian([x1_dot,x2_dot,x3_dot,x4_dot],[u1,u2]);


% 1.2 Let sgma and omega all equal to 1. Provide the numeric matrices of the state-space system, in double-precision floating-point format
%substitute the values
A=subs(A_sym,[sgma,omega,x1,x2,x3,x4,u1,u2],[1,1,0,0,0,0,0,0]);
B=subs(B_sym,[sgma,omega,x1,x2,x3,x4,u1,u2],[1,1,0,0,0,0,0,0]);
%observe the y matrix, use jacobian linearization to obtain matrix C and D;
C=[1,0,0,0;0,0,1,0];
D=zeros(2);

%matrix C and D can also be obtained from function jacobian and then
%substitution
csym = jacobian([x1,x3],[x1,x2,x3,x4]);
dsym = jacobian([x1,x3],[u1,u2]);
c1=subs(csym,[x1,x2,x3,x4,u1,u2],[0,0,0,0,0,0]);
d1=subs(dsym,[x1,x2,x3,x4,u1,u2],[0,0,0,0,0,0]);
%% Task 2: Reachability
% 2.1 
% n = 4;
%construct the reachability matrix
W_r = [B,A*B,A^2*B,A^3*B];
%check is rank == n
if rank(W_r) == 4
    Sys_reachable=1; % equal to 1 if system reachable, equal to 0 if not.
else
    Sys_reachable = 0;
end

% 2.2
%if u1 = 0, the dimension of Bmatrix would be 4x1
B1 = B(:,2);
%other procedure would be the same
W_r_1=[B1,A*B1,A^2*B1,A^3*B1]; %when u1=0
if rank(W_r_1) == 4
    Sys_reachable_1=1; % equal to 1 if system reachable, equal to 0 if not.
else
    Sys_reachable_1=0;
end

% 2.3
%if u2 = 0, the dimension of Bmatrix would be 4x1
B2 = B(:,1);
W_r_2=[B2,A*B2,A^2*B2,A^3*B2]; %when u2=0
if rank(W_r_2) == 4
    Sys_reachable_2=1; % equal to 1 if system reachable, equal to 0 if not.
else
    Sys_reachable_2=0;
end