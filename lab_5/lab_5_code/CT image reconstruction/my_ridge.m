function image = my_ridge(R, h, w, theta, num_iter, lambda, alpha)
    % 基于岭回归的梯度下降法
    % 输入：Radon变换结果矩阵R，原始图像I的大小[h,w]，扫描角度theta，迭代次数num_iter，梯度系数lambda，正则项系数alpha
    % 输出：CT重建图像image

    original_h = h; original_w = w;

    image = zeros(original_h, original_w);
    timage = zeros(original_h, original_w);

    for i = 1:num_iter
        grad = imresize(iradon(radon(image, theta) - R, theta, "Linear", "none"), [h, w]);
        image = image - grad * lambda - alpha * image;
        image = image / max(image(:));
        if max(max(abs(image - timage))) < 1e-2, break; end % 迭代终止条件
        timage = image;
    end

    image = timage;
    fprintf("迭代次数：%d\n", i);
end
