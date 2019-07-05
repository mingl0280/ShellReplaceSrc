#!/bin/bash

if [ `id -u` -ne 0 ]
then
    echo "Please run as root by using sudo."
    echo "请使用sudo执行本命令"
fi

cp /etc/apt/sources.list /etc/apt/sources.list.bak
cpExitCode=$?
if [ ${cpExitCode} -ne 0 ]
then
    echo "cp command failed. Please make sure you have write privilege to /etc/apt/ directory"
    echo "备份源失败，请检查对/etc/apt目录是否有写入权限"
    echo "若下面的输出的开头不是drwx则可能权限有问题"
    ls -al /etc/ | grep apt
    exit -1
fi
sed -i -E 's/(http|https):\/\/(\w+.)?(\w+.)?ubuntu.com/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list
sedExitCode=$?
if [ ${sedExitCode} -eq 0 ]
then
    echo "source replace complete. updating..."
    echo "替换源成功，更新中……"
    apt update
else
    echo "source replace failed. Please contact author."
    echo "替换源失败，请联系作者."
    echo "https://github.com/mingl0280/ShellReplaceSrc/issues"
fi
