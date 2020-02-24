function loopTocTime=timetestloop(n)
incr=1/n;
x=0:incr:1;
tic
for k=1:n
    y(k)=(1-(3/5)*x(k)+(3/20)*(x(k)^2)-(1/60)*(x(k)^3))/(1+(2/5)*x(k)+(1/20)*(x(k)^2));
end
loopTocTime=toc;
end

