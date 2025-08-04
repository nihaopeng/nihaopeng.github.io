# CPU寄存器详解

## 通用寄存器

|寄存器|别名|全称|说明|
|---|---|---|---|
|X0	|zero	|零寄存器	|可做源寄存器(rs)或目标寄存器(rd)|
|X1	|ra	|链接寄存器	|保存函数返回地址|
|X2	|sp	|栈指针寄存器	|指向栈的地址|
|X3	|gp	|全局寄存器	|用于链接器松弛优化（blkos中未启用）|
|X4	|tp	|线程寄存器	|常用于在OS中保存指向进程控制块(task_struct)数据结构的指针（blkos中未启用）|
|X5 ~ X7，X28 ~ X31	|t0 ~ t6	|临时寄存器	|
|X8	|s0/fp	|帧指针寄存器	|用于函数调用，被调用函数需保存数据|
|X9	|s1		||用于函数调用 ，被调用函数需要保存的数据|
|X10 ~ X17	|a0 ~ a7		||用于函数调用，传递参数和返回值|
|X18 ~ X27	|s2 ~ s11		||用于函数调用 ，被调用函数需要保存的数据|

## CSR寄存器

|寄存器|别名|全称|说明|
|---|---|---|---|
|c305|mtvec|Machine Trap-Vector Base-Address|用于保存中断查询程序地址，需要在系统初始化时通过csr指令赋值|
|c341|mepc|Machine Exception Program Counter|用于保存发生中断时，程序执行的pc，也就是中断地址|
|c342|mcause|Machine Cause|保存中断发生的原因，此处保存的是发生中断的端口|
|c300|mstatus|Machine Status|blkrv中该寄存器仅作为中断使能状态寄存器，低8位是否为1代表是否使能|
|c180|satp|Supervisor Address Translation and Protection Register|保存页表基址|
|c181|satp_s_cp||发生系统调用时，保存satp副本|
|c182|satp_i_cp||发生中断调用时，保存satp副本|

## 流水寄存器

|寄存器|全称|说明|
|---|---|---|
|pc|Program counter|用于保存当前执行指令的地址|
|imm||用于保存解析指令时产生的立即数|
|addr_v|virtual address|用于保存LOAD/STORE指令等指向的地址|
|data2regs||用于保存需要存储到通用寄存器的数据|
|data2mem||用于保存需要存储到内存的数据|
|inst|instruction|用于保存读取的指令|