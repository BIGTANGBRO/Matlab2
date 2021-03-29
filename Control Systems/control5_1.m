%control5_1

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
%% Longitudinal Eigenmotion analysis
[Vs,DDs]=eig(A)

% FOR YOUR OWN VISUALIZATION ONLY, uncomment when needed
figure
pzmap(sys_long, 'r');
title_string = sprintf('Altitude = 10000 ft Velocity = %.2f ft/s', V);
title(title_string);
sgrid;

% [Q2]
% Select short period eigenvalue, compute natural frequency, damping ratio
% and the period of oscillations
lambda=-0.0005-0.0046i;
re = real(lambda);
img = imag(lambda);
omega_n=sqrt(re^2+img^2);
zeta=-re/omega_n;
P=2*pi/img;

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
