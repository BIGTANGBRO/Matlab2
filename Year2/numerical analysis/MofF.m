%%solve the stability quintic equation
clear
clc

result = solveEqn(0,1,1.804,1.31,0.035,0.024,0);

fprintf("The real part of the result is %3.6f \n",result(4));
fprintf("The imaginary part of the result is %3.6fi",imag(result(4)));
function result = solveEqn(a,b,c,d,e,f,g)
    syms x y;
    result = solve(a*x^5+b*x^4+c*x^3+d*x^2+e*x+f==g,x);
end