Br%State-space model
A=[-0.231308504369119,0.0544096693079551,-0.000124548233093912,-0.990288665751696;0,0,1,0;-21.9913440608126,0,-4.27507057923922,1.16034911016267;11.8852437044909,0,-0.450303860814642,-0.711734908447950];
B=[-0.0109680172306510,0.0630660990762435;0,0;-32.2767539463422,5.44547987525456;-2.63365317966200,-7.15884612728451];
C=eye(4);
D=zeros(4,1);

% this is the cruise speed (TAS)
V = 180;
g0 = 9.813;

% Rudder control only. 
Br = B(:,2);

% Generate feedback gains with LQR
Q = diag([1 1 0.01 1]); R = 1;
[K, P] = lqr(A,Br,Q,R);

% check the eigenvalues of the closed-loop system. Note that the dutch roll mode is now perfectly damped
Ac=A-Br*K;
eigAc = eig(Ac)
Brc=Br*K;
% closed-loop system response, follow the same precedure as in problem 1
t = 0:0.02:10;
s0 = ss(A, Br, eye(4,4), zeros(4,1));
sc =  feedback(s0*K,eye(4)); %use feedback command
Ccl=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1;-K];
Dcl=[0 0 0 0;0 0 0 0;0 0 0 0;0 0 0 0;K];
sc1 = ss(Ac,Brc,Ccl,Dcl); %add rudder deflection to output
sc2 = sc1 * [0 1 0 g0/V]'; % single input: desired roll angle
u= deg2rad(45*ones(1,length(t)));
y = lsim(sc2,u,t);

% For generation of figures
figure
subplot(4, 2, 1)
plot(t, y(:,3));hold on;grid on
xlabel('Time [s]')
title('Roll rate')  
ylabel('p [rad/s]')
 
subplot(4, 2, 2)
plot(t, y(:,4));hold on;grid on
xlabel('Time [s]')
title('Yaw rate')  
ylabel('r [rad/s]')

subplot(4, 2, 3:4)
plot(t, rad2deg(y(:,2)));hold on;grid on
set(gca,'XTickLabel',[])
title('Roll angle')  
ylabel('\phi [deg]')

subplot(4, 2, 5:6)
plot(t, rad2deg(y(:,1)));hold on;grid on
set(gca,'XTickLabel',[])
title('Sideslip angle')  
ylabel('\beta [deg]')

subplot(4, 2, 7:8)
plot(t, rad2deg(y(:,5)));hold on;grid on
xlabel('Time [s]')
title('Rudder Deflection')  
ylabel('\delta_r [deg]')