#!/bin/bash
src_dir="/data"
backup_dir="/backups"
timestamp=$(date +%Y%m%d_%H%M%S)
backup_file="$backup_dir/backup_$timestamp.tar.gz"
tar -czf $backup_file $src_dir && \
md5sum $backup_file > "$backup_file.md5"
echo "Backup completed: $backup_file"