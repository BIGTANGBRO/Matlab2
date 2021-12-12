filename = 'C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\curve2415.dat';
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

%% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的单元格，然后重新生成脚本。

%% 创建输出变量
curve2415 = [dataArray{1:end-1}];
%% 清除临时变量
clearvars filename startRow formatSpec fileID dataArray ans;
CL = curve2415(:,2);
CD = curve2415(:,3);
plot(CD, CL);
hold on
x = [0.0183,0.00607,0.01299];
y = [-1.3877,0.143,1.3635];
plot(x,y);
xlabel("Drag coefficient");
ylabel("List coefficient");
grid on
title("Drag polar for NACA2415");
legend("Xfoil data","AVL use data")