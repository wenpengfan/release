#!/bin/bash
for i in $service; do
echo ========================关闭进程=============================
ssh -p 12525 trade@$i "ps -ef|grep -w tomcat_$1|grep -v grep"
if [ $? != 0 ]
        then
                echo '进程为关闭状态!'
        else
                ssh -p 12525  trade@$i "ps -ef|grep -w tomcat_$1|grep -v grep|awk '{print \$2}'|xargs kill -9"
                        if [ $? != 0 ]
                                then
                                        echo "-1,关闭进程失败,日志完成"
                                        exit
                        fi
fi
path="cd /data/trade/simulateweb/tomcat_$1/webapps/$1/"
ssh -p 12525 trade@$i "if [ \`$path &&git log|grep -B 5 $3 |grep commit|wc -l\` -eq "1" ]; then $path &&git log|grep -B 5 $3 |grep commit|awk '{print \$2}'|xargs git revert ;else echo 此单号有多个版本号; fi "
if [ $? != 0 ]
        then
                echo "-1,git回滚文件失败"
                exit
fi

#ssh -p 12525 trade@192.168.25.26 "cd /data/trade/simulateweb/tomcat_$1/webapps/$1/ && git log|grep -B 5 $3 |grep commit| cut -c 8-15 |xargs git reset --hard"
#if [ $? != 0 ]
#       then
#               echo '-1,git回滚失败,日志完成'
#fi

echo ===========================程序启动=============================
ssh -p 12525 trade@$i "export BASH_ENV=/etc/profile && cd /data/trade/simulateweb/tomcat_$1 && bash quikstat.sh && ps -ef|grep $1"
if [ $? != 0 ]
        then
                echo "-1,启动程序失败,日志完成"
		exit
fi
done

