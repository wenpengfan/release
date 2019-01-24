#!/bin/bash
#此脚本为回滚系统总控脚本
#此脚本处于测试环境验证状态
source /data/shell/.variable.sh
#日志重定向
touch /data/log/roll_$2\_$3\.log
echo "" > /data/log/roll_$2\_$3\.log
exec 1>>/data/log/roll_$2\_$3\.log 2>&1

#判断环境，按照环境选择对应变量1的脚本。
if [ $2 == 1 ]
	then
		case $1 in
			$ac|$ad|$ep|$or|$qu|$tr|$we)
                        sh '/data/shell/csqz/rollb.sh' "$1" "$2" "$3"
                ;;
                        $bank|$man|$new|$orgman|$quer|$sch|$sess|$trade)
                        sh '/data/shell/cshx/rollback.sh' "$1" "$2" "$3"
                        if [ $? != 0 ];then
                        	echo "-1,回滚文件失败,日志完成"
                        	exit
                           else
                                echo "0,回滚成功,日志完成"
                        fi
                ;;
                        *)
                        echo " The name of the program you entered is Error ！"  
                ;;
                esac
        elif [ $2 == 2 ]
                then
                        case $1 in
                                $ac|$ad|$ep|$or|$qu|$tr|$we)
                                sh '/data/shell/mnqz/rollb.sh' "$1" "$2" "$3"
                        ;;
                                $bank|$man|$new|$orgman|$quer|$sch|$sess|$trade)
                                sh '/data/shell/mnhx/rollback.sh' "$1" "$2" "$3"
        	                if [ $? != 0 ];then
	                                echo "-1,回滚文件失败,日志完成"
                	                exit
                	           else
                	                echo "0,回滚成功,日志完成"
                	        fi
                        ;;
                                *)
                                 echo " The name of the program you entered is Error ！"  
                        ;;
                        esac
        elif [ $2 == 3 ]
                then
                        case $1 in
                                $ac|$ad|$tr|$fund)
                                sh '/data/shell/hdqz/rollb.sh' "$1" "$2" "$3"
                        ;;
                                $bank|$man|$new|$orgman|$quer|$sch|$sess|$trade)
                                sh '/data/shell/hdhx/rollback.sh' "$1" "$2" "$3"
                                if [ $? != 0 ];then
                                        echo "-1,回滚文件失败,日志完成"
                                        exit
                                   else
                                        echo "0,回滚成功,日志完成"
                                fi
                        ;;
                                *)
                                 echo " The name of the program you entered is Error ！"  
                        ;;
                        esac
        elif [ $2 == 4 ]
                then
                        case $1 in
                                $ac|$ad|$ep|$or|$qu|$tr|$we)
                                sh '/data/shell/spqz/rollb.sh' "$1" "$2" "$3"
                        ;;
                                $bank|$man|$new|$orgman|$quer|$sch|$sess|$trade)
                                sh '/data/shell/sphx/roll.sh' "$1" "$2" "$3"
                                if [ $? != 0 ];then
                                        echo "-1,回滚文件失败,日志完成"
                                        exit
                                   else
                                        echo "0,回滚成功,日志完成"
                                fi
                        ;;
                                *)
                                 echo " The name of the program you entered is Error ！"  
                        ;;
                        esac

fi
