clear
clc

%% 初始化变量。
filename = 'C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\AVL\naca2409_2.dat';
startRow = 13;

%% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
%	列4: 双精度值 (%f)
%   列5: 双精度值 (%f)
%	列6: 双精度值 (%f)
%   列7: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%8f%9f%10f%10f%9f%9f%f%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% 关闭文本文件。
fclose(fileID);
naca24092 = [dataArray{1:end-1}];
%% 清除临时变量
clearvars filename startRow formatSpec fileID dataArray ans;

cl = naca24092(:,2);
cd = naca24092(:,3);
xlabel("Drag coefficient");
ylabel("LiFt coefficient");
plot(cd,cl);
grid on
title("Drag polar for NACA2409");
x = [0.01693,0.00509,0.02178];
y = [-0.9541,0.2529,1.5391];
hold on
p = polyfit(y,x,2);
y1 = linspace(-1.2,1.5,20);
x1 = polyval(p,y1);
plot(x1,y1);
legend("Xfoil data","Fitted curve")