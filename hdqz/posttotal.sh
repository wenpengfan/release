#!/bin/bash

post1=/data/shell/hdqz/posted.sh
echo ==============================测试发布==========================================

#设置服务所在服务器IP
acip='172.20.10.14'
adip='172.20.10.14'
trip='172.20.10.14'
fundbaofoo='172.20.10.14'
fundweb='172.20.10.14'
if [ $4 -gt 0 ]
   then
   if [ $3 -gt 0 ]
   then
	case $1 in
	        accountweb)
                service=$acip sh $post1 "$1" "$2" "$3" "$4"
		    if [ $? != 0 ]
                       then 
 	                   echo '-1,发布失败,日志完成'
                       exit
                       else
                           echo '0,发布成功,日志完成'
                     fi
        ;;
                adminweb)
                service=$adip sh $post1 "$1" "$2" "$3" "$4"
                    if [ $? != 0 ]
                       then
                           echo '-1,发布失败,日志完成'
                       exit
                       else
                           echo '0,发布成功,日志完成'
                     fi
		
	;;
		tradeweb)
		service=$trip sh $post1 "$1" "$2" "$3" "$4"
                    if [ $? != 0 ]
                       then
                           echo '-1,发布失败,日志完成'
                       exit
                       else
                           echo '0,发布成功,日志完成'
                    fi
	;;
		fundbaofoo)
		service=$fundbaofoo sh $post1 "$1" "$2" "$3" "$4"
                    if [ $? != 0 ]
                       then
                           echo '-1,发布失败,日志完成'
                       exit
                       else
                           echo '0,发布成功,日志完成'
                    fi
	;;
		fundweb)
		service=$fundweb sh $post1 "$1" "$2" "$3" "$4"
                    if [ $? != 0 ]
                       then
                           echo '-1,发布失败,日志完成'
                       exit
                       else
                           echo '0,发布成功,日志完成'
                    fi
	;;
		 *)
		 echo  " The name of the program you entered is Error ！"
	;;
			esac
	    else
	       echo "-1,时间戳不存在,日志完成"
	       exit
	    fi
   else
   	echo "-1,环境编号不存在,日志完成"
   	exit
fi
