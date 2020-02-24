function arrayTocTime=timeTestArray(n)
incr=1/n;
x=0:incr:1;
y=zeros(1,length(x));
tic
y=(1-(3/5)*x+(3/20)*(x.^2)-(1/60)*(x.^3))/(1+(2/5)*x+(1/20)*(x.^2));
arrayTocTime=toc;
end
