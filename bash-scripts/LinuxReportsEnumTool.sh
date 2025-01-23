#!/bin/bash
# Date 03.2023
# Author mesut.ozsoy

#2>&1 | tee -a $InstallLog

#Vars
#appPath="+"
getDate=`date +"%Y-%m-%d %T"`
#logFileName=oslog_$(hostname)_$(date +"%d-%m-%Y_%H").log
workDir="/tmp"
#InstallLog=$workDir/$logFileName

# Bolds
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

function rootCheck() {
	if [ "${EUID}" -ne 0 ]; then
		echo -e "Bu Scripti Root Yetkileri ile çalıştırmalısınız!" 
		exit 1
	fi
}

function logCreate() {
    echo $getDate >> "$workDir/$logFileName"
    sleep 3
    echo "*****************************************"
}

function getBasicInfo() {
	echo ""
	echo "[Isletim Sistemi Bilgisi]"
	echo ""
	echo "Hostname      :" $(hostname)
	echo "Linux Kernel  :" $(uname -r)
	echo "OS Type       :" $(grep -E '^(VERSION|NAME)=' /etc/os-release) 
	echo "----------------------------------------------------"
}

function getUserInfo() {
	echo ""
	echo "[Kullanıcı Bilgisi]"
	## get mini UID limit ##
	l=$(grep "^UID_MIN" /etc/login.defs)
	## get max UID limit ##
	l1=$(grep "^UID_MAX" /etc/login.defs)
	## use awk to print if UID >= $MIN and UID <= $MAX   ##
	awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max ) print }' /etc/passwd 
	echo " ------////----////----- "
	cut -d":" -f1 /etc/passwd 2>/dev/null| while read i; do id $i;done 2>/dev/null | sort
	echo "----------------------------------------------------"
}

function getTerminalAccessUser() {
	echo ""
	echo "[Terminal Erişimine Sahip Kullanıcılar]" 
	echo ""
	grep /bin/bash /etc/passwd
	echo "----------------------------------------------------" 
}


function getSudoErs(){
	echo ""
	echo "[Sudo Yetkili Kullanıcılar]" 
	echo ""
	grep -Iv "^$" cat /etc/sudoers | grep -v "#"
	echo "----------------------------------------------------" 
}


function getNetworkInfo() {
  echo ""
  echo " [Ağ Bilgileri]"
  ip -o a s | awk '$3 == "inet" && $2 != "lo" {print $2 ": " $4}' | sed 's/\/.*//'
  echo ""
  echo "----------------------------------------------------"
}


function getDNSInfo() {
  echo ""
  echo "[DNS Server Bilgisi]"
  cat /etc/resolv.conf | grep nameserver
  echo ""
  echo "----------------------------------------------------"
}


function getSiemCheck() {
	echo ""
  	echo "[SIEM Bilgisi]"
	grep -E 'ptt|10.123.22.152' /etc/rsyslog.conf
	echo ""
    echo "----------------------------------------------------"
}

function getActivePorts() {
	echo ""
	echo "[Aktif Portlar]"
	netstat -punta || ss -nltpu || netstat -anv | grep -i listen | sed -e "s,127.0.[0-9]+.[0-9]+|:::|::1:|0\.0\.0\.0"
	echo ""
    echo "----------------------------------------------------"
}

function getLoginInfo() {
 	echo ""
	echo "[Son Oturum Acan Hesaplar]"
 	last -Faiw  | head -n 20
	echo "----------------------------------------------------"
	lastlog | grep "pts/0" | grep -v grep
	echo ""
    echo "----------------------------------------------------"
}
function getPassPolicy() { 
	echo ""
	echo "[Parola Politikasi]"
	grep "^PASS_MAX_DAYS\|^PASS_MIN_DAYS\|^PASS_WARN_AGE\|^ENCRYPT_METHOD" /etc/login.defs
	echo ""
    echo "----------------------------------------------------"
}

function getEnabledServices() { 
	echo ""
	echo "[Akftif Servisler]"
	systemctl list-unit-files --type=service --state=enabled | head -n -1 | tail -n +2
	echo ""
    echo "----------------------------------------------------"
}

function getSecurityModule() { 
	echo ""
	echo "[SElinux Durumu]"
	SELINUX_STATE=$(getenforce)
		if [ "$SELINUX_STATE" == "Enforcing" ]; then
 	 		echo "SELinux Aktif"
		elif [ "$SELINUX_STATE" == "Permissive" ]; then
  			echo "SELinux Permissive"
		else 
  			echo "SELinux DevreDisi / Mevcut Degil)"
		fi
	echo ""
    echo "----------------------------------------------------"
}

#rootCheck
getBasicInfo
getNetworkInfo
getDNSInfo
getUserInfo
getLoginInfo
getTerminalAccessUser
getSudoErs
getPassPolicy
getEnabledServices
getActivePorts
getSecurityModule
getEnabledServices
getSiemCheck