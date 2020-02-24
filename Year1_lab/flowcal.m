function Re =flowcal(v,a,T)
c=343;
m=v*0.447/atmosisa(a);
u=muCalc(T);
Re=1.12*v*0.447*6.4/u;
disp(u)
disp(Re)
disp(m)
end
