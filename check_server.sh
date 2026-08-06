#!/bin/bash

# Danh sách server (thay bằng IP thật khi dùng SSH - bài 13)
SERVERS="server1 server2 server3"

for SERVER in $SERVERS
do
    echo "Kiểm tra $SERVER..."
    # Giả lập disk usage (thay bằng SSH thực tế sau)
    DISK=$((RANDOM % 100))  # Số ngẫu nhiên 0-99
    if [ $DISK -gt 80 ]; then
        echo "Cảnh báo: Disk trên $SERVER vượt $DISK% (ngưỡng 80%)"
    else
        echo "Disk trên $SERVER ổn: $DISK%"
    fi
done