% [Q1] 
% Use your work from live script and generate the linearised helicopter model linearised around zero, note the changes in system dimension
%Ai and Bi from live script(Feedback_ctrl_pseudo_helo.mlx)
clear;
clc;
Ai=...
Bi=...

% [Q2]
% LQR-PID Controller design (default)
Q = diag([100,1,10,0,0,2,10,0.1]);
R = diag([0.05,0.05]);
% Calculate the LQR controller gain
K = lqr(Ai,Bi,Q,R);

% Display the calculated gains
disp( 'Calculated LQR controller gain elements (default): ' )
K 

% [Q3a/b]
% LQR-PID Controller design (slight improvement)
Q_si = ...
R_si = ...
% Calculate the LQR controller gain
K_si = ...

% LQR-PID Controller design (best elevation)
Q_be = ...
R_be = ...
% Calculate the LQR controller gain
K_be = ...
    
% LQR-PID Controller design (best travel)
Q_bt = ...
R_bt = ...
% Calculate the LQR controller gain
K_bt = ...
    
% LQR-PID Controller design (best overall)
Q_bo = ...
R_bo = ...
% Calculate the LQR controller gain
K_bo = ...

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
