% Parameters
K_p=5;
K_d=2;
J=1;


% [Task 1]
% Open-loop transfer function
s=tf('s');
tf_satellite_ol=...;
    
% DEMO
tf_satellite_cl=tf_satellite_ol/(1+tf_satellite_ol);
disp(['System poles before minreal command: '])
disp(pole(tf_satellite_cl))
disp(['System zeros before minreal command: '])
disp(zero(tf_satellite_cl))
tf_satellite_cl=minreal(tf_satellite_cl);
disp(['System poles after minreal command: '])
disp(pole(tf_satellite_cl))
disp(['System zeros after minreal command: '])
disp(zero(tf_satellite_cl))
disp([' '])


% [Task 2]
% Natural frequency
omega_0=...;

% Damping ratio
zeta=...;


% [Task 3]
% From the system poles, do you expect the system response to become
% non-oscillatory for certain values of K_p?
% Yes, it can become non-oscillatory - 1
% No, it can never become non-oscillatory - 0
Sys_resp_aperiodic=...;

% if yes, with K_d and J fixed, calculate the largest K_p which has a non-oscillatory response
K_p_2=...;


% [Task 4]
% form the closed-loop transfer function using K_p_2
tf_satellite_cl_2=...;

% System poles
disp(['System poles with Kp=' num2str(K_p_2)])
disp(pole(tf_satellite_cl_2))


% Numerical value for time domain response using Matlab step command
t=0:0.01:20;

% with K_p=5, use system 'tf_satellite_cl' directly
y_num_cl=...;
% with the newly calculated K_p_2, use system 'tf_satellite_cl_2' directly
y_num_cl_2=...;


plot(t, y_num_cl, 'Linewidth', 2);hold on
plot( t, y_num_cl_2, 'Linewidth', 2, 'LineStyle', '-.')
ylabel('\theta [rad]', 'fontsize', 14)
xlabel('Time [s]', 'fontsize', 14)
legend(['K_p = ' num2str(K_p)], ['K_p = ' num2str(K_p_2)])
set(gca,'FontSize',13)
grid on



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
%% Longitudinal Eigenmotion analysis
[Vs,DDs]=eig(...);

% FOR YOUR OWN VISUALIZATION ONLY, uncomment when needed
figure
pzmap(sys_long, 'r');
title_string = sprintf('Altitude = 10000 ft Velocity = %.2f ft/s', V);
title(title_string);
sgrid;

% [Q2]
% Select short period eigenvalue, compute natural frequency, damping ratio
% and the period of oscillations
lambda=...
omega_n=...
zeta=...
P=...

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



