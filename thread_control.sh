#!/bin/bash

# 控制并发数的函数
# 需要三个参数
# 1.操作类型
# 2.最大并发数
# 3.临时管道文件名称
# 
# 首先需要初始化: Op_thread init 30 "test.pipe"
# 使用时需要: 
# 	for xxxxxxxxx	;do 
# 		Op_thread delete
# 		{
# 			do sth. 
# 			Op_thread insert 
# 		}&
# 	done 
# 	wait

Op_thread(){
	local operation=$1
	local thread_num=$2
	local thread_file=$3
	case $operation in
		init)
			rm -rf $thread_file
			mkfifo $thread_file
			exec 9<>$thread_file
			for num in $(seq $thread_num);do
				echo " " 1>&9
			done
			;;
		insert)
			echo " " 1>&9
			;;
		delete)
			read -u 9
			;;
		close)
			exec 9<&-
			;;
	esac
}
