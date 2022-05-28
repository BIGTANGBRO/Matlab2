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
distribution1 = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\Cow_data\333\distributionAngleEdge.dat", opts);

%% Convert to output type
distribution1 = table2array(distribution1);
avg = sum(distribution1)/length(distribution1)

%% Clear temporary variables
clear opts

edges = [120:0.5:180];
histogram(distribution1,edges);
%set(gca,'XLim',[80 180]);
xlabel("Angle/Degrees")
ylabel("Number of edges")
grid on