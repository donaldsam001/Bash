#!/bin/bash

LOG_FILE="system_log.txt"

if [ -f "$LOG_FILE" ]; then
    echo "phan tich $LOG_FILE"
    while read LINE
    do 
        if echo "$LINE" | grep -q "Cảnh báo"; then
            echo "Tim thay loi: $LINE"
        fi
    done < "$LOG_FILE"
else 
    echo "Khong tim thay file log: $LOG_FILE"
fi