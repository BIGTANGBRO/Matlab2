clear
clc

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "VarName2"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% 导入数据
distributioncurvatureprincipal = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\Cow_data\111\distribution_curvature_principal.dat", opts);

%% 转换为输出类型
distributioncurvatureprincipal = table2array(distributioncurvatureprincipal);
%% 清除临时变量
clear opts

k1 = distributioncurvatureprincipal(:,1);
k2 = distributioncurvatureprincipal(:,2);

histogram(k1);
set(gca,'XLim',[0 160]);
