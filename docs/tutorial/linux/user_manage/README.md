# linux 用户管理

## 用户权限

777权限不再赘述

## 用户组

当一个用户a被添加到用户组g后，如果一个文件的权限为747，即-rxwr--rxw，这个文件的用户组为g，那么a用户对于该文件的操作权限只有读权限，而没有执行权限和写权限。

一个文件的所有者的权限第一个数字，其他用户权限是第三个数字。

## sudo

当我们在sudoer文件中添加一个用户组时，该用户组内用户即可使用sudo命令

例如wheel用户组，使用`sudo visudo`命令，添加如下:

`%wheel ALl=(ALL) NOPASSWD: ALL`

上面配置的含义是，ALL=(ALL)第一个ALL对于所有主机的所有连接，第二个ALL表示用户 username 在执行后续命令时，可以切换到任何其他用户的身份

NOPASSWD代表执行sudo的命令时无需密码

冒号后面是可以执行的命令，ALL代表任何命令，如果想要限制仅能执行部分命令，如下：

`%wheel ALl=(ALL) NOPASSWD: apt install *,apt update`