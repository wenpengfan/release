#!/bin/bash

#exec 1>>/tmp/log/post_$4\_$3\.log
for i in $service; do
cd /archiving
if [ -e $1$3 ]
        then
                echo "0,发布开始"
        else
                echo "-1,文件名不存在,日志完成"
                exit 1
fi
sleep 3
if [ $4 == 1 ]
        then
                echo "===============环境为测试=================="
        else
                echo "===============0,环境未知==================="
                exit 1
fi

echo =======================备份原程序文件==========================
ssh trade@$i "rm -rf /home/trade/backup/$1$3/ && mkdir -p /home/trade/backup/$1$3/ && cp -af /data/trade/testweb/tomcat_$1/webapps/$1 /home/trade/backup/$1$3/"
if [ $? != 0 ]
        then
                echo "-1,备份源文件失败,日志完成"
		exit 1
fi
sleep 3

echo ========================关闭进程=============================
ssh trade@$i "ps -ef|grep -w "tomcat_$1"|grep -v grep"
if [ $? != 0 ]
	then 
		echo '进程为关闭状态!'
	else
		ssh trade@$i "ps -ef|grep -w "tomcat_$1"|grep -v grep|awk '{print \$2}'|xargs kill -9"
			if [ $? != 0 ]
        			then
        			        echo "-1,关闭进程失败,日志完成"
					exit 1
			fi
fi

sleep 3

echo ===========================开始发布=============================
IFS=' '
web=($2)
for t in ${web[@]}
do
	rsync -vrPt /archiving/$1$3/$t -e 'ssh -p 22'  trade@$i:/data/trade/testweb/tomcat_$1/webapps/$1/$t
done
if [ $? != 0 ]
	then
		echo '-1,发布失败,日志完成'
		exit
fi
echo ===========================程序启动=============================
ssh trade@$i "cd /data/trade/testweb/tomcat_$1 &&BASH_ENV=/etc/profile bash quikstat.sh && ps -ef|grep -w "tomcat_$1"|grep -v grep|awk '{print \$2}'"
if [ -z $? ]
        then
                echo '-1,程序启动失败,日志完成'
        else
                echo '0,成功'
fi

ssh trade@$i "cd /data/trade/testweb/tomcat_$1/webapps/$1/ && git add . && git commit -m "$3""
sleep 3
done
