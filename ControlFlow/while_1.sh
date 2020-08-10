#!/bin/bash
DELAY=3 # 常量一般用大写字母

while true; do
    clear
	# 使用 <<- 而不是 << 让 shell 忽略前面的 tab 缩进，然后将内容输入到 cat 的标准输入
	cat <<- _EOF_
	    Please Select:
		
		1. Display System Information
		2. Display Disk Space
		3. Display Home Space Utilization
		0. Quit

	_EOF_
	read -p "Enter selection [0-3] > "

	if [[ $REPLY =~ ^[0-3]$ ]]; then
	    if [[ $REPLY == 1 ]]; then
		    echo "Hostname: $HOSTNAME"
			uptime
			sleep $DELAY
			continue
		fi
		if [[ $REPLY == 2 ]]; then
		    df -h
			sleep $DELAY
			continue
		fi
		if [[ $REPLY == 3 ]]; then
		    # 可以将命令的输出作为变量，0 是超级用户 ID
		    if [[ $(id -u) -eq 0 ]]; then
			    echo "Home Space Utilization (All Users)"
				du -sh /home/*
			else
			    echo "Home Space Utilization ($USER)"
				du -sh $HOME
			fi
			sleep $DELAY
			continue
		fi
		if [[ $REPLY == 0 ]]; then
		    break
		fi
		else
		    echo "Invalid entry."
			sleep $DELAY
		fi
	done
	echo "Program terminated"

