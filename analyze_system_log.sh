#!/bin/bash

LOG_FILE="system_log.txt"

# Kiểm tra file
if [ ! -f "$LOG_FILE" ]; then
    echo "Không tìm thấy $LOG_FILE"
    exit 1
fi

# grep
echo "Errors in log: "
grep "ERROR" "$LOG_FILE"

# awk
echo "List usage: "
awk '/usage/ {print $5}' "$LOG_FILE"

# sed
echo "change ERROR to WARNING:"
sed 's/ERROR/WARNING/' "$LOG_FILE"

sed 's/ERROR/WARNING/' "$LOG_FILE" > "proccessed_log.txt"
echo "Log was processed and save to proccessed_log.txt"


# get IP make fail
grep " 500 " /var/log/nginx/access.log | awk '{print $1}'
