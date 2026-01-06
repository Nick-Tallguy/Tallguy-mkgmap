#!/bin/bash
################################## 
DATE=$(date +"%Y-%m-%d")  
NME=send
LOGFILE=/home/nick/logs/${NME}-${DATE}.log
DESTINATION=nick@192.168.0.19:/mnt/dietpi_userdata/downloads/
GMAKE=/home/nick/mapping/mkgmap
ZIPPED=${GMAKE}/7-zipped
#
PROCESS_RETURN() {
    if [ $? -eq 0 ]
    then 
        echo "Success" $(date -u)
    else
        echo "Failed script at this point" $(date -u)
        exit 1
    fi
}

## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
scp -r -P 22 ${ZIPPED}/* ${DESTINATION}
PROCESS_RETURN
#
echo "cleaning up - trashing files in 7-zipped folder and Maps folder" $(date -u)
trash-put ${ZIPPED}/*
trash-put ${MAPS}/*
