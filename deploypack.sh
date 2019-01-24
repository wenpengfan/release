#!/bin/bash
#此脚本为发布系统打包总控脚本

#此脚本处于测试环境验证状态

#此变量为前置核心名称
source /data/shell/.variable.sh
#日志重定向
IFS=' '
touch /data/log/pack_$3\.log
echo "" >  /data/log/pack_$3\.log
exec 1>>/data/log/pack_$3\.log 2>&1

if [ -n $1 ]; then
	echo "============打包程序开始============"
        #if [ -n $2 ]; then
                if [ $3 -gt 0 ]; then
                        case $1 in
				$ac|$ad|$ep|$or|$qu|$tr|$we)
				sh '/data/shell/qzpackup.sh' "$1" "$2" "$3"
				echo aaa
			;;
				$fund|$bank|$man|$new|$orgman|$quer|$sch|$sess|$trade|$risk)
				sh '/data/shell/hxpackup.sh' "$1" "$2" "$3"
			;;
				*)
				echo " The name of the program you entered is Error ！"
			;;
			esac
                 else
		        echo '-1,Orderid错误,日志完成'
                        exit 1
                 fi
        #else
         # echo "-1,Filenames错误，日志完成"
          #exit 1
        #fi
else
   echo "-1,Modulename错误，日志完成"
   exit 1
fi

