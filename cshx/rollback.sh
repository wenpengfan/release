#!/bin/bash

#此处ip为核心程序所依赖的前置的ip地址
ip='192.168.30.2 192.168.30.3'
tradeip='192.168.30.2'
#此处变量为前置核心程序所依赖的前置程序的名称
manages='adminweb|orgweb'
trade='tradeweb'

echo ========================关闭进程=============================
#判断程序，关闭其依赖程序，所依赖的前置程序用FOR循环批量停止
case $1 in
        manageserver)
        for i in $ip
        do
          ssh trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep"
                if [ $? != 0 ]; then
                   echo "前置依赖进程为关闭状态!"
                else
                   ssh trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep|awk '{print \$2}'|xargs kill -9"
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
          ssh trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep"
                if [ $? != 0 ]; then
                   echo "前置依赖进程为关闭状态!"
                else
                   ssh trade@$i "ps -ef|grep tomcat|grep -E \"$manages\"|grep -v grep|awk '{print \$2}'|xargs kill -9"
          
              if [ $? != 0 ]; then
                           echo "-1,前置依赖关闭进程失败,日志完成"
                           exit
                        fi
                fi
        done
          ssh trade@192.168.30.4 "ps -ef|grep  "manageserver"|grep -v grep|awk '{print \$2}'|xargs kill -9"
;;

        tradeserver)
        for i in $tradeip
        do
          ssh trade@$i "ps -ef|grep tomcat|grep -E \"$trade\"|grep -v grep|awk '{print \$2}'|xargs kill -9"
        done

;;

        *)
            echo " 非依赖程序，继续回滚 "
esac

ssh trade@192.168.30.4 "ps -ef|grep  "$1"|grep -v grep|awk '{print \$2}'|xargs kill -9"

echo =============================开始回滚==============================
#指定版本进行回滚
#ssh trade@192.168.30.4 "cd /data/trade/testapp/$1 && git log|grep -B 5 $3 |grep commit|head -1|awk '{print \$2}'|xargs git revert"
#	if [ $? !=0 ]; then
#		echo "-1,回滚失败，日志完成"
#	fi

path="cd /data/trade/testapp/$1"
ssh trade@192.168.30.4 "if [ \`$path &&git log|grep -B 5 $3 |grep commit|wc -l\` -eq "1" ]; then $path &&git log|grep -B 5 $3 |grep commit|awk '{print \$2}'|xargs git revert ;else echo "$1程序内此单号有多个版本号" exit; fi "

#程序启动，先起核心后前置
echo ==============================程序启动==============================
up="cd /data/trade/testapp/$1/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep "$1"|grep -v grep"

case $1 in
        manageserver)
	  ssh -p 12525 trade@192.168.25.165 "cd /data/trade/simulateapp/orgmanageserver/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep orgmanageserver|grep -v grep"
	  sleep 10
          ssh trade@192.168.30.4 $up
	  sleep 10
        for i in $ip
        do
          ssh trade@$i "cd /data/trade/testweb/tomcat_adminweb/ && BASH_ENV=/etc/profile bash quikstat.sh && cd /data/trade/testweb/tomcat_orgweb/ && BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep tomcat|grep -E \"adminweb|orgweb\""
        done
;;

        orgmanageserver)
          ssh trade@192.168.30.4 "$up"
	  sleep 10
          ssh trade@192.168.30.4 "cd /data/trade/testapp/manageserver/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep manageserver|grep -v grep"
	  sleep 10
        for i in $ip
        do
          ssh trade@$i "cd /data/trade/testweb/tomcat_adminweb/ && BASH_ENV=/etc/profile bash quikstat.sh && cd /data/trade/testweb/tomcat_orgweb/ && BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep tomcat|grep -E \"adminweb|orgweb\""
        done
;;

        tradeserver)
          ssh trade@192.168.30.4 "$up"
	  sleep 10
        for i in $tradeip
        do
          ssh trade@$i "cd /data/trade/testweb/tomcat_tradeweb/ && BASH_ENV=/etc/profile bash quikstat.sh"
        done
,;;

        *)
          ssh trade@192.168.30.4 "$up"
          exit
esac

