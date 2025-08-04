# wrapper

该模块用于启动cpu，也是启动整个系统的运行

wrapper的逻辑代码位于blkrv/rtl/csrc/main.cpp

## verilator

+ 初始化上下文

    ```c++
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vtop* top = new Vtop{contextp};

    VerilatedVcdC* tfp = new VerilatedVcdC; 
    contextp->traceEverOn(true); 
    ```

+ 打开trace跟踪

    ```c++
    top->trace(tfp, 0); 
    tfp->open("wave.vcd"); 
    ```

+ 模拟

    ```c++
    top->eval()
    ```

## devices（外设）

+ 初始化设备

    ```c++
    extern devices my_devices;//已在devices.cpp文件中声明为全局变量
    ```

+ 初始化监测器

    ```c++
    monitor* my_monitor;
    if(argc>=2)//传入性能数据存储文件路径
        my_monitor=new monitor(1<<28,argv[1]);
    else
        my_monitor=new monitor(1<<28,"../data.txt");
    ```

+ 片上系统工作流

    ```c++
    for(;;i++){//死循环
        top->clk=0;//时钟在0，1间来回切换
        top->eval();//模拟
        my_rib.dispatch(top,my_mmu.convert(top,&my_devices));//mmu转换虚拟地址后，将物理地址传入rib总线，决定传入指定的设备
        my_monitor->process(&my_rib,&my_mmu,main_time);//监测器采集相关数据。
        if(my_devices.process(&my_rib,i)){//外设接受信号
            break;//如果外设返回1，则代表出现关机信号。
        }
        my_rib.set_flag(top);//将外设的信号传回，由rib传给cpu
        top->clk=1;
        top->eval();
    }
    ```

## 全部代码

+
    ```c++
        #include<verilated.h>
        #include<verilated_vcd_c.h> 
        #include "Vtop.h"  
        #include "devices.h"
        #include "mmu.h"
        #include "monitor.h"

        extern vluint64_t main_time;
        extern devices my_devices;
        extern rib my_rib;
        extern mmu my_mmu;

        int main(int argc, char** argv, char** env) {
            std::cout<<"\033[3;1;31mstarting sim...\033[0m"<<std::endl;
            VerilatedContext* contextp = new VerilatedContext;
            contextp->commandArgs(argc, argv);
            Vtop* top = new Vtop{contextp};

            VerilatedVcdC* tfp = new VerilatedVcdC; 
            contextp->traceEverOn(true); 
            top->trace(tfp, 0); 
            tfp->open("wave.vcd"); 
            
            std::cout<<"start initializing devices..."<<std::endl;
            std::cout<<"$init monitor"<<std::endl;
            monitor* my_monitor;
            if(argc>=2)
                my_monitor=new monitor(1<<28,argv[1]);
            else
                my_monitor=new monitor(1<<28,"../data.txt");
            clock_t start,end;
            start=clock();
            top->clk=0;
            int i=0;
            for(;;i++){
                top->clk=0;
                top->eval();
                my_rib.dispatch(top,my_mmu.convert(top,&my_devices));
                my_monitor->process(&my_rib,&my_mmu,main_time);
                if(my_devices.process(&my_rib,i)){
                    break;
                }
                my_rib.set_flag(top);
                top->clk=1;
                top->eval();
            }
            end=clock();
            printf("ticktimes:%d,timecost:%f s\ndevices shuting down...\n",i,((double)(end-start))/CLOCKS_PER_SEC);
            delete top;
            tfp->close();
            delete contextp;
            return 0;
        }
    ```