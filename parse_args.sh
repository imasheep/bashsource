#!/bin/bash

# 解析参数的函数 
# 需要两个参数 
# 1. 命令行传入的所有参数当做函数的第一个参数传入,注意引号, 比如 "-o add -p test -a main" 
# 2. 希望解析参数后赋值的变量 "operation|product|action" 
# 例 Parse_args " -o add -p test -a main"  "operation|product|action" 
# 如按例调用函数, 则会产生operation product action三个全局变量,value分别为,add ,test, main 
# 映射关系为首字母对应,如operation会对应 -o 后面的value, 注意变量首字母不要重复


Parse_args(){
    local args="$1"
    local arg_name="$2"
    eval $(awk -vArgs_name="$arg_name" -vArgs="$args" '
        BEGIN{
            split(Args_name,arg_array,"|")
            for(idx in arg_array){
                match(Args,"-"substr(arg_array[idx],0,1)" ?([^ -]+)",tmp_array)
                print arg_array[idx]"="tmp_array[1]
            }
        }
    ')
}
