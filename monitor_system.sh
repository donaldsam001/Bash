#!/bin/bash

# Biến
# LOG_FILE="/var/log/system_monitor.log"
LOG_FILE="/home/donaldsam/Downloads/DevOps/Bash/system_monitor.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# check disk
check_disk() {
    local DISK=$(df -h "/" | tail -1 | awk '{print $5}' | cut -d'%' -f1 )
    if [ "$DISK" -gt "${DISK_THRESHOLD:-80}" ]; then
        echo "[$TIMESTAMP] Warning: Disk $DISK% ()" >> "$LOG_FILE"
    else
        echo "[$TIMESTAMP] Disk stable: $DISK% ()" >> "$LOG_FILE"
    fi
}

# check cpu
check_cpu() {
    local CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    if [ $(echo "CPU > ${CPU_THRESHOLD:-90}" | bc) -eq 1 ]; then
        echo "[$TIMESTAMP] Warning: $CPU% (ngưỡng ${CPU_THRESHOLD:-90}%)" >> "$LOG_FILE"
    else 
        echo "[$TIMESTAMP] CPU stable: $CPU%" >> "$LOG_FILE"
    fi
}

check_disk
check_cpu