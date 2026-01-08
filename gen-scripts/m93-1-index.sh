#!/bin/bash
#
##### quick list of items to produce.
#
DATE=$(date +"%Y-%m-%d")
LOGFILE=/home/nick/logs/1-index-${DATE}.log
PBF=/home/nick/mapping/mkgmap/pbf_downloads
MAPS=/home/nick/mapping/QMS/Maps
GHUB=/home/nick/Github/Tallguy-mkgmap
#
##  return code checking
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
############# checking if shutdown file exists
if [ -e ${MAPS}/finished_local.txt ]
then
trash-put ${MAPS}/finished_local.txt
echo "finished_local.txt sent to trash" $(date -u)
else
echo "finished_local.txt does not exist" $(date -u)
fi
#
###############  UPDATE THE MAIN EUROPE PBF 
#cd ${GHUB}/pbf-scripts
 
#echo "Updating Europe extract - 30 mins" $(date -u) && ./m93-1-pbf_update.sh
#PROCESS_RETURN
#sleep 10
# 
###############   W Europe Extract  
#if [ -e /home/nick/mapping/mkgmap/pbf_downloads/europe-latest.osm.pbf ]
#then 
#    cd ${GHUB}/pbf-scripts
#    echo "W-Europe extract - 19 mins" $(date -u) && ./m93-pbf-w-europe.sh
#else
#    echo "europe latest does not exist" && exit 1
#fi
#PROCESS_RETURN
#sleep 10  
# 
##################     Large Ave Verte extract create
#cd ${GHUB}/pbf-scripts
#echo "Large Ave Verte extract - 9 mins" $(date -u) && ./m93-pbf-ave-verte-large.sh
#PROCESS_RETURN
#sleep 10
# 
###############  GB EXTRACT 
#cd ${GHUB}/pbf-scripts
#echo "GB extract - 5 mins" $(date -u) && ./m93-pbf-gb.sh
#PROCESS_RETURN
#sleep 10     
# 
###############  TESTING  
#cd ${GHUB}/pbf-scripts
#echo "GB extract - 5 mins" $(date -u) && ./m93-pbf-testing.sh    
#PROCESS_RETURN
#sleep 10 
#
################# SMALL AVENUE VERTE EXTRACT
#cd ${GHUB}/pbf-scripts
#echo "Small Ave Verte extract - 5 mins" $(date -u) && ./m93-pbf-ave-verte.sh
#PROCESS_RETURN
#sleep 10 
# 
################# NORTH SEA CYCLE EXTRACT
#cd ${GHUB}/pbf-scripts
#echo "North Sea Cycle extract - 15 mins" $(date -u) && ./m93-pbf-north-sea-cycle.sh
#PROCESS_RETURN
#sleep 10 


##################  TRIKE MAP
#cd ${GHUB}/trike && echo "Trike Map" $(date -u) && ./mk-trike.sh
#PROCESS_RETURN
#################  CANAL MAP  
#cd ${GHUB}/canal && echo "Canal Map" $(date -u) && ./mk-canal.sh
#PROCESS_RETURN
#################  ELECTRIC WHEELCHAIR MAP
#cd ${GHUB}/electric_wheelchair && echo "Electric Wheelchair" $(date -u) && ./mk-e-wheelchair.sh
#PROCESS_RETURN
################## BARRIERS FILTERED MAP
#cd ${GHUB}/barriers_filtered && echo "Barriers filtered- ? mins" $(date -u) && ./mk-barriers-filtered.sh
#PROCESS_RETURN  
################## SMALL AVENUE VERTE MAP
#cd ${GHUB}/ave-verte && echo "Small Ave Verte map - 22 mins" $(date -u) && ./mk-ave-verte.sh
#PROCESS_RETURN
#sleep 10
################  AVE VERTE Large map create
cd ${GHUB}/ave-verte && echo "Large Ave Verte map - 2hr 50 mins" $(date -u) && ./mk-ave-verte-large.sh
PROCESS_RETURN
sleep 10
################# NORTH SEA CYCLE MAP
cd ${GHUB}/north-sea-cycle && echo "North Sea Cycle map - 1hr 23 mins" $(date -u) && ./mk-north-sea-cycle.sh
PROCESS_RETURN
sleep 10   
################# CANARYS
#echo "Canarys map"  $(date -u) && ./m93-mk-canarys.sh
PROCESS_RETURN
sleep 10 
#
#################FILE SYNC ON DIETPI
echo "sorting the file sync on dietpi" $(date -u)
cd ${GHUB}/gen-scripts
./mk-sync-needed.sh
PROCESS_RETURN
#  Use this line if you wish shutdown after map created.
echo "All finished"  $(date -u) && touch ${MAPS}/finished_local.txt
PROCESS_RETURN
