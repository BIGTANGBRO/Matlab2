%% 设置导入选项并导入数据
clc
clear
opts = delimitedTextImportOptions("NumVariables", 1);

% 指定范围和分隔符
opts.DataLines = [1, Inf];
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = "VarName1";
opts.VariableTypes = "double";

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
distribution1 = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\Sphere_regular_data\stl_sphere\distribution_sphere_error.dat", opts);

distribution1 = table2array(distribution1);

error1 = abs(distribution1-127)./127.*100;

%% 清除临时变量
clear opts

edges = [0:0.05:2.5];
%'FaceColor','#EDB120'
histogram(error1,edges,'FaceColor');
hold on

avg = sum(error1)/length(error1)

avgx = [avg,avg];
avgy = [0,9000];
plot(avgx,avgy);
xlabel("Relative Error to Analytical Expression in Z-Direction/%");
ylabel("Number of vertices");
legend("Distribution of relative error", "Average value");
grid on