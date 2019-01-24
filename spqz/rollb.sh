#!/bin/bash
#==================回滚二层脚本==================

#exec 1>>/data/log/roll_$3\.log
accountweb='192.168.10.167 172.20.10.11'
adminweb='192.168.10.165'
payweb='192.168.10.168'
orgweb='172.20.10.10 192.168.10.167'
quotationweb='192.168.10.165 172.20.10.11 172.20.10.13'
tradeweb='192.168.10.165 192.168.10.166 192.168.10.167 192.168.10.168 172.20.10.10 172.20.10.11 172.20.10.12 172.20.10.13'
webapi='172.20.10.12'
hfbank='122.144.131.59'
openapi='172.20.10.13'
case $1 in
        accountweb)
        service=$accountweb sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        adminweb)
        service=$adminweb sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	payweb)
        service=$payweb sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	orgweb)
        service=$orgweb sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	quotationweb)
        service=$quotationweb sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	tradeweb)
        service=$tradeweb sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
	webapi)
        service=$webapi sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        hfbank)
        service=$tradeweb sh /data/shell/spqz/rollback.sh $1 $2 $3
        if [ $? != 0 ]; then
             echo '-1,回滚失败,日志完成'
             exit
           else
             echo '0,回滚成功,日志完成'
        fi
;;
        openapi)
        service=$openapi sh /data/shell/spqz/rollback.sh $1 $2 $3
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
