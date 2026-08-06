#!/bin/bash

# Giả lập kiểm tra service (thay bằng lệnh thực tế như 'systemctl')
COUNT=0
MAX_WAIT=10

while [ $COUNT -lt $MAX_WAIT ]
do
    if [ $((RANDOM % 2)) -eq 1 ]; then  # Giả lập service chạy
        echo "Service đã chạy sau $COUNT giây!"
        exit 0
    fi
    echo "Đợi service... ($COUNT/$MAX_WAIT)"
    COUNT=$((COUNT + 1))
    sleep 1
done

echo "Timeout: Service không chạy sau $MAX_WAIT giây"
exit 1