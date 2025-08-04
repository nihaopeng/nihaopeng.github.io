# tinytodo

找不到一个好用的待办软件，一怒之下怒了一下，自己搞一个！

## 需求

|序号|功能描述||
|---|---|---|
|fun_1|显示登陆窗口||
|fun_2|输入邮箱登录||
|fun_3|显示待办窗口，置于底层，并固定在右上角||
|fun_4|点击＋按钮添加待办||
|fun_5|输入代办内容，点击添加，添加待办||
|fun_6|点击统计按钮，弹出统计窗口||
|fun_7|||
|fun_8|||
|fun_9|||

## 流程

登陆
```mermaid
flowchart LR
    1["click exe"]
    2["show login window"]
    3["get email"]
    4["request url to get todolist"]
    5["generate the todolist window"]
    6["show todolist window"]
    1 --> 2
    2 --> 3
    3 --> 4
    4 --> 5
    5 --> 6
```

添加待办
```mermaid
flowchart LR
    1["click +"]
    2["show add window"]
    3["get input"]
    4["add todolist"]
    5["sync todolist to url"]
    6["regenerate todolist window"]
    1 --> 2
    2 --> 3
    3 --> 4
    4 --> 5
    5 --> 6
```

## c/s protocol

client:SYNC?email=<email>
server:
    success:"READY?DBSIZE=<DBSIZE>"
    client:"READY RESV"
        server:FILE<DBSIZE>
        server:"FILEOK"
    fail:"FAIL"

client:UPLOAD?email=<email>
server:
    success:response<"READY">
    client:"READY?DBSIZE=<DBSIZE>"
        server:"READY RESV"
        client:FILE<DBSIZE>
        server"FILEOK"
    fail:response<"FAIL">
client:<file>
server:
    success:response<"FILEOK">
    fail:response<"FAIL">

## server process

### sync

+ 1.检查是否存在邮箱记录
+ 2.存在返回
+ 3.不存在则返回FAIL

### upload

+ 1.检查是否存在邮箱记录
+ 2.存在邮箱则查询对应的数据库名称，返回READY，并接受文件保存为查询到的名称
+ 3.不存在则新建邮箱记录
+ 4.新建邮箱记录首先获取最大值id
+ 5.提交数据库


## exec file

|version|download|source_code|
|---|---|---|
<!-- |tinytodo v1.0|[download here](./tinytodov1.0.zip)|[download source](./sourcev1.0.zip)|
|tinytodo v1.1|[download here](./tinytodov1.1.zip)||
|tinytodo v1.2|[download here](./tinytodov1.2.zip)||
|tinytodo v1.3|[download here](./tinytodov1.3.7z)|[download source](./sourcev1.3.7z)|
|tinytodo v1.3|[download here](./tinytodov1.4.7z)|[download source](https://gitee.com/helloyutao/tinytodo.git)| -->