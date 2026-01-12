#!/bin/bash

URL="https://robotdreams.cc/uk"
LOG_FILE="/home/vagrant/scripts/rd-monitor.log"

while true; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    if curl -s -o /dev/null -w "%{http_code}" "$URL" | grep -q "200"; then
        echo "[$timestamp] $URL - OK" >> "$LOG_FILE"
    else
        echo "[$timestamp] $URL - FAILED" >> "$LOG_FILE"
    fi
    
    sleep 60
done
