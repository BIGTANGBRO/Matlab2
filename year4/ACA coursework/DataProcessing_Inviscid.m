%% 初始化变量。
filename = 'C:\Users\msipc\Desktop\code\Matlab2\year4\ACA coursework\data_Inviscid.dat';
startRow = 4;

%% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%10f%9f%f%[^\n\r]';

%% 打开文本文件。
fileID = fopen(filename,'r');

%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% 关闭文本文件。
fclose(fileID);

%% 对无法导入的数据进行的后处理。
% 在导入过程中未应用无法导入的数据的规则，因此不包括后处理代码。要生成适用于无法导入的数据的代码，请在文件中选择无法导入的元胞，然后重新生成脚本。

%% 创建输出变量
data = [dataArray{1:end-1}];
%% 清除临时变量
clearvars filename startRow formatSpec fileID dataArray ans;

%% for inviscid flow
x = data(:,1);
cp = data(:,3);
plot(x,-cp);
title("Inviscid flow at M = 0.3")
xlabel("x/c");
ylabel("cp");
grid on
