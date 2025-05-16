#!/bin/bash
# 
DATE=$(date +"%Y-%m-%d")            #
NME=canal
DESC="Tallguy - canal"
FAMILYNME=Tallguy-Canal
GMAKE=/home/nick/mapping/mkgmap
#AREA=great-britain
AREA=testing
POLY=${NC_GMAKE}/mkgmap-resources/${AREA}.poly
NC_GMAKE=/home/nick/ncdata/mapping/Garmin
PBF=/home/nick/mapping/mkgmap/pbf_downloads/${AREA}.osm.pbf
MAPS=/home/nick/mapping/QMS/Maps
TYPS=/home/nick/Github/Tallguy-mkgmap
NC_STYLES=${TYPS}/${NME}
LOGFILE=/home/nick/logs/${NME}-${DATE}.log
SCRIPTS=${TYPS}/gen-scripts
ZIPPED=${GMAKE}/7-zipped
#
## Sorting the logging
exec 3>&1 1>${LOGFILE} 2>&1
trap "echo 'ERROR: An error occurred during execution, check log ${LOGFILE} for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)] " set -x' DEBUG
#
echo "sorting the trash" $(date -u)
cd ${SCRIPTS}
./m93-space.sh
#
cd ${GMAKE}/work
#
## SPLITTER
rm -r ${GMAKE}/splitter/*
echo "starting splitter" $(date -u)
java -Xmx14g -jar ${NC_GMAKE}/mkgmap-progs/splitter-r654/splitter.jar --output=pbf --output-dir=${GMAKE}/splitter --max-nodes=1400000 --mapid=10010001 --geonames-file=${NC_GMAKE}/mkgmap-resources/cities15000.zip   --polygon-file=${NC_GMAKE}${POLY} ${PBF}
#
### MKGMAP 
echo "Starting mkgmap" $(date -u)
rm -r ${GMAKE}/work/*
java -Xms1024m -Xmx14g  -jar ${NC_GMAKE}/mkgmap-progs/mkgmap-r4923/mkgmap.jar -c ${NC_STYLES}/nick.args --family-name=${FAMILYNME} -c ${GMAKE}/splitter/template.args --description="Tallguy - canal" ${NC_STYLES}/5410.txt --gmapsupp --gmapi --nsis   
##
#
echo "moving gmapsupp to qmapshack map folder and renaming" $(date -u)
mv ${GMAKE}/work/gmapsupp.img ${MAPS}/${NME}-${DATE}.img
mv ${GMAKE}/work/*.tdb ${MAPS}/${NME}-${DATE}.tdb
#
echo "all finished" $(date -u)
