# MLAPO

## 算子融合

![alt text](image.png)

显然，融合算子可以避免和主机内存的频繁交换，提速是必然的，

MLAPO中还将前向的13个算子融合成一个大算子，包括以下内容：

 ![alt text](image-1.png)

 通过cube+vector并行的方式，并行计算一部分小算子，基本可以将向量运算进行覆盖。