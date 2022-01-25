clear
clc

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["PlaneSection_025Direction100m", "PlaneSection_025PressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
cp25 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_3d\cp25.csv", opts);

%% Convert to output type
cp25 = table2array(cp25);

%% Clear temporary variables
clear opts

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["PlaneSection_075Direction100m", "PlaneSection_075PressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
cp75 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_3d\cp75.csv", opts);

%% Convert to output type
cp75 = table2array(cp75);

%% Clear temporary variables
clear opts

figure(1)
length = -0.0309 + 0.179;
plot((cp25(:,1)-0.0309)./length, cp25(:,2),"*");
ylim([-0.8 1]);
set(gca, 'YDir','reverse');
xlabel("x/c");
ylabel("Cp");
title("Cp distribution for y/b = 0.25");
grid on

figure(2)
length2 = 0.1983 - 0.0925;
plot((cp75(:,1)-0.0925)./length2, cp75(:,2),"*");
ylim([-0.8 1]);
set(gca, 'YDir','reverse');
xlabel("x/c");
ylabel("Cp");
title("Cp distribution for y/b = 0.75");
grid on
