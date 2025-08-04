# BUS

在blkrv中，rib总线仅具备地址分发与数据传输的作用。即区分设备以及作为数据的中间代理。

## 地址分发

在rib中规定了各设备的地址空间

如果需要进行扩展，即设备的注册，可以通过csr寄存器结合内存的方式，进行热插拔等扩展。

rib中的分发函数如下：

```c++
#define DISPATCH(n,dev) do { \
    this->s##n##_req = 1; \
    this->s##n##_addr = addr - dev##_start_addr; \
    this->s##n##_write_data = top->write_data; \
    this->s##n##_we = top->we; \
    this->s##n##_mem_op_type = top->mem_op_type; \
} while(0)
```

n为设备端口号，dev为设备名

当判断地址属于某一个设备时，将会调用上面的函数进行地址分发，并将相应的数据传输给相应的设备。

## 数据传输

数据的正向传输被包含在地址分发当中，数据从设备的响应如下：

```c++
#define SET_INT(n) top->int_port##n=this->int_port##n

#define SET_READ_DATA(n) if(REQ(n)){top->read_data=READ_DATA(n);}
```

在devices处理完数据后，需要调用setflag将响应的数据或者信号（如中断信号）响应给cpu。
