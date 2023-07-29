clear
clc

addpath('CT image reconstruction\');
addpath('image quality assessment\');

% 读入图像
% theta = linspace(0,179,i);
theta=0:1:179;
I = phantom('Modified Shepp-Logan', 512);
% I=ones(512);
figure, subplot(121), imshow(I, []);

% 对图像进行扫描
[R, xp] = radon(I, theta);

% L=iradon(R,[0:179],"nearest","Ram-Lak",1,512);
% figure(2),imshow(L,[]);
%% 调用图像重建算法
% im = back_projection(R, 512, 512, theta); % 反投影法
% im = iteration(R, 512, 512, theta, 1000, 1.72); % 迭代法
% im = filter_back_projection(R, 512, 512, theta); % 滤波反投影法
% im = ml_em(R, 512, 512, theta, 100); % 最大期望极大似然算法(仍有问题，需要调试)
% im = fista(R, 512, 512, theta, 100, 10); % 快速迭代收缩阈值法
im = my_ridge(R, 512, 512, theta, 100, 0.001, 0.1); % 基于岭回归的梯度下降法

subplot(122), imshow(im, []);
% print(gcf,'myr_30','-depsc');


