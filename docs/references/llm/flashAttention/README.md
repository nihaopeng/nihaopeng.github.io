# flash attention


## method

使用算子融合的思想，将计算局限在SRAM中，例如QK计算中间结果不进行HBM的写回，而是通过分块的方式，继续同V矩阵的部分value进行计算，然后将这一部分的计算结果写回HBM，再进行下一块计算，这样就避免了SRAM频繁从HBM读取数据的问题。

