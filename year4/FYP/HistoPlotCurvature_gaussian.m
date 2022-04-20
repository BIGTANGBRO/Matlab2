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
distribution1 = readtable("C:\Users\tangj\Downloads\CowData\123\distribution_curvature_gaussian.dat", opts);
distribution2 = readtable("C:\Users\tangj\Downloads\CowData\132\distribution_curvature_gaussian.dat", opts);
distribution3 = readtable("C:\Users\tangj\Downloads\CowData\213\distribution_curvature_gaussian.dat", opts);
distribution4 = readtable("C:\Users\tangj\Downloads\CowData\231\distribution_curvature_gaussian.dat", opts);
distribution5 = readtable("C:\Users\tangj\Downloads\CowData\312\distribution_curvature_gaussian.dat", opts);
distribution6 = readtable("C:\Users\tangj\Downloads\CowData\321\distribution_curvature_gaussian.dat", opts);

% distribution1 = readtable("C:\Users\tangj\Downloads\CowData\12\distribution_curvature_gaussian.dat", opts);
% distribution2 = readtable("C:\Users\tangj\Downloads\CowData\13\distribution_curvature_gaussian.dat", opts);
% distribution3 = readtable("C:\Users\tangj\Downloads\CowData\23\distribution_curvature_gaussian.dat", opts);
% distribution4 = readtable("C:\Users\tangj\Downloads\CowData\21\distribution_curvature_gaussian.dat", opts);
% distribution5 = readtable("C:\Users\tangj\Downloads\CowData\31\distribution_curvature_gaussian.dat", opts);
% distribution6 = readtable("C:\Users\tangj\Downloads\CowData\32\distribution_curvature_gaussian.dat", opts);

distribution1 = readtable("C:\Users\tangj\Downloads\CowData\G1\distribution_curvature_gaussian.dat", opts);
distribution2 = readtable("C:\Users\tangj\Downloads\CowData\G2\distribution_curvature_gaussian.dat", opts);
distribution3 = readtable("C:\Users\tangj\Downloads\CowData\G3\distribution_curvature_gaussian.dat", opts);
distribution4 = readtable("C:\Users\tangj\Downloads\CowData\11\distribution_curvature_gaussian.dat", opts);
distribution5 = readtable("C:\Users\tangj\Downloads\CowData\22\distribution_curvature_gaussian.dat", opts);
distribution6 = readtable("C:\Users\tangj\Downloads\CowData\33\distribution_curvature_gaussian.dat", opts);
%% Convert to output type
distribution1 = table2array(distribution1);
distribution2 = table2array(distribution2);
distribution3 = table2array(distribution3);
distribution4 = table2array(distribution4);
distribution5 = table2array(distribution5);
distribution6 = table2array(distribution6);


%% Clear temporary variables
clear opts

histogram(distribution1);
hold on
histogram(distribution2);
hold on
histogram(distribution3);
hold on
histogram(distribution4);
hold on
histogram(distribution5);
hold on
histogram(distribution6);
%legend("123","132","213","231", "312","321");
%legend("12","13","23","21","31","32");
legend("G1","G2","G3","11","22","33");


xlabel("Gaussian Curvature")
ylabel("Number of vertices")

grid on