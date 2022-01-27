%data for plotting L/D over aoa
opts = delimitedTextImportOptions("NumVariables", 12);

% Specify range and delimiter
opts.DataLines = [13, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "Var8", "Var9", "Var10", "Var11", "Var12"];
opts.SelectedVariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, ["Var8", "Var9", "Var10", "Var11", "Var12"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var8", "Var9", "Var10", "Var11", "Var12"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "VarName1", "TrimNonNumeric", true);
opts = setvaropts(opts, "VarName1", "ThousandsSeparator", ",");

% Import the data
polar1 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Comparison1\polar1.dat", opts);
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [3, 16];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["VarName1", "Rn", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Import the data
exppolar = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Comparison1\NACA-2415_exp_polar.dat", opts);


%% Clear temporary variables
clear opts
%% Convert to output type
polar1 = table2array(polar1);
exppolar = table2array(exppolar);
%% Clear temporary variables
clear opts

%% star ccm+
aoaT1 = [0,3,6,9,12,14,16];
CLT1 = [0.2165, 0.5374, 0.8402, 1.0993, 1.2313, 1.1823, 1.0536];
CDT1 = [0.01515, 0.01671, 0.02043, 0.02791, 0.04499, 0.07063, 0.1121];
yyaxis left
plot(aoaT1, CLT1,'-ok');
yyaxis right
plot(aoaT1,CDT1, '-ob');
hold on

%% star ccm+ sparlart-allmaras
aoaT2 = [0,3,6,9,12,14,16];
CLT2 = [0.2273, 0.5544, 0.8652, 1.1387, 1.3167, 1.3016, 1.1907];
CDT2 = [0.01604, 0.01755, 0.0212, 0.02811, 0.04237, 0.06346, 0.1024];
yyaxis left
plot(aoaT2, CLT2,'k');
yyaxis right
plot(aoaT2, CDT2, 'b');
hold on

%% Experimental
aoaExp = exppolar(:,1);
CLExp = exppolar(:,2);
CDExp = exppolar(:,3);
yyaxis left
plot(aoaExp, CLExp, "-*k");
yyaxis right
plot(aoaExp(1:8), CDExp(1:8), '-*b');
hold on

%% xFoil
aoa = polar1(:,1);
CL = polar1(:,2);
CD = polar1(:,3);
yyaxis left
plot(aoa, CL, 'k');
ylabel("Lift Coefficients");
yyaxis right
plot(aoa,CD,'b');
ylabel("Drag Coefficients");

grid on
xlabel("Angle of Attack/Degrees");
legend("Star-ccm+ K-omega SST", "Star-ccm+ Spalart-Allmaras", "Experimental", "xFoil");
title("Comparative Polar");