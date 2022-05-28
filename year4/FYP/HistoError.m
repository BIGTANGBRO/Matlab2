%% 从文本文件中导入数据
% 用于从以下文本文件中导入数据的脚本:
%
%    filename: C:\Users\tangj\Downloads\Fyp_Quant_data\sphere_irr_data\coarse\distribution_sphere_error.dat
%
% 由 MATLAB 于 19-May-2022 20:31:07 自动生成

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
distributionsphereerror = readtable("C:\Users\tangj\Downloads\Fyp_Quant_data\sphere_regular_data\333\distribution_sphere_error.dat", opts);

distribution = table2array(distributionsphereerror)./127.*100;
%% 清除临时变量
clear opts

edges = [0:0.5:20];
%histogram(distribution,edges,'FaceColor','#EDB120');
histogram(distribution,edges);

hold on;
avg = sum(distribution)/length(distribution)

avgx = [avg,avg];
avgy = [0,2000];
plot(avgx,avgy);
%set(gca,'XLim',[0 33]);
xlabel("Relative Error to Analytical Expression in Z-Direction/%");
ylabel("Number of vertices");
legend("Distribution of analytical error",'Average value');
grid on