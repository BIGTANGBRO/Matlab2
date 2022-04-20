clear
clc
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 1);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = "VarName1";
opts.VariableTypes = "double";

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
distribution1 = readtable("C:\Users\tangj\Downloads\CowData\111\distributionAngle.dat", opts);
distribution2 = readtable("C:\Users\tangj\Downloads\CowData\222\distributionAngle.dat", opts);
distribution3 = readtable("C:\Users\tangj\Downloads\CowData\333\distributionAngle.dat", opts);
%% Convert to output type
distribution1 = table2array(distribution1);
distribution2 = table2array(distribution2);
distribution3 = table2array(distribution3);

%% Clear temporary variables
clear opts

histogram(distribution1);
hold on
histogram(distribution2);
hold on
histogram(distribution3);
legend("111","222","333");

xlabel("Angle")
ylabel("Number of edges")
grid on