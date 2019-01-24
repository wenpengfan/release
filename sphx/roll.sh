#!/bin/bash
source /data/shell/.variable.sh
post1=/data/shell/sphx/rollback.sh
#if [ -n $2 ]; then
  if [ $4 -gt 0 ]; then
    if [ $3 -gt 0 ]; then
	case $1 in
        	bankprocessor)
                	sh /data/shell/sphx/bankroll.sh "$1" "$2" "$3"
       	;;
     		smsserver)
                	sh /data/shell/sphx/smsroll.sh "$1" "$2" "$3"
       	;;
        	sessionserver)
       		        sh /data/shell/sphx/sesroll.sh "$1" "$2" "$3"
	;;
        	fundserver)
        	        sh /data/shell/sphx/sesroll.sh "$1" "$2" "$3"
	;;
		$man|$new|$orgman|$quer|$sch|$trade|$risk)
			sh $post1 "$1" "$2" "$3" "$4"
      	;;
                *)
              echo " The name of the program you entered is Error ！"  
        ;;
         esac
        echo '0,发布成功,日志完成'
    else
        echo "-1,时间戳不存在,日志完成"
        exit
    fi
  else
     echo "-1,环境编号不存在,日志完成"
     exit
  fi
#else
#  echo "-1,路径不存在,日志完成"
#  exit
#fi
