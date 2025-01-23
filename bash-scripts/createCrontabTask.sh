#!/bin/bash
backup_script="/path/to/backup/script.sh"
cron_time="0 3 * * *" # Runs at 3 AM daily
(crontab -l; echo "$cron_time $backup_script") | crontab -
echo "Task scheduled to run daily at 3 AM."