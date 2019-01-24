#!/bin/bash
#此处ip为核心程序所依赖的前置的ip地址
ip='192.168.15.165'
tradeip='192.168.15.165'
#此处变量为前置核心程序所依赖的前置程序的名称
manages='adminweb|orgweb'
trade='tradeweb'

#判断文件是否存在
ssh -p 12525 trade@192.168.25.165 "ps -ef|grep tail |awk '{print \$2}'|xargs kill -9 "
cd /archiving
if [ -e $1$3 ]; then
   echo "0,发布开始"
else
   echo "-1,文件名不存在,日志完成"
   exit
fi

sleep 3

#判断环境是否正确
if [ $4 == 2 ]; then
   echo "===============环境为模拟=================="
else
   echo "===============0,环境未知==================="
   exit
fi

#开始备份源文件
echo =======================备份原程序文件==========================
ssh -p 12525 trade@192.168.25.165 "sh /data/trade/simulateapp/gitfabu.sh \"$1\" \"$2\" \"$3\""
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
	  #grep 加w参数精确匹配，防止误杀orgmanageserver导致下面报服务不存在
          ssh -p 12525 trade@192.168.25.165 "ps -ef|grep -w "manageserver"|grep -v grep|awk '{print \$2}'|xargs kill -9"
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
#grep 不加-w参数模糊匹配，
ssh -p 12525 trade@192.168.25.165 "ps -ef|grep "$1"|grep -v grep"
if [ $? != 0 ]; then 
   echo "$1 进程为关闭状态!"
else
   ssh -p 12525 trade@192.168.25.165 "ps -ef|grep  "$1"|grep -v grep|awk '{print \$2}'|xargs kill -9"
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
	rsync -vrPt /archiving/$1$3/$t -e 'ssh -p 12525'  trade@192.168.25.165:/data/trade/simulateapp/$1/$t
done
if [ $? != 0 ]
	then
		echo '-1,发布失败,日志完成'
		exit
fi

#程序启动，先起核心后前置
echo ==============================程序启动==============================
up="cd /data/trade/simulateapp/$1/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep "$1"|grep -v grep"

case $1 in
        manageserver)
         ssh -p 12525 trade@192.168.25.165 "cd /data/trade/simulateapp/orgmanageserver/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep orgmanageserver|grep -v grep"
	 sleep 10
         ssh -p 12525 trade@192.168.25.165 "$up"
	 sleep 10
         for i in $ip
         do
	   ssh -p 12525 trade@$i "cd /data/trade/simulateweb/tomcat_adminweb/ && BASH_ENV=/etc/profile bash  quikstat.sh && cd /data/trade/simulateweb/tomcat_orgweb/ && BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep tomcat|grep -E \"adminweb|orgweb\""
         done
;;

        orgmanageserver)
          ssh -p 12525 trade@192.168.25.165 "$up"
	  sleep 10
	  ssh -p 12525 trade@192.168.25.165 "cd /data/trade/simulateapp/manageserver/ &&BASH_ENV=/etc/profile bash start.sh && ps -ef|grep manageserver|grep -v grep"
	  sleep 10
          for i in $ip
          do
            ssh -p 12525 trade@$i "cd /data/trade/simulateweb/tomcat_adminweb/ && BASH_ENV=/etc/profile bash  quikstat.sh && cd /data/trade/simulateweb/tomcat_orgweb/ && BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep tomcat|grep -E \"adminweb|orgweb\""
          done
;;

        tradeserver)
          ssh -p 12525 trade@192.168.25.165 "$up"
	  sleep 10
          for i in $tradeip
          do
            ssh -p 12525 trade@$i "BASH_ENV=/etc/profile bash /data/trade/simulateweb/tomcat_tradeweb/quikstat.sh"
          done
,;;

        *)
          ssh -p 12525 trade@192.168.25.165 "$up"
esac

#git保存版本
ssh -p 12525 trade@192.168.25.165 "cd /data/trade/simulateapp/$1/ && git add . && git commit -m "$3""
