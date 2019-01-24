#!/bin/bash
#==================回滚二层脚本==================

#exec 1>>/data/log/roll_$3\.log
accountweb='172.20.10.14'
adminweb='172.20.10.14'
tradeweb='172.20.10.14'
fundbaofoo='172.20.10.14'
fundweb='172.20.10.14'
case $1 in
        accountweb)
        service=$accountweb sh /data/shell/hdqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        adminweb)
        service=$adminweb sh /data/shell/hdqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	tradeweb)
        service=$tradeweb sh /data/shell/hdqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        fundfbaofoo)
        service=$fundfbaofoo sh /data/shell/hdqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	*)
	echo " The name of the program you entered is Error ！"
;;
esac
