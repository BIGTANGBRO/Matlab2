%% 设置导入选项并导入数据
clear
clc

opts = delimitedTextImportOptions("NumVariables", 3);

% 指定范围和分隔符
opts.DataLines = [3, Inf];
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "Rn", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% 导入数据
NACA2415exppolar = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\Xfoil\NACA-2415_exp_polar.dat", opts);

%% 转换为输出类型
data_experimental = table2array(NACA2415exppolar);

%% 清除临时变量
clear opts

aoa = data_experimental(:,1);
cl = data_experimental(:,2);
cd = data_experimental(:,3);

figure(1)
plot(aoa, cl);
xlabel("AoA");
ylabel("Cl");
title("Experimental values");
grid on
figure(2)
plot(aoa,cd);
xlabel("AoA");
ylabel("Cd");
title("Experimental values");
grid on
figure(3)
plot(aoa,cl./cd);
xlabel("AoA");
ylabel("L/D");
title("Experimental values");
grid on