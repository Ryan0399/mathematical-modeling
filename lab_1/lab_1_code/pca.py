import numpy as np
import cv2

def pac(data_mat):
    # 去中心化
    # data_mat_shape=data_mat.shape
    mean_val = np.mean(data_mat,axis=0)
    mean_removed = np.subtract(data_mat , mean_val)
    # 计算协方差矩阵X
    cov_mat = np.cov(mean_removed, rowvar=0)
    # 计算协方差矩阵的特征值和特征向量
    eig_val, eig_vector = np.linalg.eig(np.mat(cov_mat))
    # 对特征值进行排序，并返回索引值
    eig_val_ind = np.argsort(eig_val)
    # eig_val_ind = eig_val_ind[: -(N+1): -1]
    # 对排序后的特征值对应的特征向量
    # print(eig_val)
    # print(eig_val_ind)
    red_eig_val = eig_vector[eig_val_ind[2]]
    # 新矩阵
    # print(red_eig_val.shape)
    # 校正主特征方向
    # print(red_eig_val,red_eig_val[0,2])
    if red_eig_val[0,1]<0:
        red_eig_val*=-1
    # 对所得均值点做一个亮度判断
    # k=pow(1/(1+1.5**2.2+0.6**2.2),1/2.2)
    # L=k*pow((mean_val[0]/255)**2.2+(1.5*mean_val[1]/255)**2.2+(0.6*mean_val[2]/255)**2.2)
    # if L<0.5:
    #     low_data_mat =  mean_removed * red_eig_val.T
    # else:
    #     low_data_mat =  mean_removed * red_eig_val.T
    # long=np.ptp(low_data_mat)
    # min=np.min(low_data_mat)
    low_data_mat=mean_removed * red_eig_val.T
    low_data_mat=cv2.normalize(low_data_mat,None,0,255,cv2.NORM_MINMAX)
    return low_data_mat
