%THIS code is used to calculate P and F for the given blade;
clear
clc

R=5;%radius of rotor
B=3;%number of blades;
V_0=10;
n=3000/60;%this is the rotational speed in rpm;
rho_a=1.225;%the density of the atmosphere;
beta_p=0;%pitch angle;
n_element=8;%the number of ring elements;
omega=n*2*pi;%angular velocity;

for i=1:7
    r_div_R(i)=(i+0.5)/8;
end

c_div_R(1)=0.2889;
beta_0(1)=23.92;
c_div_R(2)=0.2249;
beta_0(2)=14.98;
c_div_R(3)=0.1787;
beta_0(3)=9.96;
c_div_R(4)=0.1474;
beta_0(4)=6.76;
c_div_R(5)=0.1252;
beta_0(5)=4.56;
c_div_R(6)=0.1088;
beta_0(6)=2.96;
c_div_R(7)=0.0961;
beta_0(7)=1.74;

for i=1:7
    beta(i)=beta_0(i)+beta_p;
end

syms a_axial a_tangential C_x C_y

for i=1:7
    r(i)=r_div_R(i)*R;
    c(i)=c_div_R(i)*R;
    w_rel(i)=sqrt((omega*r(i)*(1+a_tangential(i)))^2+((1-a_axial(i))*V_0)^2);
    F_x(i)=0;5*rho_a*w_rel(i)^2*c(i)*C_x(i);
    F_y(i)=0;5*rho_a*w_rel(i)^2*c(i)*C_y(i);
    P(i)=R/8*B*omega*F_x(i)*r(i);
    Fa(i)=B*R/8*F_y(i);
end

P_rotor=sum(P)/1000;
F_rotor=sum(Fa)/1000;
P_r_max=16/27 *pi *R^2*(1/2)*rho_a*V_0^3/1000;
eta_r=P_rotor/P_r_max*1000;
disp(P_rotor);
disp(F_rotor);
disp(P_r_max);
disp(eta_r);





    