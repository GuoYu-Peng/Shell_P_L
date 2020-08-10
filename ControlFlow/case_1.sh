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

		case $REPLY in
            0) echo "Program terminated."
			   exit
			   ;;
			1) echo "Hostname: $HOSTNAME"
			   uptime
			   ;;
			2) df -h
			   ;;
			3) if [[ $(id -u) -eq 0 ]]; then
			      echo "Home Space Utilization (All Users)"
				  du -sh /home/*
			   else
			      echo "Home Space Utilization ($USER)"
				  du -sh $HOME
			   fi
				  ;;
			*) echo "Invalid entry" >&2
			   exit 1
			   ;;
		esac
	sleep $DELAY
	done
	echo "Program terminated"

