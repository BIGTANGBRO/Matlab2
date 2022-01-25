%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
CpN1 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_2d\CpN1.csv", opts);
clear opts
%% Convert to output type
CpN1 = table2array(CpN1);
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
CpN05 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_2d\CpN_05.csv", opts);

%% Convert to output type
CpN05 = table2array(CpN05);

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
CpN02 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_2d\CpN_02.csv", opts);

%% Convert to output type
CpN02 = table2array(CpN02);

%% Clear temporary variables
clear opts

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
CpN01 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_2d\CpN_01.csv", opts);

%% Convert to output type
CpN01 = table2array(CpN01);

%% Clear temporary variables
clear opts

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
CpN001 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_2d\CpN_001.csv", opts);

%% Convert to output type
CpN001 = table2array(CpN001);

%% Clear temporary variables
clear opts

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
CpN0005 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\StarCCM_2d\CpN_0005.csv", opts);

%% Convert to output type
CpN0005 = table2array(CpN0005);

%% Clear temporary variables
clear opts

plot(CpN1(:,1),-CpN1(:,2),"o");
hold on
plot(CpN05(:,1),-CpN05(:,2),"*");
hold on
plot(CpN02(:,1),-CpN02(:,2),".");
hold on
plot(CpN01(:,1),-CpN01(:,2),"o");
hold on
plot(CpN001(:,1),-CpN001(:,2),"*");
hold on
plot(CpN0005(:,1),-CpN0005(:,2),".");
hold off
grid on
ylabel("-Cp");
xlabel("x/c");
legend("1m","0.5m","0.2m","0.1m","0.01m","0.005m");
