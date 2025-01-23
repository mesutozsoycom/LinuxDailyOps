#!/bin/bash
cleanup_dirs=("/tmp" "/var/tmp")
for dir in "${cleanup_dirs[@]}"; do
find $dir -type f -atime +7 -exec rm -f {} \;
echo "Cleaned up $dir."
done