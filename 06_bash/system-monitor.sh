#!/bin/bash

LOG_FILE="/home/vagrant/scripts/system-monitor.log"
INTERVAL=60

while true; do
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # CPU
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    
    # Memory
    mem_total=$(free -m | awk 'NR==2{print $2}')
    mem_used=$(free -m | awk 'NR==2{print $3}')
    mem_percent=$(awk "BEGIN {printf \"%.2f\", ($mem_used/$mem_total)*100}")
    
    # Disk
    disk_usage=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)
    
    echo "[$timestamp] CPU: ${cpu_usage}% | Memory: ${mem_percent}% (${mem_used}MB/${mem_total}MB) | Disk: ${disk_usage}%" >> "$LOG_FILE"
    
    sleep $INTERVAL
done
