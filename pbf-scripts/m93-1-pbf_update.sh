#!/bin/bash
#
##### This script downloads updates from Geofabrik and updates the very large Europe (includes Russia) pbf file.
DATE=$(date +"%Y-%m-%d")
LOGFILE=/home/nick/logs/pbf-europe-update-${DATE}.log
PBF=/home/nick/mapping/mkgmap/pbf_downloads
FULLEUROPE=/home/nick/mapping/mkgmap/pbf_downloads/europe-latest    
GEOF=http://download.geofabrik.de/europe-updates/000/004
GHUB=/home/nick/Github/Tallguy-mkgmap

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

echo "sorting the trash ready for update.  30 mins approx, uses approx 1686 MB ram" $(date -u)
cd ${GHUB}/gen-scripts
./m93-space.sh

######################## Establish the most recent increment file to be used, and the next to be downloaded.
cd ${PBF}
ls -tr [0-9]* | cut -c 1-3 | tail -n 1 | while read HIGHEST;
do
echo "This is the big number $HIGHEST"
NEWLOW=$(($HIGHEST+1))  ; echo "This is the new small number $NEWLOW - now trashing the existing .osc.gz files"  $(date -u)

######################## Establish which is the highest numbered increment file that can be downloaded
trash-put state.txt*

echo "Downloading state.txt from Geofabrik"  $(date -u)
wget http://download.geofabrik.de/europe-updates/state.txt
PROCESS_RETURN
grep sequenceNu $PBF/state.txt | cut -c 17-19 | while read MOST;
do
echo "$MOST is the top number to download"  $(date -u)

#######################  Download the incremental files
cd ${PBF}  
trash-put *.osc.gz
echo "Downloading any update files" $(date -u)
for d in $(seq $NEWLOW $MOST)
do 
wget -nv ${GEOF}/$d.osc.gz
PROCESS_RETURN
done
done
done

mv europe-latest.osm.pbf europe-latest-1.osm.pbf
echo "Updating Full Europe extract" $(date -u)
osmium apply-changes -v ${FULLEUROPE}-1.osm.pbf *.osc.gz -o ${PBF}/europe-latest.osm.pbf
PROCESS_RETURN

trash-put europe-latest-1.osm.pbf
echo "Updated extract safely created - trashed the old one" $(date -u)

