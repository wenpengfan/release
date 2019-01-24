#!/bin/bash
#==================回滚二层脚本==================

#exec 1>>/data/log/roll_$3\.log
accountweb='192.168.15.165 192.168.15.166'
adminweb='192.168.15.165'
payweb='192.168.15.166'
orgweb='192.168.15.165'
quotationweb='192.168.15.166'
tradeweb='192.168.15.165'
webapi='172.20.10.13'
fundfbaofoo='192.168.15.166'
openapi='192.168.15.166'
case $1 in
        accountweb)
        service=$accountweb sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        adminweb)
        service=$adminweb sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	payweb)
        service=$payweb sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	orgweb)
        service=$orgweb sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	quotationweb)
        service=$quotationweb sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	tradeweb)
        service=$tradeweb sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	webapi)
        service=$webapi sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        fundfbaofoo)
        service=$fundfbaofoo sh /data/shell/mnqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        openapi)
        service=$openapi sh /data/shell/mnqz/rollback.sh $1 $2 $3
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
