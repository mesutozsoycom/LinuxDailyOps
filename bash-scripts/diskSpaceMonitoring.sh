#!/bin/bash
threshold=80
for partition in $(df -h | grep "^/dev" | awk '{print $5 " " $1}'); do
usage=$(echo $partition | awk '{print $1}' | sed 's/%//')
mount=$(echo $partition | awk '{print $2}')
if [ $usage -ge $threshold ]; then
echo "Warning: $mount is $usage% full."
fi
done