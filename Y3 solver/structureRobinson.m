%structure to solve the equation
clear
clc

syms q1 q2;
[ans1,ans2] = solve(166.67*q2-50*q1 == 146.67*q1-50*q2,q1+q2 == 2/3);
fprintf("The value of q1 is %6.6f\n",ans1);
fprintf("The value of q2 is %6.6f\n",ans2);
