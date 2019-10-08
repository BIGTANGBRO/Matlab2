%this is to simulated the ees-program.
alpha=input('input the value of alpha:');
alpha_s=16;
C_dmax=1;
C_lift_s=1.0318E-01+1.0506E-01*alpha_s+1.0483E-03*alpha_s^2+7.3487E-06*alpha_s^3-6.5827E-06*alpha_s^4;
C_drag_s=6.0387E-03-3.6282E-03*alpha_s+5.4269E-05*alpha_s^2+6.5341E-6*alpha_s^3-2.8045E-07*alpha_s^4;

B1=C_dmax;
B2=1/cos(alpha_s)*(C_drahg_s-C_dmax*sin(alpha_s)^2);
A1=B1/2;
A2=(C_lift_s-C_dmax*sin(alpha_s)*cos(alpha_s))*(sin(alpha_s)/cos(alpha_s)^2);
if alpha<alpha_s
    C_lift=1.0318E-01+1.0516E-01*alpha+1.0483E-03*alpha^2+7.3487E-06*alpha^3-6.5827E-06*alpha^4;
    C_drag=6.0387E-03-3.6282E-03*alpha+5.4269E-05*alpha^2+6.5341E-6*alpha^3-2.8045E-07*alpha^4;
else
    C_lift=A1*sin(2*alpha)+A2*(cos(alpha))^2/sin(alpha);
    C_drag=B1*(sin(alpha))^2+B2*cos(alpha)+C_drag_s;
end

a_axial=0.3;
a_tangential=0.000001;

while 1
    a_axial_old=a_axial;
    a_tangential_old=a_tangential;
    phi=actan(((1-a_axial)/(1+a_tangential))*(V_0/(ri*omega)));
    alpha=phi-betai;
    sigma=(c*B)/(2*pi*ri);
    