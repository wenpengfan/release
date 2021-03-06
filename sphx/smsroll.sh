#!/bin/bash

#此处ip为核心程序所依赖的前置的ip地址
ip='192.168.10.165 172.20.10.10 192.168.10.167'
tradeip='192.168.10.165 192.168.10.166 192.168.10.167 192.168.10.168 172.20.10.10 172.20.10.11 172.20.10.12 172.20.10.13'
#此处变量为前置核心程序所依赖的前置程序的名称
manages='adminweb|orgweb'
trade='tradeweb'

path='ssh -p 12525 trade@192.168.20.166'
echo ========================关闭进程=============================
#判断程序，关闭其依赖程序，所依赖的前置程序用FOR循环批量停止
case $1 in
        manageserver)
        for i in $ip
        do
          ssh -p 12525 trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep"
                if [ $? != 0 ]; then
                   echo "前置依赖进程为关闭状态!"
                else
                   ssh -p 12525 trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep|awk '{print \$2}'|xargs kill -9"
                        if [ $? != 0 ]; then
                           echo "-1,前置依赖关闭进程失败,日志完成"
                           exit
                        fi
                fi
        done
;;

        orgmanageserver)
        for i in $ip
        do
          ssh -p 12525 trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep"
                if [ $? != 0 ]; then
                   echo "前置依赖进程为关闭状态!"
                else
                   ssh -p 12525 trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep|awk '{print \$2}'|xargs kill -9"
                        if [ $? != 0 ]; then
                           echo "-1,前置依赖关闭进程失败,日志完成"
                           exit
                        fi
                fi
        done
          $path "ps -ef|grep -w "manageserver"|grep -v grep|awk '{print \$2}'|xargs kill -9"
;;

        tradeserver)
        for i in $tradeip
        do
          ssh -p 12525 trade@$i "ps -ef|grep tomcat|grep -E \"$trade\"|grep -v grep|awk '{print \$2}'|xargs kill -9"
        done

;;

        *)
            echo " 非依赖程序，继续回滚 "
esac

$path "ps -ef|grep  "$1"|grep -v grep|awk '{print \$2}'|xargs kill -9"

echo =============================开始回滚==============================
#指定版本进行回滚
#$path "cd /data/trade/realapp/$1 && git log|grep -B 5 $3 |grep commit|head -1|awk '{print \$2}'|xargs git revert"
#	if [ $? !=0 ]; then
#		echo "-1,回滚失败，日志完成"
#	fi

tomcatpath="cd /data/trade/realapp/$1"
$path "if [ \`$tomcatpath &&git log|grep -B 5 $3 |grep commit|wc -l\` -eq "1" ]; then $tomcatpath &&git log|grep -B 5 $3 |grep commit|awk '{print \$2}'|xargs git revert ;else echo 此单号有多个版本号; fi "
if [ $? != 0 ]
        then
                echo "-1,git回滚文件失败"
                exit
fi

#程序启动，先起核心后前置
echo ==============================程序启动==============================
up="cd /data/trade/realapp/$1/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep "$1"|grep -v grep"

case $1 in
        manageserver)
	  $path "cd /data/trade/realapp/orgmanageserver/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep orgmanageserver|grep -v grep"
	  sleep 10
          $up
	  sleep 10
        for i in $ip
        do
          ssh -p 12525 trade@$i "cd /data/trade/realweb/tomcat_adminweb/ && BASH_ENV=/etc/profile bash quikstat.sh&& cd /data/trade/realweb/tomcat_orgweb/ && BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep tomcat|grep -E \"adminweb|orgweb\""
        done
;;

        orgmanageserver)
          $path "$up"
	  sleep 10
          $path "cd /data/trade/realapp/manageserver/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep manageserver|grep -v grep"
	  sleep 10
        for i in $ip
        do
          ssh -p 12525 trade@$i "cd /data/trade/realweb/tomcat_adminweb/ && BASH_ENV=/etc/profile bash quikstat.sh && cd /data/trade/realweb/tomcat_orgweb/ && BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep tomcat|grep -E \"adminweb|orgweb\""
        done
;;

        tradeserver)
          $path "$up"
	  sleep 10
        for i in $tradeip
        do
          ssh -p 12525 trade@$i "cd /data/trade/realweb/tomcat_tradeweb/ && BASH_ENV=/etc/profile bash quikstat.sh"
        done
,;;

        *)
          $path "$up"
          exit
esac

