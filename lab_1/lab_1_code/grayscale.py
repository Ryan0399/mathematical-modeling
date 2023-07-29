import cv2
import numpy as np
import pca
def gray_rgb(inputimagepath, windowname, outimagepath):
    img = cv2.imread(inputimagepath)  # 读取图像
    gray_image = img.copy()
    img_shape = img.shape  # 返回一位数组（高，宽，3）获得原始图像的长宽以及颜色通道数
    # 固定权重线性投影灰度化算法
    # 注意：cv2.imread()读入颜色通道的顺序是BGR
    # for i in range(img_shape[0]):
    #     for j in range(img_shape[1]):
            # gray_image[i, j] = 0.333*img[i, j][0]+0.334 * \
            #     img[i, j][1]+0.333*img[i, j][2]  # 1.Intensity算法求灰度值
            # gray_image[i, j] = 0.114*img[i, j][0]+0.587 * \
            #     img[i, j][1]+0.299*img[i, j][2]  # 2.Luminance算法求灰度值
            # gamma = 1.5
            # gray_image[i, j] = 0.0772*int((img[i, j][0]/255)**gamma*255)+0.7152 * \
            #     int((img[i, j][1]/255)**gamma*255)+0.2126 * \
            #     int((img[i, j][2]/255)**gamma*255)  # 3.Luma算法求灰度值

    # 线性降维模型(主成分分析)
    img_cov=img.reshape(img_shape[0]*img_shape[1],3)
    gray_cov=pca.pac(img_cov)
    gray_image=gray_cov.reshape(img_shape[0],img_shape[1])
    # print(gray_cov)
    # print(gray_image)  # 打印像素矩阵
    cv2.namedWindow(windowname, 0)
    cv2.imshow(windowname, gray_image)  # 展示灰度图
    cv2.imwrite(outimagepath, gray_image)
    cv2.waitKey()  # pause
    cv2.destroyAllWindows()


def main():
    # inputimagepath = "colorful_hamel.jpg"
    # windowname = "gray_hamel"
    # outimagepath = "gray_hamel.jpg"
    # inputimagepath = "Impression, soleil.jpg"
    # windowname = "gray_Is"
    # outimagepath = "gray_Is.jpg"
    inputimagepath = "red_tree.jpg"
    windowname = "gray_tree"
    outimagepath = "gray_tree.jpg"
    gray_rgb(inputimagepath, windowname, outimagepath)


if __name__ == '__main__':
    main()
