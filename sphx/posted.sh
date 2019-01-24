#!/bin/bash
#此处ip为核心程序所依赖的前置的ip地址
ip='192.168.10.165 172.20.10.10 192.168.10.167'
tradeip='192.168.10.165 192.168.10.166 192.168.10.167 192.168.10.168 172.20.10.10 172.20.10.11 172.20.10.12 172.20.10.13'
#此处变量为前置核心程序所依赖的前置程序的名称
manages='adminweb|orgweb'
trade='tradeweb'

path='ssh -p 12525 trade@172.20.20.10'
#判断文件是否存在
$path "ps -ef|grep tail |awk '{print \$2}'|xargs kill -9"
cd /archiving

if [ -e $1$3 ]; then
   echo "0,发布开始"
else
   echo "-1,文件名不存在,日志完成"
   exit
fi

sleep 3

#判断环境是否正确
if [ $4 == 4 ]; then
   echo "===============环境为实盘=================="
else
   echo "===============0,环境未知==================="
   exit
fi

#开始备份源文件
echo =======================备份原程序文件==========================
$path "sh /data/trade/realapp/gitfabu.sh \"$1\" \"$2\" \"$3\""
if [ $? != 0 ]
        then
                echo "-1,备份源文件失败,日志完成"
		exit
fi
sleep 3

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
	  ssh -p 12525 trade@$i "ps -ef|grep tomcat|grep -E \"$trade\"|grep -v grep"
		if [ $? != 0 ]; then
                   echo "前置依赖进程为关闭状态!"
                else
		   ssh -p 12525 trade@$i "ps -ef|grep tomcat|grep -E \"$trade\"|grep -v grep|awk '{print \$2}'|xargs kill -9"
                        if [ $? != 0 ]; then
                           echo "-1,前置依赖关闭进程失败,日志完成"
                           exit
                        fi
                fi
	done
;;

	*)
	    echo "非依赖程序，迭代继续！"
esac

#判断需要迭代的程序状态
$path "ps -ef|grep "$1"|grep -v grep"
if [ $? != 0 ]; then 
   echo "$1 进程为关闭状态!"
else
   $path "ps -ef|grep  "$1"|grep -v grep|awk '{print \$2}'|xargs kill -9"
	if [ $? != 0 ]; then
           echo "-1,$1 关闭进程失败,日志完成"
           exit
	fi
fi

sleep 3

#开始发布代码
echo ===========================开始发布=============================
web=($2)
for t in ${web[@]}
do
	rsync -vrPt /archiving/$1$3/$t -e 'ssh -p 12525'  trade@172.20.20.10:/data/trade/realapp/$1/$t
done
if [ $? != 0 ]
	then
		echo '-1,发布失败,日志完成'
		exit
fi

#程序启动，先起核心后前置
echo ==============================程序启动==============================
up="cd /data/trade/realapp/$1/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep "$1"|grep -v grep"

case $1 in
        manageserver)
          $path "cd /data/trade/realapp/orgmanageserver/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep orgmanageserver|grep -v grep"
	  sleep 10
          $path "$up"
	  sleep 10
        for i in $ip
        do
          ssh -p 12525 trade@$i "cd /data/trade/realweb/tomcat_adminweb/ && BASH_ENV=/etc/profile bash quikstat.sh && cd /data/trade/realweb/tomcat_orgweb/ && BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep tomcat|grep -E \"adminweb|orgweb\""
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
          ssh -p 12525 trade@$i "cd /data/trade/realweb/tomcat_tradeweb/ && BASH_ENV=/etc/profile bash quikstat.sh&& ps -ef|grep tomcat_tradeweb|grep -v grep"
        done
;;
        *)
          $path "$up"
esac

#git保存版本
$path "cd /data/trade/realapp/$1/ && git add . && git commit -m "$3""
