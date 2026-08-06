#!/bin/bash

# Biến global
LOG_DIR="/var/log/nginx"
export LOG_DIR

check_disk() {
    local DISK=$(df -h "$1" | tail -1 | awk '{print $5}' | cut -d'%' -f1)
    if [ "$DISK" -gt "${DISK_THRESHOLD:-80}"  ]; then
        echo "Warning: Disk $1 over $DISK% (${DISK_THRESHOLD:-80}%)"
    else 
        echo "Disk $1 stable: $DISK%"
    fi
}

log_status() {
    local MESSAGE="$1"
    if [ -d "$LOG_DIR" ]; then
        echo "$(date): $MESSAGE" >> "$LOG_DIR/status.log"
    else 
        echo "Error: $LOG_DIR isnt exist" >&2
        exit 1
    fi
}

check_disk "/"
log_status "Check disk completely"

