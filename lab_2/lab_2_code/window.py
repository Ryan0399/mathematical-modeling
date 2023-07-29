import tkinter as tk
from tkinter import filedialog
import os
import imagecompression as imc

def browse_file():
    file_path = filedialog.askopenfilename()
    file_entry.delete(0, tk.END)
    file_entry.insert(0, file_path)

def compress_image():
    file_path_input = file_entry.get()
    k = int(k_entry.get())
    windowName="Compression Image"
    outputImagePath="Compression_Iamge.jpg"
    imc.imageCompression(file_path_input,windowName,outputImagePath,k)
    compress_button.config(state=tk.NORMAL)

root = tk.Tk()
root.title('Image Compression')

# 创建文件选择器
file_label = tk.Label(root, text='Choose a file:')
file_label.grid(row=0, column=0)
file_entry = tk.Entry(root)
file_entry.grid(row=0, column=1)
browse_button = tk.Button(root, text='Browse', command=browse_file)
browse_button.grid(row=0, column=2)

# 创建参数k的输入框
k_label = tk.Label(root, text='k:')
k_label.grid(row=1, column=0)
k_entry = tk.Entry(root)
k_entry.grid(row=1, column=1)

# 创建压缩按钮
compress_button = tk.Button(root, text='Compress', command=compress_image)
compress_button.grid(row=2, column=1)

root.mainloop()