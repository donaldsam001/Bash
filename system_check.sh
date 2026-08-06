#!/bin/bash

# Hàm kiểm tra disk
check_disk() {
    local DISK=$(df -h "$1" | tail -1 | awk '{print $5}' | cut -d'%' -f1)
    if [ $DISK -gt 80 ]; then
        echo "Warning: Disk $1 over $DISK (80%)"
    else 
        echo "Disk $1 stable: $DISK%"
    fi
}

# check CPU
check_cpu() {
    local CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    if [ $(echo "$CPU > $1" | bc) -eq 1 ]; then
        echo "Warning: CPU over $CPU% ($1%)"
    else 
        echo "CPU stable: $CPU%"
    fi
}

log_result() {
    local TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] $1" >> "system_log.txt"
}

# call function
check_disk "/tmp"
check_cpu 90
log_result "Check completely on $(hostname)"