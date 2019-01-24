#!/bin/bash

#此脚本为发布系统发布总控脚本

#此脚本处于测试环境验证状态

#变量全局.设置前置核心名称
source /data/shell/.variable.sh
IFS=' '
#日志重定向
touch /data/log/post_$4\_$3\.log
echo "" > /data/log/post_$4\_$3\.log
exec 1>>/data/log/post_$4\_$3\.log 2>&1

if [ $4 == 1 ]
        then
                case $1 in
                        $ac|$ad|$ep|$or|$qu|$tr|$we)
                        sh '/data/shell/csqz/posttotal.sh' "$1" "$2" "$3" "$4"
                ;;
                        $fund|$bank|$man|$new|$orgman|$quer|$sch|$sess|$trade|$risk)
                        sh '/data/shell/cshx/posttotal.sh' "$1" "$2" "$3" "$4"
                ;;
                        *)
                        echo " The name of the program you entered is Error ！"  
                ;;
                esac
        elif [ $4 == 2 ]
                then
                        case $1 in
                                $ac|$ad|$ep|$or|$qu|$tr|$we)
                                sh '/data/shell/mnqz/posttotal.sh' "$1" "$2" "$3" "$4"
                        ;;
                               $fund|$bank|$man|$new|$orgman|$quer|$sch|$sess|$trade)
                                sh '/data/shell/mnhx/posttotal.sh' "$1" "$2" "$3" "$4"
                        ;;
                                *)
                                 echo " The name of the program you entered is Error ！"  
                        ;;
                        esac
        elif [ $4 == 3 ]
                then
                        case $1 in
                                $ac|$ad|$ep|$or|$qu|$tr|$we)
                                sh '/data/shell/hdqz/posttotal.sh' "$1" "$2" "$3" "$4"
                        ;;
                                $fund|$bank|$man|$new|$orgman|$quer|$sch|$sess|$trade)
                                sh '/data/shell/hdhx/posttotal.sh' "$1" "$2" "$3" "$4"
                        ;;
                                *)
                                 echo " The name of the program you entered is Error ！"  
                        ;;
                        esac
        elif [ $4 == 4 ]
                then
                        case $1 in
                                $ac|$ad|$ep|$or|$qu|$tr|$we)
                                sh '/data/shell/spqz/posttotal.sh' "$1" "$2" "$3" "$4"
                        ;;
                                $fund|$bank|$man|$new|$orgman|$quer|$sch|$sess|$trade)
                                sh '/data/shell/sphx/posttotal.sh' "$1" "$2" "$3" "$4"
                        ;;
                                *)
                                 echo " The name of the program you entered is Error ！"  
                        ;;
                        esac


fi
