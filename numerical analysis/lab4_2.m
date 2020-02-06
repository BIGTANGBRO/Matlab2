clear
clc

n=5;
N=n-1;
i=0:1:N;%equally space points

xj = chebyshev(N,i);
x=-1:2/N:1;
l=ones(n);
x=1;
disp(xj);
for i = 1:n
    for j = 1:n
        if i~=j
            l(i) = l(i)*(x-xj(j))/(xj(i)-xj(j));
        else
            l(i) = l(i)*1;
        end
    end
 
end

function xj = chebyshev(N,i)
xj=-cos(((2.*i+1)./(2.*N+2)).*pi);
end

function y = fx(x)
y=1/(25+x^2);
end