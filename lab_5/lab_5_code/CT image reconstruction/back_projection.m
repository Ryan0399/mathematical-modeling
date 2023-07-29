function image = back_projection(R, h, w, theta)
    % 直接反投影法
    % 输入：Radon变换结果矩阵R，原始图像I的大小[h w]，扫描角度theta
    % 输出：CT重建图像image
    %     image=iradon(R,theta,"linear","None");

    [num_projections, num_angles] = size(R);

    original_h = h; original_w = w;

    image = zeros(original_h, original_w);

    % 计算原始图像的中心和扫描的中心
    image_center = [floor(original_h / 2) + 1, floor(original_w / 2) + 1];
    proj_center = floor(num_projections / 2) + 1;

    % 扫描的伸缩因子
    scale = 1;

    for a = 1:num_angles
        % 扫描方向
        dir = [cosd(theta(a) + 90), sind(theta(a) + 90)];

        for x = 1:original_h

            for y = 1:original_w
                % 计算体素相对于图像中心的位置
                pos = [x - image_center(1), y - image_center(2)];

                % 将相对位置投影到投影方向上
                proj = round(dot(pos, dir) * scale + proj_center);

                if proj >= 1 && proj <= num_projections

                    image(x, y) = image(x, y) + R(proj, a);
                end

            end

        end

    end

    % 根据扫描角度数进行归一化
    image = image / num_angles;
end
