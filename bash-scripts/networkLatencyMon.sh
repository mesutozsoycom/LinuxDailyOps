#!/bin/bash
hosts=("8.8.8.8" "1.1.1.1" "google.com")
for host in "${hosts[@]}"; do
if ! ping -c 1 $host &> /dev/null; then
echo "Host $host is unreachable!"
else
latency=$(ping -c 1 $host | grep time= | awk -F 'time=' '{print $2}' | cut -d' ' -f1)
echo "Host $host latency: $latency ms"
fi
done