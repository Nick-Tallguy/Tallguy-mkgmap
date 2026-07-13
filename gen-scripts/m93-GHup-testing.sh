#!/bin/bash
#
##### quick list of items to produce.
#
DATE=$(date +"%Y-%m-%d")
LOGFILE=/home/nick/logs/GHUPDATE-${DATE}.log
GHUB=/home/nick/Github/Tallguy-mkgmap
#
##  return code checking
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
###############  UPDATE GITHUB  
echo "Update Github" && cd ${GHUB} && git checkout main && git pull
PROCESS_RETURN
############# checking if shutdown file exists
if [ -e ${MAPS}/finished_local.txt ]
then
trash-put ${MAPS}/finished_local.txt
echo "finished_local.txt sent to trash" $(date -u)
else
echo "finished_local.txt does not exist" $(date -u)
fi
#
