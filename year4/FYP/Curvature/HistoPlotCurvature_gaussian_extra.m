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
distribution1 = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\Cow_data\333\distribution_curvature_gaussian_extraordinary.dat", opts);

%% Convert to output type
distribution1 = table2array(distribution1);

sumAvg = 0;
count = 0;
for i = 1:length(distribution1)
    if (distribution1(i) < 500 && distribution1(i) > -500)
        sumAvg = sumAvg + abs(distribution1(i));
        count = count + 1;
    end
end
avg = sumAvg/count

%% Clear temporary variables
clear opts

edges = [-500:7.5:500];
histogram(distribution1, edges);
%set(gca,'XLim',[-1800 1800]);

xlabel("Gaussian Curvature")
ylabel("Number of vertices")

grid on