%%solve the stability quintic equation
result = solveEqn(0,0,0,1.31,0.035,0.024,0);
disp(simplify(result));
fprintf("The result is %3.6f",result(1));
function result = solveEqn(a,b,c,d,e,f,g)
    syms x y;
    result = solve(a*x^5+b*x^4+c*x^3+d*x^2+e*x+f==g,x);
end