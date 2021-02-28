%State-space model
A=[-0.231308504369119,0.0544096693079551,-0.000124548233093912,-0.990288665751696;0,0,1,0;-21.9913440608126,0,-4.27507057923922,1.16034911016267;11.8852437044909,0,-0.450303860814642,-0.711734908447950];
B=[-0.0109680172306510,0.0630660990762435;0,0;-32.2767539463422,5.44547987525456;-2.63365317966200,-7.15884612728451];
C=eye(4);
D=zeros(4,1);

%parameters
% this is the cruise speed (TAS)
V = 180;
g0 = 9.81;


%% Open-loop response
% Check the eigenvalues. Note the bad damping of the Dutch roll and
% spiral modes
eigA = eig(A)

% Aileron control only. 
Ba = B(:,1);

% Create state-space system (open loop system, only aileron control), generate simulation output for a step input on
% the aileron
%make the system for the aileron
sa = ss(A, Ba, C, D);
t = 0:0.02:10;
u=ones(1,length(t)); %input
%simulation output
yo = lsim(sa,u,t);


% For generation of figures
figure(1)
subplot(3, 2, 1)
plot(t, yo(:,3));hold on;grid on
xlabel('Time [s]')
title('Roll rate')  
ylabel('p [rad/s]')
 
subplot(3, 2, 2)
plot(t, yo(:,4));hold on;grid on
xlabel('Time [s]')
title('Yaw rate')  
ylabel('r [rad/s]')

subplot(3, 2, 3:4)
plot(t, rad2deg(yo(:,2)));hold on;grid on
set(gca,'XTickLabel',[])
title('Roll angle')  
ylabel('\phi [deg]')

subplot(3, 2, 5:6)
plot(t, rad2deg(yo(:,1)));hold on;grid on
xlabel('Time [s]')
title('Sideslip angle')  
ylabel('\beta [deg]')


%% Closed-loop design
% LQR criterion: weight on beta, phi, p and r errors and on aileron
Q = diag([1 1 0.01 0.01]); R = 1;

% Generate feedback gains using lqr command
K = lqr(sa,Q,R)

% check the eigenvalues of the closed-loop system. Note that the bad
% damping of the Dutch roll is still in there (it cannot be removed with
% aileron control!)
Ac = A-Ba*K;
eigAc = eig(Ac);

% create a closed-loop system, unity feedback, the four states to their
% respective inputs of the control matrix K
%feedback system
sc =  feedback(sa*K,eye(4));

% Take a look at this closed-loop system. The four inputs are
% references for the states (beta, phi, p, r), the four outputs are the
% realised states
sc
Cc1 = [C;-K];
Dc1 = [zeros(4);K];
Bc = Ba*K; 
% Remember that u = \delta_a = K (xref - x)
% Thus, we can augment the output of the system with the aileron input also as an output. Formulate the augmented system here.
sc1 = ss(Ac,Bc,Cc1,Dc1);
% 
% sc1 = ss(Ac,Bc,C,zeros(4));

% Recall from the flight mechanics course, for constant sideslip angle in a level flight turn, the following relationship can be obtained using kinematics.
%       \phi(roll angle) * g0(gravitational acceleration)     =(approximately)       V (true airspeed)*r (yaw rate)
% Therefore, when turning sc1 into a single input (desired roll angle) system, the corresponding yaw rate must be supplied also. 
% In this way, the closed-loop system sc2 will only have one input: the desired roll angle
sc2 = sc1 * [0 1 0 g0/V]';

% check the system behaviour when the commanded roll angle has a step input
% of 45 deg.
t = 0:0.02:10;
u= deg2rad(45*ones(1,length(t)));
yc = lsim(sc2,u,t);


% For generation of figures
figure
subplot(4, 2, 1)
plot(t, yc(:,3));hold on;grid on
xlabel('Time [s]')
title('Roll rate')  
ylabel('p [rad/s]')
 
subplot(4, 2, 2)
plot(t, yc(:,4));hold on;grid on
xlabel('Time [s]')
title('Yaw rate')  
ylabel('r [rad/s]')

subplot(4, 2, 3:4)
plot(t, rad2deg(yc(:,2)));hold on;grid on
set(gca,'XTickLabel',[])
title('Roll angle')  
ylabel('\phi [deg]')

subplot(4, 2, 5:6)
plot(t, rad2deg(yc(:,1)));hold on;grid on
set(gca,'XTickLabel',[])
title('Sideslip angle')  
ylabel('\beta [deg]')

subplot(4, 2, 7:8)
plot(t, rad2deg(yc(:,5)));hold on;grid on
xlabel('Time [s]')
title('Aileron Deflection')  
ylabel('\delta_a [deg]')
