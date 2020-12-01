clear
clc

lambda = 1;
m = 3;
%differen intervals
dX = [1/10,1/20,1/50,1/100,1/200,1/1000];
%calculate Numnber of mesh points
N = 1./dX + 1;

%for each dx 
for i = 1:length(dX)
    mdx = [0:dX(i):1];
    b = transpose((dX(i).^2).*(m.^2*pi.^2 - lambda)*sin(m*pi*mdx(2:length(mdx)-1)));
    
    %initialize matrix A
    A = zeros(N(i)-2,N(i)-2);
    A(1:N(i)-2,1:N(i)-2) = -(2+lambda*dX(i)^2);
    A(1:N(i)-3,2:N(i)-2) = 1;
    A(1:N(i)-2,1:N(i)-3) = 1;
    
    %set the initial condition
    x(1:N(i)-2,1) = 0;
    r(1:N(i)-2,1) = b - A*x(1:N(i)-2,1);
    
    eps = 1;
    k = 1;%actually starts from 0
    
    while eps >= 10^-7
        alpha = transpose(r(:,k)) * r(:,k)/(transpose(r(:,k))*(A*r(:,k)));
        x(:,k+1) = x(:,k) + alpha*r(:,k);
        r(:,k+1) = r(:,k) - alpha*A*r(:,k);
        eps = sqrt(1/N(i)*sum(r(:,k).^2));
        k = k + 1;
    end
    
    x = transpose(x(:,k));
    xbar = sin(3*pi*mdx(2:length(mdx)-1));
    eMax(i) = max(abs(x-xbar));
    
    plot(mdx(2:length(mdx)-1),x)
    hold on
    
end
