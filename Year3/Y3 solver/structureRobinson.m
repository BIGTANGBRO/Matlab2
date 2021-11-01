%structure to solve the equation
clear all
clc

%find the total shear flow
syms q1 q2;
% [ans1,ans2] = solve(sqrt(3)/12*(12/sqrt(3)*q2-12/sqrt(3)*q1) == (sqrt(3)/6)*(6/sqrt(3)*q1-2/sqrt(3)*q2),36/sqrt(3)*q1+12/sqrt(3)*q2== 1);
% fprintf("The value of q1 is %6.6f\n",ans1);
% fprintf("The value of q2 is %6.6f\n",ans2);

%find the shear center
[ans1,ans2] = solve(950*q1-150*q2+(6.7e7)/(1.12e8) == 0,525*q2-75*q1+(2.85e7)/(1.12e8) ==0);
fprintf("The value of q1 is %6.7f\n",ans1);
fprintf("The value of q2 is %6.7f\n",ans2);

% syms q3;
% 
% [ans1,ans2,ans3] = solve(sqrt(3)/6*(10/sqrt(3)*q1-2/sqrt(3)*q2) == 1,(sqrt(3)/6)*(10/sqrt(3)*q2-2/sqrt(3)*q1-2/sqrt(3)*q3) ==1,sqrt(3)/6*(10/sqrt(3)*q3-4/sqrt(3)*q2) == 1);
% fprintf("The value of q1 is %6.6f\n",ans1);
% fprintf("The value of q2 is %6.6f\n",ans2);
% fprintf("The value of q3 is %6.6f\n",ans3);