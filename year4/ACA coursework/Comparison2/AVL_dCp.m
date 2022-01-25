clear
clc

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
cp75 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Comparison2\cp75.csv", opts);

%% Convert to output type
cp75 = table2array(cp75);

%% Clear temporary variables
clear opts

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
cp25 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Comparison2\cp25.csv", opts);

%% Convert to output type
cp25 = table2array(cp25);

%% Clear temporary variables
clear opts

%for y/b = 0.25
dcp1 = [0.81566,0.57854,0.40229,0.36828,0.36775,0.37590,0.38094,0.40124,0.38593,0.35266,0.33176,0.31227,0.29205,0.26863,0.24189,0.21217,0.17972,0.14516,0.11607,0.08127];
x1 = [0.03152,0.03331,0.03686,0.04207,0.04883,0.05697,0.06631,0.07663,0.08769,0.09922,0.11096,0.12263,0.13395,0.14467,0.15453,0.16330,0.17077,0.17678,0.18117,0.18384];
figure(1)
plot(x1,dcp1);
hold on
plot(cp25(:,1),cp25(:,2),'-');

%for y/b = 0.75
dcp2 = [1.09390,0.61801,0.44980,0.40831,0.39913,0.40107,0.40563,0.40456,0.39086,0.35015,0.32526,0.30279,0.28078,0.25598,0.22887,0.19912,0.16701,0.13282,0.10034,0.06411];
x2 = [0.09290,0.09419,0.09673,0.10046,0.10531,0.11114,0.11784,0.12523,0.13315,0.14141,0.14983,0.15819,0.16630,0.17398,0.18105,0.18733,0.19269,0.19699,0.20013,0.20205];
figure(2)
plot(x2,dcp2);
hold on
plot(cp75(:,1),cp75(:,2),'-');