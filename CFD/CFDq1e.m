clear
clc

%assume lambda=1,m=3;
lambda = 1;
m = 3;
%differen intervals
deltaX = 1/500;
%calculate Numnber of mesh points
N = 1./deltaX + 1;
mdx = [0:deltaX:1];

%calculate B matrix
b = transpose(deltaX^2.*(-1-m^2*pi*2)*sin(3*pi*mdx(2:N-1)));

%calculate A matrix
A = zeros(N-2,N-2);
for i = 1:N-2
    A(i,i) = (-2-lambda*deltaX^2);
end
for i = 2:N-2
    A(i,i-1) = 1;
    A(i-1,i) = 1;
end

u = zeros(N-2,1);
eps = 3;
n=1;
while eps >= 10^(-7)
    r(:,n) = b - A*u(:,n);
    alpha = (transpose(r(:,n))*r(:,n))/(transpose(r(:,n))*A*r(:,n));
    u(:,n+1) = u(:,n) + alpha * r(:,n);
    eps = sqrt((1/N)*sum(r(:,n).^2));
    n = n + 1;
end

ubar = transpose(sin(3*pi*mdx));
ufinal = [0;u(:,length(u(1,:)));0];
epsilon = max(abs(ufinal-ubar));
fprintf('The maximum epsilon of iteration is %3.5f',epsilon);

plot(mdx,ufinal,'--r');
%predicted values;
hold on 
plot(mdx,sin(3.*pi.*mdx),'-g');
grid on
legend('Predicted','Actual');
hold off
