#!/bin/bash
while true; do
iostat -dx 1 5 | awk '/sda/ {print "Device: " $1 ", I/O Utilization: " $14 "%"}'
sleep 10
done