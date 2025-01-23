#!/bin/bash

#TOMCAT_LOCATE=`locate tomcat | head -n 1`
IP_ADDR=localhost
TOMCAT_PORT=8101
#CHECK_ADDR="http://$IP_ADDR:$TOMCAT_PORT/hbys-web/wss/healdCheck.ajax"
CHECK_ADDR="https://google.com/"
FAIL=0
COUNTER=0

tomcatPid() {
  echo `ps aux | grep org.apache.catalina.startup.Bootstrap | grep -v grep | awk '{ print $2 }'`
}

healdCheckControl() { 
    curl -s "$CHECK_ADDR" | grep true
}

healdCheckControlCounter() { 
    while [ $COUNTER -lt 10 ];
        do    
    
            if [ -z healdCheckControl ] 
            then
                echo " $(date) Tomcat is already running (pid: $pid)"
            else
                let COUNTER=COUNTER+1  
                   
                if [ COUNTER = 10 ] 
                then
                    echo "counteresittir 10"
             
                fi        
            fi
        done
}



main() {
   healdCheckControl
   healdCheckControlCounter
}

main
exit 0



