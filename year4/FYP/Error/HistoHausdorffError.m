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

% Import the data2
distribution1 = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\sphere_Regular_data\111\distribution_hausorff1.dat", opts);
distribution2 = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\sphere_Regular_data\222\distribution_hausorff1.dat", opts);
distribution3 = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\sphere_Regular_data\333\distribution_hausorff1.dat", opts);
%distribution4 = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\sphere_Irr_data\coarse\distribution_hausorff1.dat", opts);

%% Convert to output type
distribution1 = table2array(distribution1);
distribution2 = table2array(distribution2);
distribution3 = table2array(distribution3);
%distribution4 = table2array(distribution4);

%% Clear temporary variables
clear opts

avg1 = sum(distribution1)./length(distribution1)
avg2 = sum(distribution2)./length(distribution2)
avg3 = sum(distribution3)./length(distribution3)

max1 = max(distribution1)
max2 = max(distribution2)
max3 = max(distribution3)

histogram(distribution1);
hold on
histogram(distribution2);
hold on
histogram(distribution3);

xlabel("Hausorff Error/mm");
ylabel("Number of vertices");
legend("Loop","Modified Butterfly","$\sqrt{3}$");
grid on