#!/bin/bash
source /data/shell/.variable.sh
post1=/data/shell/sphx/posted.sh
#if [ -n $2 ]; then
  if [ $4 -gt 0 ]; then
    if [ $3 -gt 0 ]; then
	case $1 in
        	bankprocessor)
                	sh /data/shell/sphx/bankposted.sh "$1" "$2" "$3" "$4"
	                if [ $? != 0 ];then
                   	     echo "-1,发布失败.日志完成"
                             exit
                        else
                      	     echo "0,发布成功.日志完成"
           		fi
       	;;
     		smsserver)
                	sh /data/shell/sphx/smsposted.sh "$1" "$2" "$3" "$4"
                        if [ $? != 0 ];then
                             echo "-1,发布失败.日志完成"
                             exit
                        else
                             echo "0,发布成功.日志完成"
                        fi
       	;;
        	sessionserver)
       		        sh /data/shell/sphx/sesposted.sh "$1" "$2" "$3" "$4"
                        if [ $? != 0 ];then
                             echo "-1,发布失败.日志完成"
                             exit
                        else
                             echo "0,发布成功.日志完成"
                        fi
	;;
        	fundserver)
        	        sh /data/shell/sphx/sesposted.sh "$1" "$2" "$3" "$4"
                        if [ $? != 0 ];then
                             echo "-1,发布失败.日志完成"
                             exit
                        else
                             echo "0,发布成功.日志完成"
                        fi
	;;
		$man|$new|$orgman|$quer|$sch|$trade|$risk)
			sh $post1 "$1" "$2" "$3" "$4"
                        if [ $? != 0 ];then
                             echo "-1,发布失败.日志完成"
                             exit
                        else
                             echo "0,发布成功.日志完成"
                        fi
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
