function image = iteration(R, h, w, theta, num_iter, revalation)
    % SART 重建法
    % 输入：Radon变换结果矩阵R，原始图像I的大小[h w]，扫描角度theta，迭代次数num_iter，松弛因子revalation
    % 输出：CT重建图像image

    % 初始化参数
    %     [num_projections, num_angles] = size(R);
    original_h = h; original_w = w;
    image = zeros(original_h, original_w);
    timage = ones(original_h, original_w);

    %     fbs=imresize(iradon(R,theta),[original_h,original_w]);

    % ART迭代
    operator = imresize(iradon(radon(ones(h, w), theta), theta, "linear", "None"), [h, w]);

    for i = 1:num_iter
        if max(max(abs(image - timage))) < 1e-2, break; end % 迭代终止条件
        image = timage;
        timage = image + revalation * imresize(iradon(R - radon(image, theta), theta, "linear", "None"), [h, w]) ./ operator;
    end

    image = timage;
    fprintf("迭代次数：%d\n", i);

end
