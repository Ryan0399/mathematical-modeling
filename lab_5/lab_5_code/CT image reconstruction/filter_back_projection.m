function image = filter_back_projection(R, h, w, theta)
    % 滤波反投影法
    % 输入：Radon变换结果矩阵R，原始图像I的大小[h w]，扫描角度theta
    % 输出：CT重建图像image
    % 设计R-L滤波器
    height = size(R, 1);
    filter = 2 * [0:round(height / 2 - 1), height / 2:-1:1]' / height;
    % 每一列做傅里叶变换
    r_fft = fft(R, height);
    % 每一列做傅里叶变换后滤波
    r_fft_filter = r_fft .* filter;
    % 滤波后反变换(real取实部)
    r_fft_filter_v = real(ifft(r_fft_filter));
    image = back_projection(r_fft_filter_v, h, w, theta);
end
