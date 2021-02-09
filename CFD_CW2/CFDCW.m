clear
clc

%Numerical solution of the Riemann shock tube problem using Flux 
%Vector Splitting method

%Input flow variables
gamma=1.4;

%Meshes number 100/200/300
%N=[100 200 300];
N=100;
dx=(2--2)./(N-1); %Calculating different values of delta x
x=linspace(-2,2,N(1)); %Equally spaced point in the interval -2<x<2
dt=0.005; %Time interval
t=0:dt:0.5;

%Initial conditions
pr=10; %Pressure ratio p2/p1
dr=8; %Density ratio
%Driven part (1) - x<0
%Assuming p1=1 and rho1=1 ??
rho=ones(1,N);
p=ones(1,N);
u=zeros(1,N);
%Driven part (2) - x>0
rho(1:N/2)=dr;
p(1:N/2)=pr;
E=p./(rho.*(gamma-1))+0.5.*u.^2;
U=[rho;rho.*u;rho.*E];

for n=1:length(t)
    
    for i=1:N
        %Constructing Jacobian matrix A
        A=Jacob(u(i),E(i));
        %Calculating the eigenvalues and sort in asending order
        lambda=sort(eig(A));
        c(i)=lambda(3)-lambda(2);
        
        H=E+p./rho; %Total entropy
        
        %Splitting of the eigenvalues and the fluxes
        lp=0.5.*(lambda+abs(lambda));
        lm=0.5.*(lambda-abs(lambda));
        Fp(:,i)=0.5*rho(i)/gamma.*[lp(1)+2*(gamma-1)*lp(2)+lp(3);lambda(1)*lp(1)+2*(gamma-1)*u(i)*lp(2)+lambda(3)*lp(3);(H(i)-u(i)*c(i))*lp(1)+(gamma-1)*u(i)^2*lp(2)+(H(i)+u(i)*c(i))*lp(3)];
        Fm(:,i)=0.5*rho(i)/gamma.*[lm(1)+2*(gamma-1)*lm(2)+lm(3);lambda(1)*lm(1)+2*(gamma-1)*u(i)*lm(2)+lambda(3)*lm(3);(H(i)-u(i)*c(i))*lm(1)+(gamma-1)*u(i)^2*lm(2)+(H(i)+u(i)*c(i))*lm(3)];
    end
    
    %Calculating U by using first order upwind scheme in Qusetion (2)
    for j=2:N-1
        U(:,j)=U(:,j)-dt/dx*((Fp(:,j)-Fp(:,j-1))+(Fm(:,j+1)-Fm(:,j)));
    end
    
    %Applying boundary conditions U(0)=U(1)/U(N+1)=U(N)
    U(:,1)=U(:,2);
    U(:,N)=U(:,N-1);
    
    %Updating the variables for next time iteration
    rho(:)=U(1,:);
    E(:)=U(3,:)./U(1,:);
    u(:)=U(2,:)./U(1,:);
    p(:)=(gamma-1).*rho.*(E-0.5.*u.^2);
    
end

plot(x,u./c,'LineWidth',1.5)
grid minor



function J = Jacob(u,E)

gamma=1.4;
J(1,:)=[0 1 0];
J(2,:)=[0.5*(gamma-3)*u^2 (3-gamma)*u gamma-1];
J(3,:)=[(gamma-1)*u^3-gamma*u*E gamma*E-0.5*3*(gamma-1)*u^2 gamma*u];

end