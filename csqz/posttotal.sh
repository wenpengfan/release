#!/bin/bash
IFS=' '
post1=/data/shell/csqz/posted.sh
#post2=/tmp/shell/csqz/$1/posted30.3.sh
echo ==============================测试发布==========================================

#全局变量，设置服务所在服务器IP
acip='192.168.30.2'
adip='192.168.30.2'
epip='192.168.30.2'
orip='192.168.30.2'
quip='192.168.30.2'
trip='192.168.30.2'
weip='192.168.30.2'
fundfbaofoo='192.168.30.2'
openapi='192.168.30.2'
#if [ -n $2 ]
 #  then
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
			epayweb)
			service=$epip sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
		;;
			orgweb)
			service=$orip sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
		;;
			quotationweb)
			service=$quip sh $post1 "$1" "$2" "$3" "$4"
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
			webapi)
			service=$weip sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
                ;;
                        fundfbaofoo)
                        service=$fundfbaofoo sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
                ;;
                        openapi)
                        service=$openapi sh $post1 "$1" "$2" "$3" "$4"
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
  # else
   #   echo "-1,accountweb名不存在,日志完成"
    #  exit
#fi

