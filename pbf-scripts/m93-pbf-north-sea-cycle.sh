#!/bin/bash
#
##### This script produces an extract to make the North Sea Cycle route map
#
DATE=$(date +"%Y-%m-%d")              # 
NME=north-sea-cycle-5
LOGFILE=/home/nick/logs/pbf-${NME}-${DATE}.log
PBF=/home/nick/mapping/mkgmap/pbf_downloads
PARENT=${PBF}/europe-latest.osm.pbf  
GHUB=/home/nick/Github/Tallguy-mkgmap
MAPS=/home/nick/mapping/QMS/Maps
#
PROCESS_RETURN() {
    if [ $? -eq 0 ]
    then 
        echo "Success" $(date -u)
    else
        echo "Failed script at this point" $(date -u)
        touch ${MAPS}/finished_local.txt
        exit 1
    fi
}

## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
echo "sorting the trash. Total time for file creation = 17 mins approx. 3277 MB max used" $(date -u)
cd ${GHUB}/gen-scripts/gen-scripts
./m93-space.sh
#
cd ${PBF}
##
echo "Trash old ${NME} extract & create the new" $(date -u)
if [ -e ${PBF}/${NME}.osm.pbf ]
then
trash-put ${NME}.osm.pbf  
else 
echo "${NME}.osm.pbf not present - cannot be trashed" $(date -u)  
fi
osmium extract -v -p ${GHUB}/pbf-scripts/poly-files/${NME}.poly ${PARENT} -o ${PBF}/${NME}.osm.pbf
PROCESS_RETURN