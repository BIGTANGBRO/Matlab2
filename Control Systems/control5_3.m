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
A_SP=[A(2,2),A(2,4),A(4,2),A(4,4)];
B_SP=[B(2,1);B(4,1)];
C_SP=eye(2);
D_SP=zeros(2,1);
sys_long_sp = ss(A_SP,B_SP,C_SP,D_SP);

%% CAP & Gibson design requirements reformulated
omega_n_sp_req=0.03*V_meters;
zeta_sp_req=0.5;


% [Q1]
% Obtain required short period frequency and damping through pole placement 
Realpart=-zeta_sp_req*omega_n_sp_req;
Imagpart=omega_n_sp_req*sqrt(1-(zeta_sp_req^2));
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
[y_ol,t_ol,x_ol] = initial(sys_long_sp,initialconditions_vertgust,t) %Open loop system

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



%% Obtain required time constant T_theta_2 through a lead-lag prefilter

% CAP & Gibson design requirements reformulated
T_theta2_req=1/(0.75*omega_n_sp_req);

% [Q6]
% Use tf function to concert the closed-loop system into a transfer
% function matrix
tf_sp_cl = ...

% [Q7]
% Obtain the corresponding (commanded q to q) transfer function  
tf_q_cl = ...

% [Q8]
% Design the filter by zero cancellation and placement
H = ...
    
% [Q9]
% expression for the overall system
tf_placed_zero = ...;
tf_placed_zero = minreal(tf_placed_zero);

%% Requirement Checks - gain and phase margin
w = logspace(-1,2,10000);
[mag, ph] = bode(tf_placed_zero, w);
% [Q10]
[Gm,Pm,~,~] = ...;
Gm_dB = 20*log10(Gm);
disp(['Gain margin: ',num2str(Gm_dB), '[dB]'])
disp(['Phase margin: ',num2str(Pm),' [deg]'])


% create figures
mag = squeeze(mag);
mag = 20*log10(mag);
ph = squeeze(ph);

figure
subplot(2,1,1)
semilogx(w,mag, 'Linewidth', 2)
grid on
xlabel('Frequency [rad/s]', 'fontsize', 14)
ylabel('Magnitude [dB]', 'fontsize', 14)
set(gca,'FontSize',13)

subplot(2,1,2)
semilogx(w,ph, 'Linewidth', 2)
grid on
xlabel('Frequency [rad/s]', 'fontsize', 14)
ylabel('Phase [deg]', 'fontsize', 14)
set(gca,'FontSize',13)

%% Requirement Checks
CheckCAPGibson( tf_placed_zero, V_meters );
