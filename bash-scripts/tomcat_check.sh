#!/bin/bash

TOMCAT_LOCATE=`locate tomcat | head -n 1`
IP_ADDR=localhost
TOMCAT_PORT=8101
CHECK_ADDR="http://$IP_ADDR:$TOMCAT_PORT/hbys-web/wss/healdCheck.ajax"
FAIL=0

tomcatPid() {
  echo `ps aux | grep org.apache.catalina.startup.Bootstrap | grep -v grep | awk '{ print $2 }'`
}

healdCheckControl() { 
    curl -s "$CHECK_ADDR" | grep true
}

pid=$(tomcatPid)
tomcatStart() {
    
  if [ healdCheckControl != 'true' ] 
  then
    echo " $(date) Tomcat is already running (pid: $pid)"
  else
    # Start tomcat
    echo "Starting tomcat"
    #/bin/sh $TOMCAT_LOCATE/bin/update.sh restart
  fi
return 0
}

main() {
   healdCheckControl
   tomcatStart
}

main
exit 0

