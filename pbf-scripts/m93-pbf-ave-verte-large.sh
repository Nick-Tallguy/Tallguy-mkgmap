#!/bin/bash
#
##### This script produces the Large Ave Verte extract
#
DATE=$(date +"%Y-%m-%d")           
NME=ave-verte-12
LOGFILE=/home/nick/logs/pbf-${NME}-${DATE}.log
PBF=/home/nick/mapping/mkgmap/pbf_downloads
PARENT=/home/nick/mapping/mkgmap/pbf_downloads/w-europe.osm.pbf  
GHSCRIPTS=/home/nick/Github/Tallguy-mkgmap/gen-scripts
#
PROCESS_RETURN() {
    if [ $? -eq 0 ]
    then 
        echo "Success"
    else
        echo "Failed script at this point"
        exit 1
    fi
}
## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
echo "sorting the trash. Total time for file creation = 10 mins" $(date -u)
cd ${GHSCRIPTS}
./m93-space.sh
#
cd ${PBF}
#
#
echo "Trash old ${NME} extract & create the new" $(date -u)
if [ -e ${PBF}/${NME}.osm.pbf ]
then
trash-put ${NME}.osm.pbf  
else 
echo "${NME}.osm.pbf not present - cannot be trashed"  $(date -u)
fi
osmium extract -v   -p /home/nick/ncdata/mapping/Garmin/mkgmap-resources/${NME}.poly ${PARENT} -o ${PBF}/${NME}.osm.pbf
PROCESS_RETURN
