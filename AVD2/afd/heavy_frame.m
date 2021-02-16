clear
clc
close all

%Front gear heavy frame
F_f=1.229e4; % reaction force on font landing gear
theta_f=180; % angle at which the force is acting
[N_f,S_f,M_f,si_f]=radQ(F_f,theta_f,200,2.76/2);
figure (1)
plot(si_f,N_f,'linewidth',2);
hold on
grid on
plot(si_f,S_f,'linewidth',2);
plot(si_f,M_f,'linewidth',2);
title('Front Gear Frame','interpreter','latex');
legend('Normal force','Shear force','Bending moment');
xlim([0 360]);
M_max=15488;
F_max=9842;
h=[0.05:0.01:0.1];
b=[0.05:0.01:0.15];
syms t
k=1;
for i=1:length(h)
   for j=1:length(b)
      eqn=M_max*h(i)*0.5/((h(i)^3/6+b(j)*h(i)^2/6+b(j)*h(i)^2/4)*t+(b(j)/18+b(j)/12)*t^3)+F_max/(t*(h(i)+5/3*b(j))+5/3*b(j)*0.0023) == 2.6e8;
      t_s(:,k)=double(solve(eqn,t,'Maxdegree',3));
      t_t(i,j)=t_s(2,k);
      A(i,j)=t_t(i,j)*(h(i)+5/3*b(j));
      k=k+1;
   end
end
h_f(1)=h(6);
b_f(1)=b(7);
t_f(1)=t_t(6,7);
A_f(1)=A(6,7);

s_max=12290;
s_s=12290/A_f(1);
if s_s>207e6
   s_f(1)=0;
else
    s_f(1)=1;
end


%% Front spar heavy frame
F_fs=-360074/2; % reaction at the front spar
theta_fs1=152; % in degree
F_fs_r1=F_fs*cos(deg2rad(theta_fs1)); % force in radial direction
F_fs_t1=F_fs*sin(deg2rad(theta_fs1));

[N_fs_r1,S_fs_r1,M_fs_r1,si_fs]=radQ(F_fs_r1,theta_fs1,200,1.5);
[N_fs_t1,S_fs_t1,M_fs_t1,si_fs]=tanP(F_fs_t1,theta_fs1,200,1.5);

theta_fs2=208;
F_fs_r2=F_fs*cos(deg2rad(theta_fs2));
F_fs_t2=F_fs*sin(deg2rad(theta_fs2));

[N_fs_r2,S_fs_r2,M_fs_r2,si_fs]=radQ(F_fs_r2,theta_fs2,200,1.5);
[N_fs_t2,S_fs_t2,M_fs_t2,si_fs]=tanP(F_fs_t2,theta_fs2,200,1.5);

N_fs=N_fs_r1+N_fs_r2+N_fs_t1+N_fs_t2;
S_fs=S_fs_r1+S_fs_r2+S_fs_t1+S_fs_t2;
M_fs=M_fs_r1+M_fs_r2+M_fs_t1+M_fs_t2;

figure(2)
plot(si_fs,N_fs,'linewidth',2);
hold on
plot(si_fs,S_fs,'linewidth',2);
plot(si_fs,M_fs,'linewidth',2);
grid on
title('Front Spar Frame','interpreter','latex');
legend('Normal force','Shear force','Bending moment','interpreter','latex');
xlim([0 360]);

M_max=431603;
F_max=252539;
h=[0.05:0.01:0.15];
b=[0.1:0.01:0.3];
syms t
k=1;
for i=1:length(h)
   for j=1:length(b)
      eqn=M_max*h(i)*0.5/((h(i)^3/6+b(j)*h(i)^2/6+b(j)*h(i)^2/4)*t+(b(j)/18+b(j)/12)*t^3)+F_max/(t*(h(i)+5/3*b(j))+5/3*b(j)*0.0023) == 2.6e8;
      t_s(:,k)=double(solve(eqn,t,'Maxdegree',3));
      t_t(i,j)=t_s(2,k);
      A(i,j)=t_t(i,j)*(h(i)+5/3*b(j));
      k=k+1;
   end
end
h_f(2)=h(11);
b_f(2)=b(21);
t_f(2)=t_t(11,21);
A_f(2)=A(11,21);

s_max=241225;
s_s=s_max/A_f(2);
if s_s>207e6
   s_f(2)=0;
else
    s_f(2)=1;
end
%% Rear spar heavy frame
F_rs=-111005/2;
theta_rs1=152; % in degree
F_rs_r1=F_rs*cos(deg2rad(theta_rs1)); % force in radial direction
F_rs_t1=F_rs*sin(deg2rad(theta_rs1));

[N_rs_r1,S_rs_r1,M_rs_r1,si_rs]=radQ(F_rs_r1,theta_rs1,200,1.5);
[N_rs_t1,S_rs_t1,M_rs_t1,si_rs]=tanP(F_rs_t1,theta_rs1,200,1.5);

theta_rs2=208;
F_rs_r2=F_rs*cos(deg2rad(theta_rs2));
F_rs_t2=F_rs*sin(deg2rad(theta_rs2));

[N_rs_r2,S_rs_r2,M_rs_r2,si_rs]=radQ(F_rs_r2,theta_rs2,200,1.5);
[N_rs_t2,S_rs_t2,M_rs_t2,si_rs]=tanP(F_rs_t2,theta_rs2,200,1.5);

N_rs=N_rs_r1+N_rs_r2+N_rs_t1+N_rs_t2;
S_rs=S_rs_r1+S_rs_r2+S_rs_t1+S_rs_t2;
M_rs=M_rs_r1+M_rs_r2+M_rs_t1+M_rs_t2;

figure(3)
plot(si_rs,N_rs,'linewidth',2);
hold on
plot(si_rs,S_rs,'linewidth',2);
plot(si_rs,M_rs,'linewidth',2);
grid on
title('Rear Spar Frame','interpreter','latex');
legend('Normal force','Shear force','Bending moment','interpreter','latex');
xlim([0 360]);

M_max=132827;
F_max=77853;
h=[0.05:0.01:0.10];
b=[0.1:0.01:0.3];
syms t
k=1;

for i=1:length(h)
   for j=1:length(b)
      eqn=M_max*h(i)*0.5/((h(i)^3/6+b(j)*h(i)^2/6+b(j)*h(i)^2/4)*t+(b(j)/18+b(j)/12)*t^3)+F_max/(t*(h(i)+5/3*b(j))+5/3*b(j)*0.0023) == 2.6e8;
      t_s(:,k)=double(solve(eqn,t,'Maxdegree',3));
      t_t(i,j)=t_s(2,k);
      A(i,j)=t_t(i,j)*(h(i)+5/3*b(j));
      k=k+1;
   end
end
h_f(3)=h(6);
b_f(3)=b(17);
t_f(3)=t_t(6,17);
A_f(3)=A(6,17);

s_max=74375;
s_s=s_max/A_f(3);
if s_s>207e6
   s_f(3)=0;
else
    s_f(3)=1;
end

%% Engine heavy frame
theta_e1=49.7;
theta_e2=360-49.7; % in degree
F_e=(638.3+1484)*9.81/2; % engine and nacelle weight
T_e=(638.3+1484)*9.81/2*2.1; %torque

% Force decouple
F_e_r1=F_e*cos(deg2rad(theta_e1));
F_e_t1=F_e*sin(deg2rad(theta_e1));

[N_e_r1,S_e_r1,M_e_r1,si_e]=radQ(F_e_r1,theta_e1,200,2.44/2);
[N_e_t1,S_e_t1,M_e_t1,si_e]=tanP(F_e_t1,theta_e1,200,2.44/2);

F_e_r2=F_e*cos(deg2rad(theta_e2));
F_e_t2=F_e*sin(deg2rad(theta_e2));

[N_e_r2,S_e_r2,M_e_r2,si_e]=radQ(F_e_r2,theta_e2,200,2.44/2);
[N_e_t2,S_e_t2,M_e_t2,si_e]=tanP(F_e_t2,theta_e2,200,2.44/2);

% Torque
[N_e_1,S_e_1,M_e_1,si_e]=torT(T_e,theta_e1,200,2.44/2);
[N_e_2,S_e_2,M_e_2,si_e]=torT(-T_e,theta_e2,200,2.44/2);

% sum up
N_e=N_e_r1+N_e_t1+N_e_r2+N_e_t2+N_e_1;
S_e=S_e_r1+S_e_t1+S_e_r2+S_e_t2+S_e_1;
M_e=M_e_r1+M_e_t1+M_e_r2+M_e_t2+M_e_1;

figure(4)
plot(si_e,N_e,'linewidth',2);
hold on
plot(si_e,S_e,'linewidth',2);
plot(si_e,M_e,'linewidth',2);
grid on
title('Engine/Nacelle Frame','interpreter','latex');
legend('Normal force','Shear force','Bending moment','interpreter','latex');
xlim([0 360]);

M_max=21403;
F_max=10550;
h=[0.01:0.01:0.10];
b=[0.05:0.01:0.3];
syms t
k=1;
for i=1:length(h)
   for j=1:length(b)
      eqn=M_max*h(i)*0.5/((h(i)^3/6+b(j)*h(i)^2/6+b(j)*h(i)^2/4)*t+(b(j)/18+b(j)/12)*t^3)+F_max/(t*(h(i)+5/3*b(j))) == 2.6e8;
      t_s=double(solve(eqn,t,'Maxdegree',3));
      t_t(i,j)=t_s(1);
      A(i,j)=t_t(i,j)*(h(i)+5/3*b(j));
   end
end
h_f(4)=h(9);
b_f(4)=b(23);
t_f(4)=t_t(9,23);
A_f(4)=A(9,23);

s_max=12452;
s_s=s_max/A_f(4);
if s_s>207e6
   s_f(4)=0;
else
    s_f(4)=1;
end

%% Tail front spar heavy ring
F_t=(148.4+137.8)*9.81/2;
T_t=-156500;

[N_ft_1,S_ft_1,M_ft_1,si_t]=radQ(F_t,0,200,1.25/2);
[N_ft_2,S_ft_2,M_ft_2,si_t]=torT(T_t,0,200,1.25/2);

N_ft=N_ft_1+N_ft_2;
S_ft=S_ft_1+S_ft_2;
M_ft=M_ft_1+M_ft_2;

figure(5)
plot(si_t,N_ft,'linewidth',2);
hold on
plot(si_t,S_ft,'linewidth',2);
plot(si_t,M_ft,'linewidth',2);
grid on
title('Tail front spar Frame','interpreter','latex');
legend('Normal force','Shear force','Bending moment','interpreter','latex');
xlim([0 360]);


M_max=78459;
F_max=335;
h=[0.05:0.01:0.1];
b=[0.05:0.01:0.15];
syms t
k=1;

for i=1:length(h)
   for j=1:length(b)
      eqn=M_max*h(i)*0.5/((h(i)^3/6+b(j)*h(i)^2/6+b(j)*h(i)^2/4)*t+(b(j)/18+b(j)/12)*t^3)+F_max/(t*(h(i)+5/3*b(j))) == 2.6e8;
      t_s=double(solve(eqn,t,'Maxdegree',3));
      t_t(i,j)=t_s(1);
      A(i,j)=t_t(i,j)*(h(i)+5/3*b(j));
   end
end
h_f(5)=h(6);
b_f(5)=b(9);
t_f(5)=t_t(6,9);
A_f(5)=A(6,9);
s_max=120208;
s_s=s_max/A_f(5);
if s_s>207e6
   s_f(5)=0;
else
    s_f(5)=1;
end

%% Tail rear spar heavy ring
F_t=(148.4+137.8)*9.81/2;
T_t=-174500;

[N_rt_1,S_rt_1,M_rt_1,si_r]=radQ(F_t,0,200,0.82/2);
[N_rt_2,S_rt_2,M_rt_2,si_r]=torT(T_t,0,200,0.82/2);

N_rt=N_rt_1+N_rt_2;
S_rt=S_rt_1+S_rt_2;
M_rt=M_rt_1+M_rt_2;

figure(6)
plot(si_r,N_rt,'linewidth',2);
hold on
plot(si_r,S_rt,'linewidth',2);
plot(si_r,M_rt,'linewidth',2);
grid on
title('Tail rear spar Frame','interpreter','latex');
legend('Normal force','Shear force','Bending moment','interpreter','latex');
xlim([0 360]);

M_max=37387;
F_max=335;
h=[0.05:0.01:0.1];
b=[0.05:0.01:0.15];
syms t
k=1;
for i=1:length(h)
   for j=1:length(b)
      eqn=M_max*h(i)*0.5/((h(i)^3/6+b(j)*h(i)^2/6+b(j)*h(i)^2/4)*t+(b(j)/18+b(j)/12)*t^3)+F_max/(t*(h(i)+5/3*b(j))) == 2.6e8;
      t_s=double(solve(eqn,t,'Maxdegree',3));
      t_t(i,j)=t_s(1);
      A(i,j)=t_t(i,j)*(h(i)+5/3*b(j));
   end
end
h_f(6)=h(5);
b_f(6)=b(10);
t_f(6)=t_t(5,10);
A_f(6)=A(5,10);

s_max=202455;
s_s=s_max/A_f(6);
if s_s>207e6
   s_f(6)=0;
else
    s_f(6)=1;
end
