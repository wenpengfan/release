#!/bin/bash
for i in $service; do
echo ========================关闭进程=============================
ssh trade@$i "ps -ef|grep -w tomcat_$1|grep -v grep"
if [ $? != 0 ]
        then
                echo '进程为关闭状态!'
        else
                ssh trade@$i "ps -ef|grep -w tomcat_$1|grep -v grep|awk '{print \$2}'|xargs kill -9"
                        if [ $? != 0 ]
                                then
                                        echo "-1,关闭进程失败,日志完成"
                                        exit
                        fi
fi
sleep 2
path="cd /data/trade/testweb/tomcat_$1/webapps/$1/"
ssh trade@$i "if [ \`$path &&git log|grep -B 5 $3 |grep commit|wc -l\` -eq "1" ]; then $path &&git log|grep -B 5 $3 |grep commit|awk '{print \$2}'|xargs git revert ;else echo "$1程序内此单号有多个版本号" exit; fi "
#if [ $? != 0 ]
#        then
#                echo "-1,git回滚文件失败"
#                exit
#fi
sleep 2
echo ===========================程序启动=============================
ssh trade@$i "export BASH_ENV=/etc/profile && cd /data/trade/testweb/tomcat_$1 && bash quikstat.sh && ps -ef|grep $1"
if [ $? != 0 ]
        then
                echo "-1,启动程序失败,日志完成"
		exit
fi
done

