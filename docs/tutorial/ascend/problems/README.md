
# 910B1相关问题

## 环境

910A环境变量：

![alt text](image-2.png)

910B1环境变量：

![alt text](image-3.png)

## 分支代码

代码位置

+ 910A /mnt/nvme0/pengyt/projects/matrix/optimize/ascendc

+ 910B1 /mnt/nvme0/pengyt/project/ascendc

执行命令：

`./batch_run.sh batch_config`

### master分支

实现简单的分块矩阵乘

+ 按行列组为aicore分配计算任务

+ 组内再切分以外积的方式进行计算

+ 计算结果在CO1累加，最后经CO2搬出到GM

如下图：

![alt text](image.png)

910A执行结果：

![alt text](image-1.png)

910B1执行结果：

![alt text](image-7.png)

分析：

注释掉代码主逻辑，进行一次分配与释放，

![alt text](image-11.png)

出现如下错误：

![alt text](image-12.png)

注释掉所有逻辑：

![alt text](image-14.png)

发现调用kernel就在报错：

![alt text](image-15.png)

### smaller_tile分支

提高第二次切分的细粒度，能够充分利用L0缓存，而不必受限于第一次切分的矩阵形状

+ 按行列组为aicore分配计算任务

+ 组内再切分以外积/内积的方式进行计算

+ 计算结果在CO1累加，最后经CO2搬出到GM

如下图：

![alt text](image-4.png)

910A执行结果：

![alt text](image-5.png)

910B1执行结果：

![alt text](image-6.png)

### cvAgg_dataTransInhost分支

+ 按行列组为aicore分配计算任务

+ cube内按照master方式进行计算

+ vec的任务分配由eq_core_num参数决定，计算公式为

$$task=\frac{group\_sum}{block\_num + eq\_core\_num} \times eq\_core\_num$$

如下图：

![alt text](image-8.png)

910A执行结果：

![alt text](image-9.png)

910B1执行结果：

![alt text](image-10.png)
