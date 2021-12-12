%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "CDMonitorCDMonitor"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
CDiter = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\CD_iter.csv", opts);

%% 转换为输出类型
CDiter = table2array(CDiter);

%% 清除临时变量
clear opts

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "CLMonitorCLMonitor"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
CLiter = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\CL_iter.csv", opts);

%% 转换为输出类型
CLiter = table2array(CLiter);

%% 清除临时变量
clear opts

plot(CDiter(1:1300,1),CDiter(1:1300,2));
hold on
plot(CLiter(1:1300,1),CLiter(1:1300,2));
hold off
grid on
xlabel("Iteration");
ylabel("Coefficient");
legend("Lift coefficient","Drag coefficient");
title("Lift and Drag coefficients iteration");