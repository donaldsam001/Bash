#!/bin/bash

## ________________________________________
# ls /nonexistent

# if [ $? -ne 0 ]; then
#     # echo when the previous command error
#     echo "Error command"
# fi


# #____________EXIT WHEN ERROR___________

# set -e
# ls /nonexistent
# echo "It does not run to here"


## ____________TRAP______________________
# The trap mechanism is triggered when an error occurs.
# trap 'echo "Error"' ERR

# ls /nonexistent
# echo "Continue"

# # The trap mechanism is triggered when program exit.
# trap 'echo "End"' EXIT

##___________________RETRY LOGIC_________________
COUNT=0
MAX_TRIES=3
until ls /nonexistent || [ $COUNT -ge $MAX_TRIES ]
do
    COUNT=$((COUNT + 1))
    echo "Test $COUNT..."
    sleep 1
done