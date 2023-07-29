function imret = blendImagePoisson(im1, im2, roi, targetPosition)

% input: im1 (background), im2 (foreground), roi (in im2), targetPosition (in im1)

%% TODO: compute blended image
%  imret = 255-im1;
[h1, w1, dim1] = size(im1);
[h2, w2, ~] = size(im2);

% 构造网格
[x2, y2] = meshgrid(1:w2, 1:h2);

% 判断像素是否在多边形内
judge2 = inpolygon(x2, y2, roi(:, 1), roi(:, 2));

% 从多边形内提取像素坐标
x2 = [x2(judge2(:)), y2(judge2(:))];

% 注意到两个图片中的区域只相差一个平移
x1 = x2 + mean(targetPosition - roi);

% 设置Laplace算子的权重
weights = [4, -1, -1, -1, -1];

%% 创建稀疏矩阵
n = size(x2, 1);
m = size(x1, 1);
weights2 = repmat(weights,n,1);
weights1 = repmat(weights,m,1);
index = repmat((1:n)', 1, 5);
% 分别标记点(i,j)自身和左右上下的线性索引
index2 = ceil(sub2ind([h2, w2], (x2(:, 2) + [0, -1, 1, 0, 0]), (x2(:, 1) + [0, 0, 0, -1, 1])));
index1 = ceil(sub2ind([h1, w1], (x1(:, 2) + [0, -1, 1, 0, 0]), (x1(:, 1) + [0, 0, 0, -1, 1])));
% 构造面向全体像素点的稀疏矩阵，方便边界条件的处理
l2 = sparse(index(:), index2(:), weights2(:), n, w2 * h2);
l1 = sparse(index(:), index1(:), weights1(:), m, w1 * h1);


% 标记多边形内的像素坐标
judge1 = false(h1 * w1, 1);
index1 = ceil(sub2ind([h1, w1], x1(:, 2), x1(:, 1)));
judge1(index1(:)) = true;

im1 = double(reshape(im1, [], dim1));
im2 = double(reshape(im2, [], dim1));

%% 解泊松方程
% 对目标多边形内部的点作用Laplace算子
G = l1(:,judge1(:));
% 对源多边形内部的点作用Laplace算子，同时减去对应点的边界条件
g1= l2*im2 - l1(:,~judge1(:)) * im1(~judge1(:),:);
f1 = G \ g1;
im1(judge1(:),:)  =f1;

imret = reshape(uint8(im1), h1, w1, dim1);