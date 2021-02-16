clear
clc

x=[0:0.1:25.7];
l=length(x);

%Fuselage weight distribution
%cockpit
w_f(1:l)=0;
l_f_c=4.4/0.1;
w_f(1:l_f_c+1)=7.2267*9.81.*x(1:l_f_c+1).^2;
%cabin 
l_f_m=14.3/0.1;
w_f(l_f_c+2:l_f_c+l_f_m+1)=139.86*9.81;
%tail
l_f_t=5.4/0.1;
w_f_t=4.8*9.81.*[0:0.1:5.3].^2;
w_f(l_f_c+l_f_m+2:l_f_c+l_f_m+l_f_t+1)=flip(w_f_t);

% tail
w_t(1:l)=0;
w_t(214:214+43)=(148.4+137.8)*9.81/4.3;

%passenger weight distribution
w_p(1:l)=0;
w_p(60:167)=52*85*9.81/10.96;
%pilot
w_p(30)=2*85*9.81;

%cargo weight
w_p(167+9:167+9+10)=918*9.81/0.9652;

%wing
load_f=3.5; %load factor
w=20289; %%aircraft weight
w_w(1:l)=0;
w_w(107:171)=1465.8*9.81/6.36-w*load_f*9.81;


%nacelle 
w_n(1:l)=0;
w_n(168:211)=638.3*9.81/4.31;

%engine
w_e(1:l)=0;
w_e(175:204)=1484*2/2.91;

%fuel
w_fuel(1:l)=0;
w_fuel(122:128)=3672*9.81/0.5;

% furnishing 
w_fur(1:l)=0;
w_fur(l_f_c+2:l_f_c+l_f_m+1)=1191.9*9.81/14.3;

% air_conditioning
w_air(1:l)=0;
w_air(l_f_c+2:l_f_c+l_f_m+1)=256*9.81/14.3;

%anti icing
w_ice(1:l)=41.2*9.81/24.1;

%other masses(concentrated)
w_0(1:l)=0;
%main landing gear
w_0(137)=280.7*9.81;
%nose landing gear
w_0(31)=121*9.81;
% engine control & starter
w_0(190)=(24.08+42.44)*9.81;
% fuel system
w_0(125)=(76.98)*9.81;
% flight control
w_0(169)=497.6*9.81;
% apu
w_0(214)=319*9.81;
% intruments
w_0(18)=439.8*9.81;
% hydrolic system 
w_0(121)=95.37*9.81;
% avionic
w_0(12)=697.8*9.81;
% handling gear
w_0(19)=6.2*9.81;

%total distributed load
w_tot=w_f+w_p+w_n+w_e+w_fuel+w_fur+w_air+w_ice+w_0+w_t+w_w;
figure (1);
plot(x,w_tot);
grid on
title('Force distribution')
xlabel('x');
ylabel('force N/m');

% force
for i=1:l-1
    force(i)=(w_tot(i)+w_tot(i+1))*0.1/2;
end
force(l)=0;
force=force';

% shear force
for i=1:l
   j=l+1-i;
   if j==(l)
      sf(j)=0;
   else
       sf(j)=sf(j+1)+force(j);
   end
end
sf=sf';

figure (2);
plot(x,sf);
grid on
title('Shear force distribution')
xlabel('x');
ylabel('shear force N');

%bending moment
for i=1:l-1
    m(i)=(sf(i)+sf(i+1))*0.1/2; 
end
m(l)=0;
m=m';

for i=1:l
   j=l+1-i;
   if j==(l)
      bm(j)=0;
   else
       bm(j)=bm(j+1)+m(j);
   end
end
bm=bm';
figure (3);
plot(x,bm);
grid on
title('Bending moment distribution')
xlabel('x');
ylabel('bending moment Nm');




