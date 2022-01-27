%% 初始化变量。
filename = 'C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\AVL\aoa2.dat';
startRow = 17;
endRow = 116;

%% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
%	列4: 双精度值 (%f)
%   列5: 双精度值 (%f)
%	列6: 双精度值 (%f)
%   列7: 双精度值 (%f)
%	列8: 双精度值 (%f)
%   列9: 双精度值 (%f)
%	列10: 双精度值 (%f)
%   列11: 双精度值 (%f)
%	列12: 双精度值 (%f)
%   列13: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%6f%9f%9f%9f%9f%9f%9f%9f%9f%9f%9f%9f%f%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% 关闭文本文件。
fclose(fileID);

%% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的单元格，然后重新生成脚本。

%% 创建输出变量
aoa2 = [dataArray{1:end-1}];
%% 清除临时变量
clearvars filename startRow endRow formatSpec fileID dataArray ans;
CL = aoa2(:,8);
lift = aoa2(:,13);
y = aoa2(:,2);
c = aoa2(:,3);
cRef = 0.1317;
plot(y/0.381,CL);
hold on
plot(y/0.381,CL.*c./cRef);
grid on
hold off
xlabel("y/b");
ylabel("CL & CL c/cRef");
title("Lift distribution");
legend("Lift distribution", "Sectional Lift");