%control 4_2
% Parameters
K_p=5;
K_d=2;
J=1;


% [Task 1]
% Open-loop transfer function
s=tf('s');

tf_satellite_ol=K_p*(1/(J*s*(1+K_d/(J*s))))*(1/s);


% DEMO
tf_satellite_cl=tf_satellite_ol/(1+tf_satellite_ol);
disp(['System poles before minreal command: '])
disp(pole(tf_satellite_cl))
disp(['System zeros before minreal command: '])
disp(zero(tf_satellite_cl))
tf_satellite_cl=minreal(tf_satellite_cl)
disp(['System poles after minreal command: '])
disp(pole(tf_satellite_cl))
disp(['System zeros after minreal command: '])
disp(zero(tf_satellite_cl))
disp(['  '])


% [Task 2]
% Natural frequency
omega_0=sqrt(5);

% Damping ratio
zeta=sqrt(5)/5;


% [Task 3]
% From the system poles, do you expect the system response to become
% non-oscillatory for certain values of K_p?
%   Yes, it can become non-oscillatory  -  1
%   No, it can never become non-oscillatory   -  0
Sys_resp_aperiodic=1;

% if yes, with K_d and J fixed, calculate the largest K_p which has a non-oscillatory response
K_p_2=1;


% [Task 4]
% form the closed-loop transfer function using K_p_2

tf_satellite_ol_2=K_p_2*(1/(J*s*(1+K_d/(J*s))))*(1/s);
tf_satellite_cl_2=tf_satellite_ol_2/(1+tf_satellite_ol_2);

% System poles
disp(['System poles with Kp=' num2str(K_p_2)])
disp(pole(tf_satellite_cl_2))


% Numerical value for time domain response using Matlab step command
t=0:0.01:20;

% with K_p=5, use system 'tf_satellite_cl' directly
y_num_cl=step(tf_satellite_cl,t);
    
% with the newly calculated K_p_2, use system 'tf_satellite_cl_2' directly
y_num_cl_2=step(tf_satellite_cl_2,t);


plot(t, y_num_cl, 'Linewidth', 2);hold on
plot( t, y_num_cl_2, 'Linewidth', 2, 'LineStyle', '-.')
ylabel('\theta [rad]', 'fontsize', 14)
xlabel('Time [s]', 'fontsize', 14)
legend(['K_p = ' num2str(K_p)], ['K_p = ' num2str(K_p_2)])
set(gca,'FontSize',13)
grid on
