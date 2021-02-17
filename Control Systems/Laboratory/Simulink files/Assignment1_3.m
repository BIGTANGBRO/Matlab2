%assignment 1-3
% [Q1] 
% Use your work from live script and generate the linearised helicopter model linearised around zero, note the changes in system dimension
Ai=[0 0	0 1	0 0 0 0;0 0 0 0 1 0 0 0;0 0 0 0 0 1 0 0;0 0 0 0	0 0 0 0;0 0 0 0	0 0 0 0;0 -0.3812 0	0 0	0 0 0;1 0 0 0 0 0 0 0;0 0 1 0 0 0 0 0];
Bi=[0 0;0 0;0 0;0.0788 0.0788;0.5108 -0.5108;0 0;0 0;0 0];

% [Q2]
% LQR-PID Controller design (default)
Q = diag([100 1 10 0 0 2 10 0.1]);
R = diag([0.05 0.05]);
% Calculate the LQR controller gain
K = lqr(Ai,Bi,Q,R);

% Display the calculated gains
disp( 'Calculated LQR controller gain elements (default): ' )
K 

% [Q3a/b]
% LQR-PID Controller design (slight improvement)
Q_si = diag([100 50 10 0 0 2 10 0.1]);
R_si = diag([0.05 0.05]);
% Calculate the LQR controller gain
K_si=lqr(Ai,Bi,Q_si,R_si);

% LQR-PID Controller design (best elevation)
Q_be = diag([400 50 10 0 0 2 5 0.1]);
R_be = diag([0.05 0.05]);
% Calculate the LQR controller gain
K_be = lqr(Ai,Bi,Q_be,R_be);
    
% LQR-PID Controller design (best travel)
Q_bt = diag([100 50 600 0 0 2 10 0.5]);
R_bt = diag([0.05 0.05]);
% Calculate the LQR controller gain
K_bt = lqr(Ai,Bi,Q_bt,R_bt);
    
% LQR-PID Controller design (best overall)
Q_bo = diag([400 50 600 0 0 2 5 0.5]);
R_bo = diag([0.05 0.05]);
% Calculate the LQR controller gain
K_bo = lqr(Ai,Bi,Q_bo,R_bo);

% Display the calculated gains
disp( ' ' )
disp( 'Calculated LQR controller gain elements (slight improvement): ' )
K_si
disp( ' ' )
disp( 'Calculated LQR controller gain elements (best elevation): ' )
K_be
disp( ' ' )
disp( 'Calculated LQR controller gain elements (best travel): ' )
K_bt
disp( ' ' )
disp( 'Calculated LQR controller gain elements (best overall): ' )
K_bo
