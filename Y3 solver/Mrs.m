%reflected shock
clear
clc

Ms = 1.5;
eqn = Ms/(Ms^2-1)*sqrt(1+0.8/2.4^2*(Ms^2-1)*(1.4+1/Ms^2));
syms mrs
mReflected = solve(mrs==eqn*mrs^2-eqn);
fprintf("The value of Mrs is %6.6f\n",mReflected);