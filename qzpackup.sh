#!/bin/bash
IFS=' '
cd /home/git.git/tradedev/project/$1/
#git pull --rebase origin master 

if [ $? -eq 0 ]
       then
               echo "0,pull成功"
       else
               echo "-1,pull失败,日志完成"
	       exit
fi

echo ==================进入 $1 目录=========================
dabao=/home/git.git/tradedev/project/$1/dist/$1
cd /home/git.git/tradedev/project/$1
i=`pwd`
if [ -e $i ] ;then
     	  echo $i
     	 # mvn clean package >>/dev/null
            if [ $? -eq 0 ] ;then
                	echo "0,mvn成功"
			mkdir -p /archiving/$1$3 && cd $dabao && cp --parents -rf $2 /archiving/$1$3		
				if [ $? -ne 0 ] ;then
					echo '-1,打包失败,日志完成'
				else
					echo '0,打包成功,日志完成'
				fi
               else
               		echo "-1,mvn失败,日志完成"
               		exit
             fi
      else
      	  echo "$1下无文件,日志完成"
      exit
fi

