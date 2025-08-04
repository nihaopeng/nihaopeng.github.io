# cmake

## 相关指令功能

### set

功能：设置变量

用法：

1,一般变量

`set(normal "normalValue")`

2,缓存变量

```cmake
set(MY_VARIABLE "Hello, World!" CACHE STRING "A greeting message" FORCE)
message("${MY_VARIABLE}")   # 输出Hello, World!

set(MY_VARIABLE "Good Morning!" CACHE STRING "A greeting message")
message("${MY_VARIABLE}")   # 输出Hello, World!因为不加FORCE默认不覆盖

set(MY_VARIABLE "Good Morning!" CACHE STRING "A greeting message" FORCE)
message("${MY_VARIABLE}")   # 输出Good Morning! 加了FORCE强制覆盖
```

存储在CMakeCache当中，可以跨越多次编译，持久化存储。

3,环境变量

`set(ENV{<variable>} [<value>])`

`unset(ENV{<variable>})`

```cmake
# 设置一个名为 MY_VARIABLE 的环境变量，其值为 Hello World：
set(ENV{MY_VARIABLE} "Hello World")
```

可以用于在不同cmakelist之间传递变量，但是不可持久化储存

### file

1,READ

读取文件（filename）的内容保存到变量（variable）中；

file(READ config.cmake contents)

2,STRINGS

解析filename中的ASCII字符串列表，并将其存储在中。忽略文件中的二进制数据。忽略回车(\r, CR)字符；

### execute_process

通过execute_process方法可以执行多个子进程。

命令COMMAND会并行执行，每个子进程的标准输出映射到下一个进程的标准输入上，所有进程共用standard error管道。

`execute_process(COMMAND rm -rf ${ASCEND_AUTOGEN_PATH}/${CUSTOM_COMPILE_OPTIONS}
                COMMAND touch ${ASCEND_AUTOGEN_PATH}/${CUSTOM_COMPILE_OPTIONS})`

### function

```cmake
function(<name> [<arg1> ...])
  <commands>
endfunction([<name>])
```

```cmake
function(get_system_info SYSTEM_INFO)
  if (UNIX)
    execute_process(COMMAND grep -i ^id= /etc/os-release OUTPUT_VARIABLE TEMP)
  elseif (WIN32)
    message(STATUS "System is Windows. Only for pre-build.")
  else ()
    message(FATAL_ERROR "${CMAKE_SYSTEM_NAME} not support.")
  endif ()
endfunction()
```

### string

操作字符串

[具体教程](https://zhuanlan.zhihu.com/p/661283261)

### $<...>

1,检查变量 SOC_VERSION 的值是否在列表 CUSTOM_ASCEND310P_LIST 中

2,将上一步的结果强制转换为布尔类型（0 或 1）

3,如果条件为 True，则返回值 CUSTOM_ASCEND310P；否则不返回任何内容。

```cmake
ascendc_compile_definitions(ascendc_kernels_${RUN_MODE} PRIVATE
    $<$<BOOL:$<IN_LIST:${SOC_VERSION},${CUSTOM_ASCEND310P_LIST}>>:CUSTOM_ASCEND310P>
)
```

### get_filename_component

get_filename_component 函数用于获取文件名或目录的各个部分，如文件名、扩展名、目录等。

```cmake
get_filename_component(filename ${filepath} NAME)
get_filename_component(directory ${filepath} DIRECTORY)

message(STATUS "File Name: ${filename}")
message(STATUS "Directory: ${directory}")
```

### ExternalProject

ExternalProject是CMake提供的另一个模块，用于在构建时下载、配置、构建和安装外部项目（即不是作为当前CMake项目一部分的项目）。

ExternalProject模块通过以下主要步骤实现其功能：
1. 下载源代码：在构建过程中下载外部项目的源代码。可以指定URL、Git仓库、SVN仓库等多种来源。
2. 配置项目：对下载的外部项目进行配置，包括设置构建选项和参数。
3. 构建项目：构建外部项目，生成需要的二进制文件或库。
4. 安装项目：将构建的项目安装到指定位置，以便于主项目使用。

基本步骤：
1. 引入ExternalProject模块：
在CMakeLists.txt文件中使用include(ExternalProject)命令来启用ExternalProject模块的功能。
2. 声明外部项目：
使用ExternalProject_Add函数声明一个外部项目，指定其源代码来源、配置选项、构建命令、安装位置等。
3. 配置依赖关系（可选）：
如果外部项目依赖于其他项目或特定的构建步骤，可以使用add_dependencies命令来配置这些依赖关系。
4. 使用安装的依赖：
一旦外部项目被构建和安装，其产物（如库、可执行文件等）就可以在主项目中被使用。

### add_library

编译生成库文件

### target_compile_options

target_compile_options 指令用于为指定的目标添加编译器选项。通过这些选项，可以影响编译器如何处理目标的源代码。

