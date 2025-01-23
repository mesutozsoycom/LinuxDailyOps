#!/bin/bash
software_list=(git neovim tcpdump nmap lsof iptrack-ng)
for software in "${software_list[@]}"; do
if ! dpkg -l | grep -q $software; then
sudo apt-get install -y $software
echo "$software installed."
else
echo "$software is already installed."
fi
done