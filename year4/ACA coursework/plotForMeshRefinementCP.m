%% 从文本文件中导入数据
% 用于从以下文本文件中导入数据的脚本:
%
%    filename: C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\cpForN0.01.csv
%
% 由 MATLAB 于 2021-12-11 17:51:14 自动生成

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
cpForN01 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\cpForN0.01.csv", opts);

%% 转换为输出类型
cpForN01 = table2array(cpForN01);

%% 清除临时变量
clear opts

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
cpForN001 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\cpForN0.01.csv", opts);

%% 转换为输出类型
cpForN001 = table2array(cpForN001);

%% 清除临时变量
clear opts
%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
cpForN1 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\cpForN1.csv", opts);

%% 转换为输出类型
cpForN1 = table2array(cpForN1);

%% 清除临时变量
clear opts
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
cpForN05 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\cpForN0.5.csv", opts);

%% 转换为输出类型
cpForN05 = table2array(cpForN05);

%% 清除临时变量
clear opts

opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
cpForN02 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\cpForN0.2.csv", opts);

%% 转换为输出类型
cpForN02 = table2array(cpForN02);

%% 清除临时变量
clear opts
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["airfoilDefaultDirection100m", "airfoilDefaultPressureCoefficient"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
cpForN0005 = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\cpForN0.005.csv", opts);

%% 转换为输出类型
cpForN0005 = table2array(cpForN0005);

%% 清除临时变量
clear opts

plot(cpForN1(:,1),cpForN1(:,2),"o");
hold on
plot(cpForN05(:,1),cpForN05(:,2),"*");
hold on
plot(cpForN02(:,1),cpForN02(:,2),".");
hold on
plot(cpForN01(:,1),cpForN01(:,2),"o");
hold on
plot(cpForN001(:,1),cpForN001(:,2),"*");
hold on
plot(cpForN0005(:,1),cpForN0005(:,2),".");
hold off
grid on
ylabel("Cp");
xlabel("x/c");
legend("1m","0.5m","0.2m","0.1m","0.01m","0.005m");