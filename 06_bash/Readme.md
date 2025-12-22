## Bash Scripting Tasks

### Task 1: Automated Backup Script with Cron
Create a simple Bash script for automatic backup of the `/home/user/data` directory to `/home/user/backup` every day. Configure a cron job to execute this script daily at 2:00 AM.

## Step 1: Create the Backup Script
- Create folder scripts and open it: `mkdir -p ~/scripts && cd ~/scripts`
- Create script `nano backup_script.sh` with the following content:
```bash
#!/bin/bash

SOURCE="/home/user/data"
DEST="/home/user/backup/"
FILENAME="backup-$(date +%Y-%m-%d).tar.gz"

tar -czf "$DEST$FILENAME" "$SOURCE"
``` 
- Save the script and make it executable:
`chmod +x ~/scripts/backup_script.sh`

## Step 2: Schedule with Cron
- Open the crontab editor:
`crontab -e`
- Add the following line at the end of the file:
`0 2 * * * /home/user/scripts/backup_script.sh`

This cron expression means:
- `0` - At minute 0
- `2` - At hour 2 (2:00 AM)
- `*` - Every day of the month
- `*` - Every month
- `*` - Every day of the week

## Step 3: Testing
To verify the backup works:
1. You can test the script manually first: `~/scripts/backup_script.sh`
2. Check the log file: `cat /home/user/backup/backup.log`
3. For testing cron, temporarily change the schedule to `* * * * *` to run every minute
![Cron backup result](./images/cron_backup_result.png)
4. After testing, change it back to `0 2 * * *` for the daily 2 AM schedule


### Task 2: Systemd Service for Website Monitoring
Create and configure a custom systemd service for automatic startup of a script that checks website availability and writes the result to a log file.

### Task 3: System Resource Monitoring Script
Write a script to monitor system resource usage and save the results to a file.

### Task 4: Nginx Access Log Rotation
Configure rotation for the Nginx access log file.