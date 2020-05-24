%%solve the stability quintic equation
result = solveEqn(1,1.1,1.1025,1.0025,0,0);

function result = solveEqn(a,b,c,d,e,f)
    syms x y;
    result = solve(a*x^5+b*x^4+c*x^3+d*x^2+e*x==f,x);
end