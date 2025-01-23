#!/bin/bash
action=$1
file=$2
output=$3
if [ "$action" == "encrypt" ]; then
openssl enc -aes-256-cbc -salt -in $file -out $output
echo "File encrypted: $output"
elif [ "$action" == "decrypt" ]; then
openssl enc -aes-256-cbc -d -in $file -out $output
echo "File decrypted: $output"
else
echo "Usage: $0 <encrypt|decrypt> <file> <output>"
f