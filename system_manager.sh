#!/bin/bash

set -e
trap 'echo "Error at line $LINENO: $BASH_COMMAND" >&2; exit 1' ERR

LOG_FILE="system_manager.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
CPU_THRESHOLD=${CPU_THRESHOLD:-90}
RAM_THRESHOLD=${RAM_THRESHOLD:-80}

log(){
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE" 2>/dev/null || {
        echo "Cannot write log" >&2
        exit
    }
}

check_cpu(){
    local CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    if [ $(echo "$CPU > $CPU_THRESHOLD" | bc) -eq 1 ]; then
        log "Warning: CPU over $CPU%"

        TOP_PID=$(ps -eo,%cpu,cmd --sort=-%cpu | head -n 2 | tail -n 1 | awk '{print $1}')
        log "Kill process $TOP_PID"
        kill -9 "$TOP_PID" 2>/dev/null || log "Cannot kill $TOP_PID"

    else
        log "CPU stable: $CPU%"
    fi
}

check_ram(){
    local RAM=$(free -m | grep "Mem:" | awk '{print $3/$2 * 100}')
    if [ $(echo "$RAM > $RAM_THRESHOLD" | bc) -eq 1 ]; then
        log "Warning: RAM over $RAM%"
    else
        log "RAM stable: $RAM%"
    fi
}

check_cpu
check_ram
