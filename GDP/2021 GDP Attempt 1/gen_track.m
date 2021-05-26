function [] = gen_track()
% Inputs: None
% Outputs: Figure

% Inner boundary
data1 = importdata('Sector1_in.txt');
data2 = importdata('Sector2_in.txt');
data3 = importdata('Sector3_in.txt');

fig = figure();
set(gcf, 'Visible', 'on') % External figure
fig.WindowState = 'maximized';
% figure('units','normalized','outerposition',[0 0 1 1]) % Full screen


subplot(2, 4, [1 5])
% s1.Position = s1.Position + [0 -0.5 0 1];
s1 = plot(data1(:,2),data1(:,1),'b-'); hold on;
s2 = plot(data2(:,2),data2(:,1),'r-');
s3 = plot(data3(:,2),data3(:,1),'g-');
set(gcf,'Position',[400 400 400 500])

% Outer boundary
data1 = importdata('Sector1_out.txt');
data2 = importdata('Sector2_out.txt');
data3 = importdata('Sector3_out.txt');

plot(data1(:,2),data1(:,1),'b-'); hold on;
plot(data2(:,2),data2(:,1),'r-')
plot(data3(:,2),data3(:,1),'g-')

% Graph settings
title('2D track layout'); grid on;
xlabel('Longitude'); ylabel('Latitude')
xlim([-0.4705 -0.467]); ylim([51.3485 51.3545])
pbaspect([1 1.5857 1])
% leg = legend([s1 s2 s3], 'Sector 1', 'Sector 2', 'Sector 3', 'location','northwest','FontSize',6);
hold on;
end

