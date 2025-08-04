# riscv交叉编译链

## 依赖安装

顺序执行以下：
[download gmp](https://gmplib.org/)
```bash
tar -xvjf gmp-6.2.1.tar.bz2
cd gmp-6.2.1/
./configure
make
make install
```

[download mpfr](https://ftp.gnu.org/gnu/mpfr/)
```bash
tar -xvjf mpfr-4.1.0.tar.bz2
cd mpfr-4.1.0/
./configure
make
make install
```

[download mpc](https://www.multiprecision.org/mpc/download.html)
```bash
tar -xvzf mpc-1.2.1.tar.gz
cd mpc-1.2.1/
./configure
make
make install
```

[download gettext](https://mirrors.aliyun.com/gnu/gettext/)
```bash
tar zxvf gettext.tar.gz
cd gettext
./configure
make
make install
```

## 安装

以下两种方式

+ 获取预编译版本
1,通过网盘分享的文件：riscv32.tar.gz
链接: https://pan.baidu.com/s/1pf0ikqstdLKcauD90w3KeQ?pwd=b3vt 提取码: b3vt

2,`tar zxvf riscv32.tar.gz`

+ 手动编译
1,`git clone --recursive https://github.com/riscv/riscv-gnu-toolchain`

fine,你可以选择不递归下载，后续编译会自动下载相关内容。

2,`cd riscv-gnu-toolchain`

3,`./configure --prefix=/opt/riscv32 --with-arch=rv32i --with-abi=ilp32`

上面prefix代表编译完后的文件存放路径，--with-arch=rv32i代表支持riscv-32位-整数指令集，abi是调用规范，使用ilp32，不支持浮点。

4,`make`

### 添加环境变量

1,`vim ~/.bashrc`

+ 采用手动编译的，末尾增加`export PATH=/opt/riscv32/bin:$PATH$`，也就是上面的prefix。

+ 采用预编译包的，末尾添加`export PATH=/path/to/riscv/bin:$PATH$`。/path/to/riscv/也就是riscv文件夹路径

2,按ESC键，输入:wq退出vim编辑器，冒号别少了。

3,`source ~/.bashrc`

4,运行`riscv32-unknown-elf-gcc --version`查看是否有输出