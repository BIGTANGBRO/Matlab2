%% 从文本文件中导入数据
% 用于从以下文本文件中导入数据的脚本:
%
%    filename: C:\Users\msipc\Desktop\code\Matlab2\year4\ACA coursework\dataViscid_5_polar.dat
%
% 由 MATLAB 于 2021-11-01 18:21:01 自动生成

%% 设置导入选项并导入数据
clear 
clc

opts = delimitedTextImportOptions("NumVariables", 12);

% 指定范围和分隔符
opts.DataLines = [13, Inf];
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "Var8", "Var9", "Var10", "Var11", "Var12"];
opts.SelectedVariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% 指定变量属性
opts = setvaropts(opts, ["Var8", "Var9", "Var10", "Var11", "Var12"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var8", "Var9", "Var10", "Var11", "Var12"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "VarName1", "TrimNonNumeric", true);
opts = setvaropts(opts, "VarName1", "ThousandsSeparator", ",");

% 导入数据
polarData = readtable("C:\Users\msipc\Desktop\code\Matlab2\year4\ACA coursework\polarData.dat", opts);

%% 转换为输出类型
dataFinal = table2array(polarData);
%% 清除临时变量
clear opts
alpha = dataFinal(:,1);
CL = dataFinal(:,2);
CD = dataFinal(:,3);
lOverD = CL./CD;

figure(1)
plot(alpha, CL);
grid on
figure(2)
plot(CD,CL);
xlabel("CD");
ylabel("CL");
grid on
figure(3)
plot(alpha, lOverD)
grid on


