#!/bin/bash

post1=/data/shell/mnqz/posted.sh
echo ==============================测试发布==========================================

#全局变量，设置服务所在服务器IP
accountweb='192.168.15.165 192.168.15.166'
adminweb='192.168.15.165'
payweb='192.168.15.166'
orgweb='192.168.15.165'
quotationweb='192.168.15.166'
tradeweb='192.168.15.165 192.168.15.166'
webapi='172.20.10.13'
fundfbaofoo='192.168.15.166'
openapi='192.168.15.166'

#if [ -n $2 ]
#   then
      if [ $4 -gt 0 ]
        then
	  if [ $3 -gt 0 ]
	     then
		case $1 in
                        accountweb)
                        service=$accountweb sh $post1 "$1" "$2" "$3" "$4"
			    if [ $? != 0 ]
                                then 
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
                ;;
                        adminweb)
                        service=$adminweb sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
		
		;;
			payweb)
			service=$payweb sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
		;;
			orgweb)
			service=$orgweb sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
		;;
			quotationweb)
			service=$quotationweb sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
		;;
			tradeweb)
			service=$tradeweb sh $post1 "$1" "$2" "$3" "$4"
                            if [ $? != 0 ]
                                then
                                     echo '-1,发布失败,日志完成'
                                     exit
                                else
                                     echo '0,发布成功,日志完成'
                            fi
		;;
			webapi)
			service=$webapi sh $post1 "$1" "$2" "$3" "$4"
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
#   else
#      echo "-1,accountweb名不存在,日志完成"
#      exit
#fi

