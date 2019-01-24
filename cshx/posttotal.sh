#!/bin/bash
source /data/shell/.variable.sh
post1=/data/shell/cshx/posted.sh
#if [ -n $2 ]; then
  if [ $4 -gt 0 ]; then
    if [ $3 -gt 0 ]; then
         case $1 in
              $man|$fund|$bank|$new|$orgman|$quer|$sch|$sess|$trade|$risk)
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
