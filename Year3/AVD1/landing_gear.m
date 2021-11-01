function [Xn,Xm]=landing_gear(X_cg,Z_cg,alpha_lift_off)
%code the find the optimum wing position
%landin gear segment 
Aft=17;
%in degrees
%main gear positon constraints 
% alpha_lift_off   
diameter=3;
%tip back
tip_back=alpha_lift_off+0.1;
ver_cg=tip_back+0.1;
maingear_x=X_cg:0.1: Aft;
for i=1:length(maingear_x)
x_cg(i)=X_cg;
end
x_h=Aft-maingear_x;
h_main=x_h*tand(tip_back);
%vertical CG
x_to_cg=abs(x_cg-maingear_x);
z_to_cg=x_to_cg./tand(ver_cg);
h_main_vertical_cg=z_to_cg-Z_cg-diameter/2;
tipback=polyfit(maingear_x,h_main,1);
vcg=polyfit(maingear_x,h_main_vertical_cg,1);
Xm=abs((vcg(2)-tipback(2))/(vcg(1)-tipback(1)));
Xn=2;
end


