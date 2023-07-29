clc
clear

addpath("Parameterized methods\");
addpath("curve fitting\");

axes;
axis normal;
axis([0 10 0 10]);
[x,y]=getThePoint();

%% 参数化方法
% t=homogeneousParameterization(x,y); % 均匀参数化
% t=chordLengthParameterization(x,y); % 弦长参数化
% t=centerParameterization(x,y); % 中心参数化
t=foleyParameterization(x,y); % Foley-Nielsen参数化

%% 拟合参数曲线
% axis normal;
% axis([0 10 0 10]);
% scatter(x,y,'blue','filled');hold on;

p1=lagrangeType(x,y,t); % 多项式插值
p2=gaussType(x,y,t); % Gauss基函数插值
p3=RBFType(x,y,t); % RBF神经网络
p4=leastSquaresType(x,y,t); % 最小二乘拟合
p5=cubicSplineType(x,y,t); % 三次自然样条函数

legend([p1 p2 p3 p4 p5],'lagrangeType','gaussType','RBFType','leastSquaresType','cubicSplineType');
