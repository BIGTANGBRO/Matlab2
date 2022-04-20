
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
distribution1 = readtable("C:\Users\tangj\Downloads\sphereData\22\distribution_curvature_gaussian.dat", opts);

%% Convert to output type
distribution1 = table2array(distribution1);

%% Clear temporary variables
clear opts

histogram(distribution1);
xlabel("Angle");
title("Histogram of the gaussain curvature")
ylabel("Number of vertices");
grid on