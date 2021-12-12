%% 初始化变量。
filename = 'C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\data_Inviscid.dat';
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
dataInviscid = [dataArray{1:end-1}];
%% 清除临时变量
clearvars filename startRow formatSpec fileID dataArray ans;

%% 初始化变量。
filename = 'C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\data_Viscid5_1.dat';
startRow = 2;

%% 每个文本行的格式:
%   列1: 双精度值 (%f)
%	列2: 双精度值 (%f)
%   列3: 双精度值 (%f)
%	列4: 双精度值 (%f)
%   列5: 双精度值 (%f)
%	列6: 双精度值 (%f)
%   列7: 双精度值 (%f)
%	列8: 双精度值 (%f)
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = '%10f%9f%9f%9f%10f%10f%10f%f%[^\n\r]';

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
dataViscid1 = [dataArray{1:end-1}];
%% 清除临时变量
clearvars filename startRow formatSpec fileID dataArray ans;

%% 初始化变量。
filename = 'C:\Users\tangj\Desktop\Code\Matlab2\year4\ACA coursework\data_Viscid5_2.dat';
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
dataViscid2 = [dataArray{1:end-1}];
%% 清除临时变量
clearvars filename startRow formatSpec fileID dataArray ans;

xIn = dataInviscid(:,1);
cpIn = dataInviscid(:,3);


x = dataViscid1(:,2);
cf = dataViscid1(:,7);
delta = dataViscid1(:,5);
theta = dataViscid1(:,6);
cp = dataViscid2(:,3);
x2 = dataViscid2(:,1);


figure(1)
plot(x2,-cp);
hold on
plot(xIn,-cpIn);
xlabel("x/c");
ylabel("-Cp");
title("Pressure coefficient over normalized X");
legend("Viscous for Re = 1E5", "Inviscid flow");
hold off
grid on

figure(2)
plot(x(1:350),cf(1:350));
xlabel("x/c");
ylabel("Cf");
title("Skin friction over normalized X(Re = 1E5)");
grid on

figure(3)
plot(x(1:350),delta(1:350));
hold on
plot(x(1:350),theta(1:350));
xlabel("x/c");
ylabel("Thickness")
legend("Delta", "Theta");
title("Displacement and momentum thickness over normalized X(Re = 1E5)");
grid on

