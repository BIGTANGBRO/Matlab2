%Wing Structure Sizing - AVD
clear
clc
%% load loading data
load avd_wing.mat
%[full paylod w/ fuel, full payload w/o fuel, empty w/ fuel, empty w/o
%fuel] --> n = 2.5 , n = 1
%SF_w: Shear force
%BM_w: Bending moment
%T_w: Torque
%c_w: chord
%b_w: semi-span
%b1_w: wingbox length
%b2_w: wingbox height
%A_w: wingbox area
%% Material Data
%Aluminium 2024 T3 - lower skin
E_al2=73.1e09; % Young Modulus
G_al2=28.7e09; % Shear Modulus
nu_al2=0.337; % Poisson Ratio
rho_al2=2800; % Density
yt_al2=290e06; % Tensile Yield Strength
yc_al2=320e06; %Compressive Yield Strength
ss_al2=283e06; %Shear strength
%Aluminium 7075 T6 - upper skin and spars and ribs
E_al7=71.7e09;
G_al7=27e09;
nu_al7=0.33;
rho_al7=2800;
yt_al7=503e06;
yc_al7=511e06;
ss_al7=331e06;
%% Spar Design
%shear flow in wing box
qSF_w = SF_w./(2*b2_w);
qT_w = T_w./(2*A_w);
%required spar thicknesses
Ks=8.1; %shear buckling coefficient
q1=abs(qSF_w+qT_w);
q2=abs(qSF_w-qT_w);
tfspar_w=(1000*(((q1.*b2_w)/(2*Ks*E_al7)).^(1/3)));
trspar_w=(1000*(((q2.*b2_w)/(2*Ks*E_al7)).^(1/3)));
%round to nearest 0.1mm
tfspar_round_w=ceil(tfspar_w*10)/10;
trspar_round_w=ceil(trspar_w*10)/10;
%choose worse case thickness to use
tfspar_worst_w=tfspar_round_w(:,4);
trspar_worst_w=trspar_round_w(:,1);
%change tip spar thickness to be non zero
tfspar_worst_w(length(tfspar_worst_w))=tfspar_worst_w(length(tfspar_worst_w)-1);
trspar_worst_w(length(trspar_worst_w))=trspar_worst_w(length(trspar_worst_w)-1);
%change q column according t where worse load is
tfspar_sigmacr=8.1*E_al7.*((tfspar_worst_w/1000)./b2_w).^2;
tau_fspar=q1(:,4)./(2*b2_w.*(tfspar_worst_w/1000));
%comparison of shear stress with critical
trspar_sigmacr=8.1*E_al7.*((trspar_worst_w/1000)./b2_w).^2;
tau_rspar=q1(:,1)./(2*b2_w.*(trspar_worst_w/1000));
%plot
fig1=figure("Name","Front Spar Thickness");
plot(b_w,tfspar_w(:,4))
grid on
hold on
plot(b_w,tfspar_worst_w)
xlabel("Wing Semi-span [m]")
ylabel("Front Spar Required Thickness [mm]")
legend("Required Spar Thickness","Spar Thickness With Manufacturing Constraints")
saveas(fig1,"front_spar_thickness","epsc")
fig2=figure("Name","Rear Spar Thickness ");
plot(b_w,trspar_w(:,1))
grid on
hold on
plot(b_w,trspar_worst_w)
xlabel("Wing Semi-span [m]")
ylabel("Rear Spar Required Thickness [mm]")
legend("Required Spar Thickness","Spar Thickness With Manufacturing Constraints")
saveas(fig2,"rear_spar_thickness","epsc")

%% Skin-stringer Panel Requirements
%no stringer skin thickness
%set rib spacing
L=0.5; % in m
%Compression End load including torque
N=sqrt((T_w./(b2_w.*L)).^2+((abs(BM_w)./(b1_w.*b2_w)).^2));
%solve sigma_cr=N/T (T:effective thickness) T=tskin for no stringers

%upper skin - Al7075
tus_nostr=1000*((N.*(b1_w.^2))./(3.62.*E_al7)).^(1/3); %in mm
tus_nostr_round=ceil(tus_nostr.*10)/10; %nearest 0.1mm
%find the most restricting case
us_worst=tus_nostr_round(1,1);
us_n=1;
for i=1:8
for j=1:length(tus_nostr_round)
if tus_nostr_round(j,i)>us_worst
tus_nostr_round(j,i)=us_worst;
us_n=i;
end
end
end
tus_nostr_worst=tus_nostr_round(:,us_n);
for i=1:tus_nostr_worst
if tus_nostr_worst(i)<0.5
tus_nostr_worst(i)=0.5;
end
end
sigma_us_nostr=N./(tus_nostr_worst*0.001);
%lower skin - Al2024
tls_nostr=1000*((N.*(b1_w.^2))./(3.62.*E_al2)).^(1/3); %in mm
tls_nostr_round=ceil(tls_nostr.*10)/10; %nearest 0.1mm
%find the most restricting case
ls_worst=tls_nostr_round(1,1);
ls_n=1;
for i=1:8
for j=1:length(tls_nostr_round)
if tls_nostr_round(j,i)>ls_worst
tls_nostr_round(j,i)=ls_worst;
ls_n=i;
end
end
end
tls_nostr_worst=tls_nostr_round(:,ls_n);
for i=1:tls_nostr_worst
if tls_nostr_worst(i)<0.5
tls_nostr_worst(i)=0.5;
end
end
sigma_ls_nostr=N./(tls_nostr_worst*0.001);
fig3=figure("Name","No Stringer Skin Thickness");
plot(b_w,tus_nostr(:,1))
grid on
hold on
plot(b_w,tus_nostr_worst);
plot(b_w,tls_nostr(:,1))
plot(b_w,tls_nostr_worst);
xlabel("Wing Semi-span [m]")
ylabel("Skin Thickness For No Stringer [mm]")
legend("Required Upper Skin Thickness","Upper Skin Thickness With Manufacturing Constraints","Required Lower Skin Thickness","Lower Skin Thickness With Manufacturing Constraints")
saveas(fig3,"skin_t_no_stringers","epsc")
fig4=figure("Name","No Stringers Upper Skin Stress");
plot(b_w,sigma_us_nostr(:,1))
grid on
hold on
plot(b_w,sigma_ls_nostr(:,1))
xlabel("Wing Semi-Span [m]")
ylabel("Skin Stress For No Stringer [Pa]")
legend("Upper Skin","Lower Skin")
saveas(fig4,"skin_stress_no_stringers","epsc")
%sigma_cr/sigma_o = critical stress factor (csf)
%Rt=ts/t ts- stringer thickness t - skin thickness
%Rb=d/b = h/b
%b - stringer spacing
%h - depth of stringer
%d - stiffener depth from skin centre to tip
%assume Rb=0.65 and Rt=2.25 F=0.81 (optimum)
Rb=0.65;
Rt=2.25;
F=0.81;
CSF=1.55;
tskin_str=1000*((1/(F*(1+Rt*Rb))).*(((N.*L)./E_al7).^(1/2))); %in mm
b_str=1000*(1.103*((sqrt(F).*(1+Rt*Rb))/(((Rb.^3)*Rt*(4+Rb*Rt))^(0.5))).*(((N.*(L.^3))/E_al7).^(0.25))); %in mm
tskin_str_round=ceil(tskin_str*10)/10;
b_str_round=ceil(b_str);
%find value of b which occurs the most in each column
for i=1:8
n=1;
values(n,i)=b_str_round(1,i);
occur(n,i)=1;
for j=1:length(b_str_round)
if b_str_round(j,i) == values(n,i)
occur(n,i)=occur(n,i)+1;
elseif b_str_round(j,i)
n=n+1;
values(n,i)=b_str_round(j,i);
occur(n,i)=1;
end
end
end
max1=max(occur);
for i=1:8
for j=1:length(b_str_round)
if occur(j,i) == max1(i)
b(1,i) = values(j,i);
break
end
end
end
A=size(tskin_str_round);
for i=1:A(1)
for j=1:A(2)
if tskin_str_round(i,j) < 0.5
tskin_str_round(i,j)=0.5;
end
end
end
t0.s=Rt.*tskin_str_round; %thickness of stringer
ts_worse=ts(:,1);
tskin_str_worse=tskin_str_round(:,1);
b=b(1);
hs=Rb.*b; %height of stringer
%calculate number of stringers at each span
num_str=ceil(b1_w./(b/1000));
%calculate volume of stringers
for i=1:length(b_w)
V_str(i)=(num_str(i)*hs*ts_worse(i));
V_skin(i)=((num_str(i)-1)*b*tskin_str_worse(i));
V_nostr(i)=tus_nostr_worst(i)*(b1_w(i)*1000);
end
Vtot_str=sum(V_str);
Vtot_skin=sum(V_skin);
Vtot_nostr=sum(V_nostr);
Vtot_stringer=Vtot_str+Vtot_skin;
%calculate weight reduction
WD=((Vtot_nostr-Vtot_str)./Vtot_nostr)*100;
%calculate and check stress values against yield
%use effective thickness
T_eff=(1/F).*sqrt((N*L)./E_al7);
sigma_eff=N./(T_eff);
%lower skin
tlskin_str=1000*((1/(F*(1+Rt*Rb))).*(((N.*L)./E_al2).^(1/2))); %in mm
bls_str=1000*(1.103*((sqrt(F).*(1+Rt*Rb))/(((Rb.^3)*Rt*(4+Rb*Rt))^(0.5))).*(((N.*(L.^3))/E_al2).^(0.25))); %in mm
tlskin_str_round=ceil(tlskin_str*10)/10;
bls_str_round=ceil(bls_str);
%find value of b which occurs the most in each column
for i=1:8
n=1;
values(n,i)=bls_str_round(1,i);
occur(n,i)=1;
for j=1:length(bls_str_round)
if bls_str_round(j,i) == values(n,i)
occur(n,i)=occur(n,i)+1;
elseif bls_str_round(j,i)
n=n+1;
values(n,i)=bls_str_round(j,i);
occur(n,i)=1;
end
end
end
max2=max(occur);
for i=1:8
for j=1:length(bls_str_round)
if occur(j,i) == max2(i)
bls(1,i) = values(j,i);
break
end
end
end
A=size(tlskin_str_round);
for i=1:A(1)
for j=1:A(2)
if tlskin_str_round(i,j) < 0.5
tlskin_str_round(i,j)=0.5;
end
end
end
ts_ls=Rt.*tlskin_str_round; %thickness of stringer
ts_ls_worse=ts_ls(:,1);
tlskin_str_worse=tlskin_str_round(:,1);
bls=bls(1);
hs_ls=Rb.*bls; %height of stringer
%calculate number of stringers at each span
num_str=ceil(b1_w./(bls/1000));
%calculate volume of stringers
for i=1:length(b_w)
V_str_ls(i)=(num_str(i)*hs_ls*ts_ls_worse(i));
V_skin_ls(i)=((num_str(i)-1)*bls*tlskin_str_worse(i));
V_nostr_ls(i)=tls_nostr_worst(i)*(b1_w(i)*1000);
end
Vtot_str_ls=sum(V_str_ls);
Vtot_skin_ls=sum(V_skin_ls);
Vtot_nostr_ls=sum(V_nostr_ls);
Vtot_with_ls=Vtot_str_ls+Vtot_skin_ls;
%calculate weight reduction
WD=((Vtot_nostr_ls-Vtot_str_ls)./Vtot_nostr_ls)*100;
%calculate and check stress values against yield
%use effective thickness
T_eff_ls=(1/F).*sqrt((N*L)./E_al2);
sigma_eff_ls=N./(T_eff_ls);
fig5=figure("Name","Skin Thickness With Stringer");
plot(b_w,tskin_str(:,1))
hold on
grid on
plot(b_w,tskin_str_worse)
plot(b_w,tlskin_str(:,1))
plot(b_w,tlskin_str_worse)
xlabel("Wing Semi-Span [m]")
ylabel("Skin Thickness With Stringers [mm]")
legend("Required Upper Skin Thickness","Upper Skin Thickness With Manufacturing Constraints","Required Lower Skin Thickness","Lower Skin Thickness With Manufacturing Constraints")
saveas(fig5,"skin_t_w_stringers","epsc")
fig6=figure("Name","Skin Stress with Stringers");
plot(b_w,sigma_eff(:,1))
grid on
hold on
plot(b_w,sigma_eff_ls(:,1))
xlabel("Wing Semi-Span [m]")
ylabel("Skin Stress With Stringers [Pa]")
legend("Upper Skin","Lower Skin")
saveas(fig6,"skin_stress_w_stringers","epsc")
%% Rib Design
%calculate rib thickness
rib_t=1000*((N.*(b2_w).^2)./(CSF.*E_al7.*3.62)).^(1/3);
rib_t_worse=ceil(rib_t(:,1)*10)/10;
for i=1:length(rib_t_worse)
if rib_t_worse(i) < 0.5
rib_t_worse(i) = 0.5;
end
end
%select the ribs according to the spacing
%rib spacing = 0.5m
rib_t_spaced=rib_t_worse(1:5:85);
b_w_spaced=b_w(1:5:85);
b2_spaced=b2_w(1:5:85);
N_spaced=N(1:5:85);
sigma_rib=N_spaced./((rib_t_spaced/1000).*b2_spaced);
fig7=figure("Name","Rib Thickness");
plot(b_w,rib_t(:,1))
hold on
grid on
plot(b_w,rib_t_worse)
xlabel("Wing Semi-Span [m]")
ylabel("Required Rib Thickness [mm]")
legend("Required Rib Thickness","Rib Thickness With Manufacturing Constraints")
saveas(fig7,"rib_thickness","epsc")