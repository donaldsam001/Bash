#!/bin/bash

# Biến
LOG_FILE="system_log.txt"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Ghi thông tin hệ thống vào log
echo "[$TIMESTAMP] Kiểm tra hệ thống..." > $LOG_FILE
echo "Hostname: $(hostname)" >> $LOG_FILE
echo "Disk usage: $(df -h / | tail -1 | awk '{print $5}')" >> $LOG_FILE
echo "CPU usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%" >> $LOG_FILE

DISK=$(df -h / | tail -1 | awk '{print $5}' | cut -d'%' -f1)
if [ $DISK -gt 20 ]; then 
    echo "[$TIMESTAMP] Cảnh báo: Dung lượng đĩa vượt quá 20%!" >> $LOG_FILE
fi

echo "Noi dung log: "
cat $LOG_FILE