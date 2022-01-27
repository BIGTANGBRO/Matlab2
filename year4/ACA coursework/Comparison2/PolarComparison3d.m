%polar between star-ccm+ 3d and avl
clear
clc
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [3, 11];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["VarName1", "Rn", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
Wing24150exppolar = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Comparison2\Wing_24-15-0_exp_polar.dat", opts);

%% Convert to output type
polarEXP = table2array(Wing24150exppolar);

%% Clear temporary variables
clear opts

%polar For AVL
aoaAVL = [-4,0,1,2,3,4,6,8,10,15,18,20,22,24,26];
CLAVL = [-0.12957,0.16661,0.24053,0.31429,0.38785,0.46114,0.60676,0.75072,0.89625,1.23611,1.43271,1.55971,1.68164,1.79989,1.91369];
CDAVL = [0.00628,0.00699,0.00878,0.01122,0.01430,0.01801,0.02730,0.03897,0.05290,0.09648,0.13361,0.19198,0.28707,0.41722,0.57950];

aoa = [0,2,4,6,8,10];
CL = [0.1706, 0.3232, 0.4748, 0.6239, 0.7669, 0.8970];
CD = [0.01319,0.01765, 0.02508, 0.03553, 0.04896, 0.06511];

aoaExp = polarEXP(:,1);
CLExp = polarEXP(:,2);
CDExp = polarEXP(:,3);

yyaxis left
plot(aoa, CL, '-*b');
yyaxis right
plot(aoa, CD, '-*r');
hold on 

yyaxis left
plot(aoaAVL, CLAVL);
yyaxis right
plot(aoaAVL, CDAVL);
hold on

yyaxis left
plot(aoaExp, CLExp);
ylabel("Lift Coefficients");
yyaxis right
plot(aoaExp(1:7), CDExp(1:7));
ylabel("Drag Coefficients");
grid on
xlabel("Angle of Attack/Degrees")
legend("Star-ccm+", "AVL", "Experimental");
title("Comparative Polar");