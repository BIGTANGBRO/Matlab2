clear
clc
%% 设置导入选项并导入数据
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
Wing24150exppolar = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\AVL\Wing_24-15-0_exp_polar.dat", opts);

%% 转换为输出类型
exp = table2array(Wing24150exppolar);

%% 清除临时变量
clear opts

%polar For AVL
aoa = [-4,0,1,2,3,4,6,8,10,15,18,20,22,24,26];
CL = [-0.12957,0.16661,0.24053,0.31429,0.38785,0.46114,0.60676,0.75072,0.89625,1.23611,1.43271,1.55971,1.68164,1.79989,1.91369];
CD = [0.00628,0.00699,0.00878,0.01122,0.01430,0.01801,0.02730,0.03897,0.05290,0.09648,0.13361,0.19198,0.28707,0.41722,0.57950];

CLexp = exp(:,2);
CDexp = exp(:,3);
aoaexp = exp(:,1);
figure(1)
plot(aoa(2:9),CL(2:9)./CD(2:9));
hold on
plot(aoaexp,CLexp./CDexp);
grid on
xlabel("Angle of attack/Degrees");
ylabel("L/D");
title("L/D vs AoA");
legend("AVL results", "Experimental results");

figure(2)
plot(CD,CL);
hold on;
plot(CDexp,CLexp);
grid on
title("Wing polar curve");
xlabel("CD");
ylabel("CL");
legend("AVL results","Experimental results");