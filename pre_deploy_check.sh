#!bin/bash

set -e
trap 'echo "Error at line $LINENO: $BASH_COMMAND" >&2; exit 1' ERR

DISK_THRESHOLD=${DISK_THRESHOLD:-80}
DEPLOY_ENV=${CI_ENVIRONMENT_NAME:-"dev"}

check_disk(){
    local DISK=$(df -h / | tail -1 | awk '{print $5}' | cut -d'%' -f1)
    if [ "$DISK" -gt "$DISK_THRESHOLD" ]; then
        echo "Warning: Disk over $DISK%" >&2
        exit 1
    else
        echo "Disk stable: $DISK%"
    fi
}

check_version(){
    if [ -z "$CI_COMMIT_TAG" ]; then
        echo "No tag, just deploy dev/test" >&2
        if [ "$DEPLOY_ENV" != "dev" ] && [ "$DEPLOY_ENV" != "test" ]; then
            exit 1
        fi
    else
        echo "Tag: $CI_COMMIT_TAG, Ok $DEPLOY_ENV"
    fi

}

check_disk
check_version

echo "Finish check, already deploy"