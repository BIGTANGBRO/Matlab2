%solution for control 4_1
% Governing differential equation
% x_dot=k_v*V/A;

% Parameters
k_v=0.5;
A=0.02;


% [Task 1]
% Open-loop transfer function
s=tf('s');
tf_actuator=(k_v/A)*(1/s);


% [Task 2]
% Closed-loop transfer function when K=1.25
K=1.25;
tf_servo=K/(1/tf_actuator + K);



% [Task 3]
% Closed-loop system pole when K=1.25
lambda=-31.25;



% [Task 4]
% Root Locus
rlocus(tf_servo,0:0.1:2)

% From the root locus, do you expect the system response to be oscillatory
% for certain values of K?
% Yes, it can become oscillatory - 1
% No, it can never become oscillatory - 0
Sys_resp_periodic = 0;



% [Task 5]
% Expression for time domain response
syms t
y(t)= 1 - exp(-(125*t)/4);



% [Task 6]
% Numerical value for time domain response from expression
t=0:0.01:0.5;
y_num=double(y(t));

% Numerical value for time domain  reponse using Matlab step command, use t as the time vector
y_num_s=step(tf_servo,t);

figure 
plot(t, y_num, 'Linewidth', 2)
hold on
plot( t, y_num_s, 'Linewidth', 2, 'LineStyle', '-.')
ylabel('Servo valve displacement x [m]', 'fontsize', 14)
xlabel('Time [s]', 'fontsize', 14)
legend('From expression','From Matlab step function')
set(gca,'FontSize',13)
grid on
