%This code computes the analytic solution of the 
%shock tube problem. The  flow has zero initial velocity. 
% The input data are:
% prat: pressure ratio
% denrat: density ratio
% time: time instant at which solution is computed.
%Code written by G. Papadakis, Dept. of Aeronautics, Imperial College, November 2014.

clear all;
close all;

%Enter the values of prat, denrat and time
prat=input('Enter the pressure ratio:');
denrat=input('Enter the density ratio:');
time=input('Enter the time to compute the solution:');

%Set x interval 
xmin=-2.;
xmax=2.;
xlen=xmax-xmin;

%Variables involving gamma
gamma=1.4;
cc1=0.5*(gamma-1)/gamma;
cc2=(gamma+1)/(gamma-1);

%Create a handle for our function
g=@(x) (x-1).*(1+cc2*x).^(-0.5)-1./sqrt(cc1)*sqrt(prat/denrat)*(1-(x/prat).^cc1);

%Plot the function in the interval [0,prat]
dprat=prat/100;
x = 0:dprat:prat;
y = g(x);
figure;
plot (x,y,'LineWidth', 2.0), xlabel('x'), ylabel('g(x)'), grid, title ('Function of which the root is sought')

%Now find the root of the function g(x)
% The root is the pressure ratio p2/p1 across the shock.
%Use at initial estimate x0
x0=2.0;
options = optimset('Display','iter'); % show iterations
[p2overp1 fval exitflag output]=fzero(g,x0,options)

%Compute velocities normalised by alpha1 i.e.
%the speed of sound in the low pressure section.
%Shock speed
S_over_alpha1=sqrt(cc1*(1+cc2*p2overp1));
%Contact discontinuity speed
u2_over_alpha1=1./gamma*(p2overp1-1)/sqrt(cc1*(1+cc2*p2overp1));
u3_over_alpha1=u2_over_alpha1;
%Speed of sound in region 2
alpha2_over_alpha1=sqrt(p2overp1*(cc2+p2overp1)/(1.+cc2*p2overp1));
%Head of expansion wave speed
alpha4_over_alpha1=sqrt(prat/denrat);
u_head_over_alpha1=-alpha4_over_alpha1;
%Tail of expansion wave speed
u_tail_over_alpha1=0.5*(gamma+1)*u3_over_alpha1-alpha4_over_alpha1;

%To get actual values for velocities, the values of p1,rho1 are
%needed. In the following, I assume that p1=1, rho1=1. 
p1=1;
rho1=1;
alpha1=sqrt(gamma*p1/rho1);
S=S_over_alpha1*alpha1;
u2=u2_over_alpha1*alpha1;
u3=u2;
alpha2=alpha2_over_alpha1*alpha1;
alpha4=alpha4_over_alpha1*alpha1;
u_head=-alpha4;
u_tail=u_tail_over_alpha1*alpha1;

%Now evaluate and plot the solution at t=time
%Density, Velocity, pressure, mach number, entropy

%High pressure region
xx(1)=xmin;
u(1)=0.;
p(1)=prat*p1;
rho(1)=denrat*rho1;
mach(1)=u(1)/alpha4;
entropy(1)=log(p(1)/(rho(1)^gamma));

%Head of expansion fan
xhead=u_head*time;
xx(2)=xhead;
u(2)=0.;
p(2)=prat*p1;
rho(2)=denrat*rho1;
mach(2)=u(2)/alpha4;
entropy(2)=entropy(1);

%Interior of expansion fan
xtail=u_tail*time;
nfan=10;
dxfan=(xtail-xhead)/nfan;
for ii=1:nfan;
xx(2+ii)=xx(2)+ii*dxfan;
u(2+ii)=2./(gamma+1)*(xx(2+ii)/time+0+alpha4);
alpha=u(2+ii)-xx(2+ii)/time;
p(2+ii)=p(2)*(alpha/alpha4)^((2.*gamma)/(gamma-1));
rho(2+ii)=(p(2+ii)/p(1))^(1./gamma)*rho(1);
mach(2+ii)=u(2+ii)/alpha;
entropy(2+ii)=log(p(2+ii)/(rho(2+ii)^gamma));
end
p3=p(2+nfan);
rho3=rho(2+nfan);
mach3=mach(2+ii);

%Left of contact discontinuity
xcontact=u2*time;
xx=[xx xcontact];
u=[u u3];
p=[p p3];
rho=[rho rho3];
mach=[mach mach3];
entropy=[entropy log(p3/(rho3^gamma))];

%Right of contact discontinuity
xx=[xx xcontact];
u=[u u2];
p2=p3;
p=[p p2];
rho2=gamma*p2/alpha2^2;
rho=[rho rho2];
mach=[mach u2/alpha2];
entropy=[entropy log(p2/(rho2^gamma))];

%Left of shock
xshock=S*time;
xx=[xx xshock];
u=[u u2];
p=[p p2];
rho=[rho rho2];
mach=[mach u2/alpha2];
entropy=[entropy log(p2/(rho2^gamma))];

%Right of shock
xx=[xx xshock];
u=[u 0.];
p=[p p1];
rho=[rho rho1];
mach=[mach 0.];
entropy=[entropy log(p1/(rho1^gamma))];

%Low pressure region
xx=[xx xmax];
u=[u 0.];
p=[p p1];
rho=[rho rho1];
mach=[mach 0.];
entropy=[entropy log(p1/(rho1^gamma))];

%Now plot the results
figure;
plot (xx,u,'LineWidth', 2.0, 'Color', 'b'), xlabel ('x'), ylabel ('Velocity'), grid, title ('Velocity')
figure;
plot (xx,p,'LineWidth', 2.0, 'Color', 'b'), xlabel ('x'), ylabel ('Pressure'), grid, title ('Pressure')
figure;
plot (xx,rho,'LineWidth', 2.0, 'Color', 'b'), xlabel ('x'), ylabel ('Density'), grid, title ('Density')
figure;
plot (xx,mach,'LineWidth', 2.0, 'Color', 'b'), xlabel ('x'), ylabel ('Mach number'), grid, title ('Mach number')
figure;
plot (xx,entropy,'LineWidth', 2.0, 'Color', 'b'), xlabel ('x'), ylabel ('Entropy/Cv'), grid, title ('Entropy/Cv')

%Now write the results in a file (xx density pressure velocity mach_number entropy)
filename='shock_analytic.dat'
fileID = fopen(filename,'w');
fprintf(fileID,'%12s %12s %12s %12s %12s %12s\r\n','x','rho','p','velocity','mach','entropy');
fprintf(fileID,'%12.8f %12.8f %12.8f %12.8f %12.8f %12.8f \r\n',[xx;rho;p;u;mach;entropy]);
fclose(fileID);
