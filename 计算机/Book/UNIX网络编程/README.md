# 准备工作

系统环境为: Ubuntu 18.04.4 LTS

源码地址: https://github.com/hailinzeng/Unix-Network-Programming

1. 使用`git clone`命令将源码克隆到本地

2. `cd Unix-Network-Programming`进入到源码项目目录

3. 执行`./configure`，主要工作是检查系统是否有源码编译所依赖的各种资源，例如: 系统版本是否匹配、编译器、库文件、头文件等等。若无法执行，可以使用`sudo chmod +x configure`更改权限再执行

4. `cd lib`进入 lib 目录，然后执行`make`命令编译基础库，得到 libudp.a 静态库文件

5. `cd ../libfree`进入 libfree 目录，然后执行`make`命令继续编译基础库。出现报错，指出`libfree/inet_ntop.c`文件中名为`size`的参数与`/usr/include/arpa/inet.h`中的`inet_ntop`函数的`size`参数类型不一致导致。将`libfree/inet_ntop.c`文件中所有名为`size`的变量类型改为`socklen_t`即可。之后，重新执行`make`命令。

6. `cd ../libgai`进入 libgai 目录，然后执行`make`命令

7. `cd ..`进入到源码根目录，执行：

```
sudo cp libunp.a /usr/lib

sudo cp libunp.a /usr/lib32
```

将生成的库文件复制到系统库目录

8. 为了方便之后`include`方便，将`lib/unp.h`中的`#include "../config.h"`改为`#include "config.h"`。然后执行:

```
sudo cp lib/unp.h /usr/include

sudo cp config.h /usr/include
```

将两个头文件复制到`/usr/include`目录中。

9. `cd ./intro`进入 intro 目录，然后执行:

```
gcc daytimetcpcli.c -o daytimetcpcli -lunp

gcc daytimetcpsrv.c -o daytimetcpsrv -lunp
```

之后先运行服务器端程序`./daytimetcpsrv`，再运行客户端程序`./daytimetcpcli`，在客户端命令行窗口可看到获取到了时间。若两个程序没有执行权限的话，需要使用`sudo chmod +x daytimetcpcli daytimetcpsrv`给其添加权限。

## 问题

1. Ubuntu 或者说 Linux 系统中的`/usr/include`和`/usr/lib`目录的作用是？

`/usr/include`用于保存头文件，`/usr/lib`用于保存库文件。

An Introduction to Gcc - Setting search paths: https://www.linuxtopia.org/online_books/an_introduction_to_gcc/gccintro_21.html

2. 什么是静态库文件？

通常我们会在头文件中对函数进行声明，在源文件中完成具体的实现。此时该源文件是对所有人可见的，不具备安全性和保密性。C/C++提供了一个方法，可将源文件编译成一个库文件，是一种可执行代码的二进制形式，可以与其他的源程序一起编译，也可以被操作系统载入内存执行。如此一来，在提供一些函数的时候就可以仅仅提供库文件，而非源文件，安全性得到了保证。

其中，库文件分为静态库文件和动态库文件。

**静态库**是指主程序文件和该库文件会一同被编译链接生成到目标文件中，但如果对静态库的代码进行了修改，就必须重新生成静态库文件，然后再重新生成可执行文件。

命名方式: libxxx.a，库名前加`lib`，后缀用`.a`，`xxx`为静态库名。

将一个源文件变成一个静态库文件，用`-c`选项，只编译而不链接。

例如:

```
gcc -c -o libtiny.a tiny.c
```

调用静态库有两种方式:

方式一: 直接使用静态库的文件名

```
gcc -o server server.c libtiny.a
```

方式二: `-L`指定静态库目录，`-l`指定静态库名字(不是文件名)

```
gcc -o server server.c -L/home/ubuntu/lib -ltiny
```

若要指定多个静态库目录或静态库文件，需要多次使用`-L`和`-l`

**动态库**不是直接生成目标文件，而是在运行时，才会被载入。它带来的好处是，如果对动态库代码进行了修改，只需要重新编译动态库即可，不需要重新编译生成可执行文件。

命名方式: 前缀是`lib`，后缀是`.so`，例如: `libtiny.so`。

生成动态库方式如下:

```
gcc -fPIC -shared -o libtiny.so tiny.c
```

Linux 静态库与动态库: https://freecplus.net/05944de09a3942a89a571d523712b548.html

库文件: https://blog.csdn.net/YoYuanZhizheng/article/details/122767616

GCC 静态库与动态库的生成以及使用: https://blog.csdn.net/louderIII/article/details/120811509

3. 在使用`gcc`编译时，`-l`选项的含义是？如何查看其搜索路径？如何添加新的路径？

`-l`用来指定库名字。默认的搜索路径为`/usr/lib`。可通过`-L`选项添加路径。

## 新知

1. 在 libfree/inet_ntop.c`文件中看到了一种之前没看到的语法（可能是 C 语言用的少的原因），那便是如下定义函数的方式:

```C
int add(num1, num2)
        int num1;
        int num2;
{
  return num1 + num2;
}
```

## 推荐

C 语言函数的定义: https://blog.csdn.net/CUFEECR/article/details/105875275

# 第 1 章 简介

## 一个简单的时间获取客户程序

源文件`intro/daytimetcpcli.c`:

```C

#include	"unp.h"

int
main(int argc, char **argv)
{
	int					sockfd, n;
	char				recvline[MAXLINE + 1];
	struct sockaddr_in	servaddr;

	if (argc != 2)
		err_quit("usage: a.out <IPaddress>");

	if ( (sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
		err_sys("socket error");

	bzero(&servaddr, sizeof(servaddr));
	servaddr.sin_family = AF_INET;
	servaddr.sin_port   = htons(13);	/* daytime server */
	if (inet_pton(AF_INET, argv[1], &servaddr.sin_addr) <= 0)
		err_quit("inet_pton error for %s", argv[1]);

	if (connect(sockfd, (SA *) &servaddr, sizeof(servaddr)) < 0)
		err_sys("connect error");

	while ( (n = read(sockfd, recvline, MAXLINE)) > 0) {
		recvline[n] = 0;	/* null terminate */
		if (fputs(recvline, stdout) == EOF)
			err_sys("fputs error");
	}
	if (n < 0)
		err_sys("read error");

	exit(0);
}

```

### 说明

`sockaddr_in`的结构为:

```C
struct sockaddr_in {
  _SOCKADDR_COMMON (sin_);
  in_port_t sin_port; /* Port number. */
  struct in_addr sin_addr; /* Internet address. */

  /* Pad to size of 'struct sockaddr'. */
  unsigned char sin_zero[sizeof (struct sockaddr) -
                        __SOCKADDR_COMMON_SIZE -
                        sizeof (in_port_t) -
                        sizeof (struct in_addr)];
};
```

定义在`/usr/include/netinet/in.h`文件中。

`__SOCKADDR_COMMON`为宏，定义在`/usr/include/bits/sockaddr.h`中:

```C
#define __SOCKADDR_COMMON(sa_prefix) \
sa_family_t sa_prefix##family
```

`sa_family_t`定义在同一个文件中，为`unsigned short int`类型。

作用是拼接变量名。在`sockaddr_in`结构体中使用这个宏得到的结果为`sa_family_t sin_family`，`sin_family`变量名就是由传入的`sin_`和`family`拼接得到的。

`in_port_t`定义在`/usr/include/netinet/in.h`中，从`/usr/include/bits/stdint-uint.h`->`/usr/include/bits/types.h`可以看到它就是`unsigned short int`类型。

`struct in_addr`定义在`/usr/include/netinet/in.h`中:

```C
struct in_addr {
  in_addr_t s_addr;
};

```

`in_addr_t`类似`in_port_t`追踪，可以看到其为`unsigned int`类型。

`struct sockaddr`定义在`/usr/include/bits/socket.h`中:

```C
// Structure describing a generic socket address. 
struct sockaddr {
  __SOCKADDR_COMMON (sa_); /* Common data: address family and length. */
  char sa_data[14]; /* Address data. */
};
```

可以看到`struct sockaddr`和`sockaddr_in`占用空间大小是一致的，`sockaddr_in`的`sin_port`(端口)和`sin_addr`(网络地址)以及`sin_zero`(填充部分)保存在`sockaddr`的`sa_data`部分中。

What does `__SOCKADDR_COMMON (sin_)` mean?: https://stackoverflow.com/questions/34539564/what-does-sockaddr-common-sin-mean

`err_quit`函数的定义及作用为:

附录D.3 标准错误处理函数介绍了5个标准错误处理函数，该函数定义在项目源码下`lib/error.c`文件:

```C
void
error_quit(const char *fmt, ...)
{
  val_list ap;
  
  va_start(ap, fmt);
  error_doit(0, LOG_ERR, fmt, ap);
  va_end(ap);
  exit(1);
}

```

Variable Length Argument in C: https://www.geeksforgeeks.org/variable-length-argument-c/

`err_sys`函数的定义及作用为:

定义在`lib/error.c`中:

```C
void error_sys(const char *fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  error_doit(1, LOG_ERR, fmt, ap);
  va_end(ap);
  exit(1);
}
```



`bzero`函数的定义及作用为:

在`/usr/include/unp.h`(准备时复制过去的)中定义:

```C
#define bzero(ptr, n) memset(ptr, 0, n)
```

memset: https://linux.die.net/man/3/memset

`AF_INET`的定义为:

在`/usr/include/bits/socket.h`中定义:

```C
#define AF_INET PF_INET

```

其中，`PF_INET`的定义为:

```C
#define PF_INET 2 /* IP protocol family */
```



`SOCK_STREAM`的定义为:

```C
#define SOCK_STREAM 1 /* stream (connection) socket */
```

What is SOCK_DGRAM and SOCK_STREAM?: https://stackoverflow.com/questions/5815675/what-is-sock-dgram-and-sock-stream

https://students.mimuw.edu.pl/SO/Linux/Kod/include/linux/socket.h.html



`htons`函数的定义及作用为:

```C
unit16_t htons(uint16_t hostshort);
```

Convert a 16-bit value from host-byte order to network-byte order.

htons() function in socket programming: https://stackoverflow.com/questions/19207745/htons-function-in-socket-programing

htons(): https://www.qnx.com/developers/docs/7.1/#com.qnx.doc.neutrino.lib_ref/topic/h/htons.html

`inet_pton`函数的定义及作用为:

```C
int inet_pton(int af, const char *restrict src, void *restrict dst);
```

Convert IPv4 and Ipv6 addresses from text to binary from.

inet_pton: https://man7.org/linux/man-pages/man3/inet_pton.3.html

`connect`函数的定义及作用为:

```C
int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
```

Initiate a connection on a socket.

connect: https://man7.org/linux/man-pages/man2/connect.2.html

`read`函数的定义及作用为:

```C
ssize_t read(int fd, void *buf, size_t count);
```

Read from a file descriptor.

`fputs`函数的定义及作用为:

```C
int fputs(const char *restrict s, FILE *restrict stream);
```

Put a string on a stream.

fputs: https://man7.org/linux/man-pages/man3/fputs.3p.html

What does 'stream' mean in C?: https://stackoverflow.com/questions/38652953/what-does-stream-mean-in-c

# 推荐

《网络是怎样连接的》

《计算机网络自顶向下方法》第 6 版

《TCP/IP 详解卷 1: 协议》第 2 版

《HTTP 权威指南》

# 参考

《UNIX 网络编程卷 1: 套接字联网 API》
