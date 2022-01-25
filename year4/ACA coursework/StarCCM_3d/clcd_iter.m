clear
clc
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Iteration", "LiftCoefficientMonitorLiftCoefficientMonitor"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
cliter = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_3d\cl_iter.csv", opts);

%% Convert to output type
cliter = table2array(cliter);

%% Clear temporary variables
clear opts

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Iteration", "DragCoefficientMonitorDragCoefficientMonitor"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
cditer = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_3d\cd_iter.csv", opts);

%% Convert to output type
cditer = table2array(cditer);

%% Clear temporary variables
clear opts

plot(cditer(:,1),cditer(:,2));
hold on 
plot(cliter(:,1),cliter(:,2));
grid on
title("Lift and Drag coefficients iteration");
xlabel("iteration number");
ylabel("Coefficient");
legend("Lift coefficient","Drag coefficient");