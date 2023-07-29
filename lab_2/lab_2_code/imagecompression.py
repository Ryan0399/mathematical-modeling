import cv2
import numpy as np
import visibility_of_errors as voe

def cv_imread(file_path):
    cv_img=cv2.imdecode(np.fromfile(file_path,dtype=np.uint8),-1)
    return cv_img

def imageCompression(inputImagePath, windowName, outputImagePath, k):
    # 输入：读取图像的路径，窗口名称，输出图像的路径，保留奇异值的个数
    # 输出：压缩后图像

    # 读入图像
    img = cv_imread(inputImagePath)

    # 数据类型转换，缩小像素范围使得后续svd分解更加稳定
    img = np.float32(img)/255.0 

    # 分解颜色通道
    img_r = img[:, :, 0]
    img_g = img[:, :, 1]
    img_b = img[:, :, 2]

    # 对三个颜色通道分别进行svd分解
    U_r, S_r, V_r = np.linalg.svd(img_r)
    U_g, S_g, V_g = np.linalg.svd(img_g)
    U_b, S_b, V_b = np.linalg.svd(img_b)

    # print(S_b.shape) //2560
    # np.set_printoptions(precision=1, threshold=10000)
    # print(S_r,S_g,S_b)
    # 进行压缩操作
    U_r_k = U_r[:, :k]
    S_r_k = np.diag(S_r[:k])
    V_r_k = V_r[:k, :]
    compression_r = np.dot(U_r_k, np.dot(S_r_k, V_r_k))

    U_g_k = U_g[:, :k]
    S_g_k = np.diag(S_g[:k])
    V_g_k = V_g[:k, :]
    compression_g = np.dot(U_g_k, np.dot(S_g_k, V_g_k))

    U_b_k = U_b[:, :k]
    S_b_k = np.diag(S_b[:k])
    V_b_k = V_b[:k, :]
    compression_b = np.dot(U_b_k, np.dot(S_b_k, V_b_k))

    # 颜色通道合并
    compressionImg = np.zeros_like(img)
    compressionImg[:, :, 0] = compression_r
    compressionImg[:, :, 1] = compression_g
    compressionImg[:, :, 2] = compression_b
    # compressionImg=np.uint8(compressionImg)

    # 将像素值范围缩放到[0, 255]
    compressionImg = np.clip(compressionImg * 255, 0, 255)

    # 图像质量评估
    # psnr=voe.cal_psnr(img*255.0,compressionImg)
    # ssim=voe.cal_ssim(img*255.0,compressionImg)
    # print(psnr,ssim)

    # 将像素值转换为整型数值
    compressionImg = np.uint8(compressionImg)

    # 显示压缩后的图像
    cv2.namedWindow(windowName, 0)
    cv2.imshow(windowName, compressionImg)
    cv2.imwrite(outputImagePath, compressionImg)
    cv2.waitKey()  # pause
    cv2.destroyAllWindows()

def main():
    inputimagepath = "colorful_hamel.jpg"
    windowname = "gray_hamel"
    outimagepath = "gray_hamel.jpg"
    # inputimagepath = "Impression, soleil.jpg"
    # windowname = "gray_Is"
    # outimagepath = "gray_Is.jpg"
    # inputimagepath = "red_tree.jpg"
    # windowname = "gray_tree"
    # outimagepath = "gray_tree.jpg"
    k=10
    imageCompression(inputimagepath, windowname, outimagepath,k)


if __name__ == '__main__':
    main()