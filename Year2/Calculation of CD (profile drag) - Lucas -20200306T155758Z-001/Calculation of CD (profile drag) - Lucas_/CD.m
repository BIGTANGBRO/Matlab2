% This is a script to calculate the CD of the airfoil in the wake momentum
% lab

clear 
clc
T = readmatrix('profiledragwakemom.xlsx','Sheet',2,'Range','A2:L3'); 

% Using the trapezium method of integration to evaluate CD:
h = 0.254; % in cm (unit doesn't affect the value of CD)
f = @(i) sqrt(abs(T(2,i)-T(2,11))/T(2,12))*(1-sqrt(abs(T(2,i)-T(2,11))/T(2,12)));
Cd = 0;
for i = 1:9
    Cd = Cd + h/2*(f(i+1)+f(i));
end 
Cd = Cd/(7*h);
% note that trapezium method between the data points was used, not between
% many discrete points along the cubic spline curve (SOURCE OF ERROR) 

% Creating an array K for the plots
K = T(:,1:10);
for i = 1:10
    K(2,i) = sqrt(abs(K(2,i)-T(2,11))/T(2,12))*(1-sqrt(abs(K(2,i)-T(2,11))/T(2,12)));
end 
% note that the points on the far right and far left of the center line
% were approximated to be equal to the free stream dynamic pressure. In
% reality they were slightly less than 27.8 - they were 27.6 on far left
% and 27.7 on far right. Whether this means that true free stream static
% pressure is less than 27.8 is debatable, but certainly could be a SOURCE
% OF ERROR in the calculation of CD. 
% Also note the asymmetry in the location of the centre line and in the
% integrand values. This could be because of the angle we tilted the
% aerofoil at to have symmetric flow over it.

% use 'errorbar' to plot error bars and data points
error = [0,0,0,0.022,0.014,0.01,0.0077,0.0077,0.0091,0.012,0.022,0,0,0];
x = [-1.651,-1.3970,K(1,:),1.3970,1.651];
y = [0,0,K(2,:),0,0];
errorbar(x,y,error,'*r','MarkerSize',6)
hold on
[xval,yval] = cubicspline([-1.651,-1.3970,K(1,:),1.3970,1.651],[0,0,K(2,:),0,0]);
plot(xval,yval,'-.r') 
grid on
xlabel('Distance from wake centre line (cm)','FontSize',12,'FontWeight','bold')
ylabel('Integrand value','FontSize',12,'FontWeight','bold')

