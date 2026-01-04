#!/bin/bash
#
##### This script creates the TESTING extract, created 05/11/2023 covering parts of England
#
DATE=$(date +"%Y-%m-%d")
NME=testing
LOGFILE=/home/nick/logs/pbf-${NME}-${DATE}.log
PBF=/home/nick/mapping/mkgmap/pbf_downloads
PARENT=/home/nick/mapping/mkgmap/pbf_downloads/great-britain.osm.pbf  
GHUB=/home/nick/Github/Tallguy-mkgmap
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
echo "sorting the trash." $(date -u)
./home/nick/Github/Tallguy-mkgmap/gen-scripts/m93-space.sh
#
cd ${PBF}
#
echo "Trash old ${NME} extract & create the new" $(date -u)
if [ -e ${PBF}/${NME}.osm.pbf ]
then
trash-put ${NME}.osm.pbf  
else 
echo "${NME}.osm.pbf not present - cannot be trashed" $(date -u)
fi
osmium extract -v -p ${GHUB}/pbf-scripts/poly-files/${NME}.poly ${PARENT} -o ${PBF}/${NME}.osm.pbf
PROCESS_RETURN
