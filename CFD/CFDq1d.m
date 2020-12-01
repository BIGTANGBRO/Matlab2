clc
clear

deltaX = 1/10;
mdx = 0:deltaX:1;
%number of points
N = 1./deltaX + 1;

aCoeff = 1;
bCoeff = -(2+deltaX.^2);
cCoeff = 1;
a = zeros(N-2,1);
c = zeros(N-2,1);
a(2:N-2) = aCoeff;
c(1:N-3) = cCoeff;
b = ones(N-2,1)*bCoeff;

fMatrix = deltaX.^2*(-9*pi^2-1).*sin(3.*pi.*mdx(2:N-1));

beta = zeros(N-2,1);
gamma = zeros(N-2,1);

beta(1) = b(1);
gamma(1) = fMatrix(1)./beta(1);
for k = 2:N-2
    beta(k) = b(k)-a(k)*c(k-1)/beta(k-1);
    gamma(k) = (-a(k)*gamma(k-1)+fMatrix(k))/beta(k);
end

u = zeros(N,1);
u(N-2) = gamma(N-2);
for k = (N-3):-1:1
    u(k) = gamma(k) - u(k+1)*c(k)/beta(k);
end
    
ubar = transpose(sin(3*pi*mdx));
eps = max(u-ubar);
disp(eps);


