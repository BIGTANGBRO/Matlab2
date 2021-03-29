%control 5_2
%State-space model
A=[-0.0243261995104248,-8.58890563787065,-32.1699999992382,-2.50121964477236;-0.000544714905096391,-0.510791146488329,3.34868149905484e-13,0.927063537778952;0,0,0,1.00000000000000;1.26163057090700e-18,-1.16268944316632,0,-0.779147979197433];
B=[0.00393687238578542;-0.00108619425626488;0;-0.0620467050765111];
C=eye(4);
D=zeros(4,1);
sys_long = ss(A,B,C,D);

%Flight condition
V=340; %ft/s
V_meters=V/3.28;
g=9.81;

% [Q1]
%% Simplified Short Period Model
% Create the simplied short period model
A_SP=[A(2,2),A(2,4);A(4,2),A(4,4)];
B_SP=[B(2,1);B(4,1)];
C_SP=eye(2);
D_SP=zeros(2,1)
sys_long_sp = ss(A_SP,B_SP,C_SP,D_SP);


% [Q2]
% Compare response with original
T_sp=0:0.5:60;
u_sp = -1*pi/180*ones(1,length(T_sp));  %1 deg step on elevator
output_long=lsim(sys_long,u_sp,T_sp);
output_long_sp=lsim(sys_long_sp,u_sp,T_sp);

figure 
plot(T_sp, (output_long(:,4)), 'Linewidth', 2, 'color', 'b')
hold on
plot( T_sp, output_long_sp(:,2), 'Linewidth', 2, 'LineStyle', '-.', 'color', 'r')
ylabel('Pitch rate q [rad/s]', 'fontsize', 14)
xlabel('Time [s]', 'fontsize', 14)
set(gca,'FontSize',13)
legend('Original System', 'Simplifed System')
grid on

% [Q3]
% Compare the natural frequency, damping ratio and period of the short
% period mode
[Vs_sp,DDs_sp]=eig(A_SP);
lambda_sp=0.6450 + 1.0295i;
re = real(lambda_sp);
img = imag(lambda_sp);
omega_n_sp=sqrt(img^2+re^2);
zeta_sp=-re/omega_n_sp;
P_sp=2*pi/img;


% [Q3]
% DEMO Check CAP criteria
CAP_org=calcCAP( V_meters, g, omega_n, sys_long );

% DEMO: FOR YOUR OWN VISUALIZATION ONLY
figure
xlim([0.1 10])
ylim([0.1 10])
fill([0.12 0.12 10 10],[0.1 10 10 0.1],'y');hold on
fill([0.2 0.2 2 2],[0.16 10 10 0.16],'c');
fill([0.35 0.35 1.2 1.2],[0.28 3.6 3.6 0.28],'g');
plot(zeta,CAP_org,'rd','Linewidth', 2)
legend('Level 3','Level 2','Level 1','Original Design Point')
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
title('Control Anticipation Parameter requirements (Flight Phase Category A)')
xlabel('Short period damping ratio \zeta_{sp}')
ylabel('CAP [1/(gsec^2)]')