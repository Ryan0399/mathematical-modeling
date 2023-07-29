function [Psnr, Ssim] = image_quality(im1, im2)
    % 计算两幅灰度图的峰值信噪比
    im1 = uint8(im1 / max(im1(:)) * 255);
    im2 = uint8(im2 / max(im2(:)) * 255);
    diff = im1 - im2;
    mse = mean(diff(:) .^ 2);
    Psnr = 10 * log10(255 ^ 2 / mse);
    Ssim = ssim(im1, im2);
end
