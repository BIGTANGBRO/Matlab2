clear
clc

deltaXMatrix = [1/10,1/20,1/50,1/100,1/200,1/500];
for x = 1:length(deltaXMatrix)
%assume lambda=1,m=3;
lambda = 1;
m = 3;
%differen intervals
deltaX = deltaXMatrix(x);

clear var b eps u r alpha
%calculate Numnber of mesh points
N = 1./deltaX + 1;
mdx = [0:deltaX:1];

%calculate B matrix
b = transpose(deltaX^2.*(-1-m^2*pi^2)*sin(3*pi*mdx(2:N-1)));

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
eps = 1;
n=0;
while eps >= 10^(-7)
    n = n + 1;
    r(:,n) = b - A*u(:,n);
    alpha = (transpose(r(:,n))*r(:,n))/(transpose(r(:,n))*A*r(:,n));
    eps = sqrt((1/N)*sum(r(:,n).^2));
    u(:,n+1) = u(:,n) + alpha * r(:,n);
end

ubar = transpose(sin(3*pi*mdx));
ufinal = [0;u(:,length(u(1,:)));0];
epsilon = max(abs(ufinal-ubar));
fprintf('The maximum epsilon of iteration is %3.5f\n',epsilon);

figure()
plot(mdx,ufinal,'--r');
%predicted values;
hold on 
plot(mdx,sin(3.*pi.*mdx),'-g');
grid on
legend('Predicted','Actual');
hold off
end
