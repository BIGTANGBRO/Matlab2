clear
clc

% predefine parameters
Nx = 51;
Ny = 101;
a = 0.75;
b = 0.06;
eps = 50;
mu1 = 5.0;
mu2 = 0.0;
h = 1.0; % dx = dy = 1
T = 100;
dt = 0.001;

% assign initial condition
u = zeros(Ny,Nx);
v = zeros(Ny,Nx);

for i = 1 : Ny
    for j = 1 : Nx
        if j > ceil(Nx/2)
            u(i,j) = 1.0;
        end
    end
end

for i = 1 : Ny
    for j = 1 : Nx
        if i < ceil(Ny/2)
            v(i,j) = a/2.0;
        end
    end
end

%Matrix initialization
A1 = zeros(Ny,Ny);
A2 = zeros(Ny,Ny);

B1 = zeros(Nx,Nx);
B2 = zeros(Nx,Nx);
for i = 2 : Ny-1	
    j = i-1;
		A1(i,(0+j)) = 1.0 * mu1/(h^2);
		A1(i,(1+j)) = -2.0 * mu1/(h^2);
		A1(i,(2+j)) = 1.0 * mu1/(h^2);

        A2(i,(0+j)) = 1.0 * mu2/(h^2);
		A2(i,(1+j)) = -2.0 * mu2/(h^2);
		A2(i,(2+j)) = 1.0 * mu2/(h^2);
end

for i = 2 : Nx-1	
    j = i-1;
        B1(i,(0+j)) = 1.0 * mu1/(h^2);
		B1(i,(1+j)) = -2.0 * mu1/(h^2);
		B1(i,(2+j)) = 1.0 * mu1/(h^2);

        B2(i,(0+j)) = 1.0 * mu2/(h^2);
		B2(i,(1+j)) = -2.0 * mu2/(h^2);
		B2(i,(2+j)) = 1.0 * mu2/(h^2);
end

A1(1, 1) = -1.0 * mu1/(h^2);
A1(1, 2) = 1.0 * mu1/(h^2);
A1(Ny, Ny - 1) = 1.0 * mu1/(h^2);
A1(Ny, Ny) = -1.0 * mu1/(h^2);

A2(1, 1) = -1.0 * mu2/(h^2);
A2(1, 2) = 1.0 * mu2/(h^2);
A2(Ny, Ny - 1) = 1.0 * mu2/(h^2);
A2(Ny, Ny) = -1.0 * mu2/(h^2);

B1(1, 1) = -1.0 * mu1/(h^2);
B1(1, 2) = 1.0 * mu1/(h^2);
B1(Nx, Nx - 1) = 1.0 * mu1/(h^2);
B1(Nx, Nx) = -1.0 * mu1/(h^2);

B2(1, 1) = -1.0 * mu2/(h^2);
B2(1, 2) = 1.0 * mu2/(h^2);
B2(Nx, Nx - 1) = 1.0 * mu2/(h^2);
B2(Nx, Nx) = -1.0 * mu2/(h^2);


%iteration
for i = 1:T/dt
    tempU1 = zeros(Ny, Nx);
    tempU2 = zeros(Ny, Nx);
    tempV1 = zeros(Ny, Nx);
    tempV2 = zeros(Ny, Nx);

    tempU1 = A1*u;
    tempV1 = A2*v;

    tempU2 = (u*B1);
    tempV2 = (v*B2); 

    f1 = eps.*u.*(1-u).*(u - (v+b)./a);
    f2 = u.^3 - v;

    u = u + tempU1.*dt + tempU2.*dt + dt.*f1;
    v = v + tempV1.*dt + tempV2.*dt + dt.*f2;
end

x = linspace(0,Nx-1,Nx);
y = linspace(0,Ny-1,Ny);

figure
pcolor(x,y,u);
colorbar

