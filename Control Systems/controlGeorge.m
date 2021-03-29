%% State-space model
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
A_SP=[A(2,2),A(2,4);A(4,2),A(4,4)]
B_SP=[B(2,1);B(4,1)]
C_SP=eye(2)
D_SP=zeros(2,1)
sys_long_sp = ss(A_SP,B_SP,C_SP,D_SP);


% [Q2]
% Compare response with original
T_sp=0:0.5:60;
u_sp = -1*pi/180*ones(1,length(T_sp)); %1 deg step on elevator
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
lambda_sp=-0.644969562842881 + 1.029506260837977i
re = real(lambda_sp);
im = imag(lambda_sp);
omega_n_sp=sqrt(re^2+im^2)
zeta_sp=-re/omega_n_sp
P_sp=2*pi/im


%%
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

% Copy from previous Task (code, not numerical values!)
% Create the simplied short period model
A_SP=[A(2,2),A(2,4);A(4,2),A(4,4)]
B_SP=[B(2,1);B(4,1)]
C_SP=eye(2)
D_SP=zeros(2,1)
sys_long_sp = ss(A_SP,B_SP,C_SP,D_SP);

%% CAP & Gibson design requirements reformulated
omega_n_sp_req=0.03*V_meters;
zeta_sp_req=0.5;

% [Q1]
% Obtain required short period frequency and damping through pole placement 
Realpart=- zeta_sp_req*omega_n_sp_req

Imagpart=omega_n_sp_req*sqrt(1-(zeta_sp_req^2))

p=[complex(Realpart,Imagpart) complex(Realpart,-Imagpart)];

% [Q2]
CalculatedK=place(A_SP,B_SP,p) %Use Matlab place command

% [Q3]
% create a closed-loop system, unity feedback, the four states to their
% respective inputs of the control matrix K
sys_long_sp_cl = feedback(sys_long_sp*CalculatedK,eye(2))


% [Q4]
% check the eigenvalues of the closed-loop system. 
eig_op=eig(A_SP)
eig_cl=eig(A_SP-B_SP*CalculatedK)

figure
pzmap(sys_long_sp, 'r', sys_long_sp_cl, 'b');
title('Altitude = 10000 ft Velocity = 300 ft/s, Red = Open-loop Blue = Closed-loop');
sgrid;

% [Q5]
% Check vertical gust stability
initialconditions_vertgust=[atan(4.572*3.2/V); 0];
t=0:0.1:6;
[y_cl,t_cl,x_cl] = initial(sys_long_sp_cl,initialconditions_vertgust,t)%Closed loop system
[y_ol,t_ol,x_ol] = initial(sys_long_sp,initialconditions_vertgust,t)%Open loop system

figure
subplot(2,1,1)
plot(t, rad2deg(y_ol(:,1)), 'LineWidth', 2);hold on
plot(t, rad2deg(y_cl(:,1)), 'LineWidth', 2)
grid on
ylabel('Angle of attack [deg]', 'fontsize', 14)
legend('open-loop', 'closed-loop')
subplot(2,1,2)
plot(t, rad2deg(y_ol(:,2)), 'LineWidth', 2);hold on
plot(t, rad2deg(y_cl(:,2)), 'LineWidth', 2)
grid on
xlabel('Time [s]', 'fontsize', 14)
ylabel('Pitch rate [deg/s]', 'fontsize', 14)
legend('open-loop', 'closed-loop')



