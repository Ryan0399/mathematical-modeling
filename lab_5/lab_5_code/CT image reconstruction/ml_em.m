function image = ml_em(R, h, w, theta, num_iter)
    % 最大期望极大似然算法
    % 输入：Radon变换结果矩阵R，原始图像I的大小[h w]，扫描角度theta，迭代次数num_iter
    % 输出：CT重建图像image
    original_h = h; original_w = w;

    image = rand(original_h, original_w);
    timage = ones(original_h, original_w);
    operator = imresize(iradon(radon(ones(h, w), theta), theta, "linear", "None"), [h, w]);

    for i = 1:num_iter
        if max(max(abs(image - timage))) < 1e-2, break; end % 迭代终止条件
        image = timage;
        timage = image .* imresize(iradon(R ./ (radon(image, theta) + 0.0001), theta, "linear", "None"), [h, w]) ./ operator;
        timage = timage / max(timage(:));
    end

    image = 1 - timage;
    fprintf("迭代次数：%d\n", i);
end
