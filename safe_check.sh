#!/bin/bash

# setup error handling
set -e # exit when an error occur
trap 'echo "Error at line $LINENO: $BASH_COMMAND" >&2; exit 1' ERR
trap 'echo "Script done"' EXIT

# Variable
LOG_FILE="safe_check.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Write log
log() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE" 2>/dev/null || {
        echo "Log cannot be written $LOG_FILE" >&2
        exit 1
    }
}

# Check disk
DISK=$(df -h / | tail -1 | awk '{print $5}' | cut -d'%' -f1) || {
    echo "Error when check disk" >&2
    exit 1
}
if [ "$DISK" -gt 80 ]; then
    log "Warning: Disk over $DISK%"
else
    log "Disk stable: $DISK%"
fi

# check file does not exist
cat /nonexistent/file
log "Check done"
