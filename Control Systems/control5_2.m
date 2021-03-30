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
D_SP=zeros(2,1);
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
lambda_sp=-0.6450 + 1.0295i;
re = real(lambda_sp);
img = imag(lambda_sp);
omega_n_sp=sqrt(img^2+re^2);
zeta_sp=-re/omega_n_sp;
P_sp=2*pi/img;