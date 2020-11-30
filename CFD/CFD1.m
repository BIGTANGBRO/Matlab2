clc
clear

%helnholtz equation
dt = 0.4;
u = zeros(1002);
alpha = 1;
beta = 2;

u(1) = alpha;%0
u(1002) = beta;%n+1

for i = 2:1001
    dudt(i-1) = (u(i+1)-u(i-1))/(2*dt);
    d2udt2(i-1) = (u(i+1)-2*u(i)+u(i-1))/(dt^2);
end

function rhs = solveElliptic(mA,mU)

end