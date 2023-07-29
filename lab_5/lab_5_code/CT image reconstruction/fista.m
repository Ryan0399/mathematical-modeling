function image = fista(R, h, w, theta, num_iter, lambda)
    % 快速迭代收缩阈值法
    % 输入：Radon变换结果矩阵R，原始图像I的大小[h w]，扫描角度theta，迭代次数num_iter，正则化因子lambda
    % 输出：CT重建图像image

    original_h = h; original_w = w;

    image = zeros(original_h, original_w);
    timage = zeros(original_h, original_w);

    L = 5e-4; % Lipschitz常数
    t = 1;
    y = image;

    for i = 1:num_iter
        d = y - L * imresize(iradon(radon(y, theta) - R, theta, "Linear", "none"), [h, w]);
        image = max(abs(d) - lambda * L, 0) .* sign(d);
        if max(max(abs(image - timage))) < 1e-2, break; end % 迭代终止条件
        tp = (1 + sqrt(1 + 4 * t ^ 2)) / 2;
        y = image + (t - 1) / tp * (image - timage);
        timage = image;
        t = tp;
    end

    fprintf("迭代次数：%d\n", i);
end
